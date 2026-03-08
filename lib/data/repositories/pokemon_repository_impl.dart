import 'dart:convert';
import 'package:catch_all_app/domain/entities/all_pokemons.dart';
import 'package:catch_all_app/domain/entities/pokemon.dart';
import 'package:catch_all_app/domain/repositories/pokemon_repository.dart';
import 'package:catch_all_app/domain/services/pokemon_service.dart';
import 'package:client_api/client_api.dart';
import 'package:local_storage/local_storage.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  PokemonRepositoryImpl(this._api, this._localStorage);
  final PokemonService _api;
  final LocalStorage _localStorage;

  static const String _pokemonBox = 'pokemon_box';
  static const String _allPokemonsKey = 'all_pokemons';
  static const String _caughtIdsKey = 'caught_ids';

  @override
  Future<void> catchPokemon(String name) async {
    final caughtIds = await _getCaughtIds();

    // 1. Validar si ya tenemos la información completa en BD
    final cachedSet = await _getCachedPokemons();
    Pokemon? pokemon = cachedSet?.results?.firstWhere((p) => p.name == name, orElse: () => Pokemon(name: name));

    // Si no tiene stats, es probable que solo tengamos el id/nombre y no el detalle completo
    if (pokemon == null || pokemon.id == null || pokemon.stats == null || pokemon.stats!.isEmpty) {
      final result = await _api.getPokemonByName(name);
      if (result is Success<Pokemon?> && result.data != null) {
        pokemon = result.data;
      }
    }

    if (pokemon != null && pokemon.id != null) {
      // 2. Guardar ID como capturado si no está ya
      if (!caughtIds.contains(pokemon.id)) {
        caughtIds.add(pokemon.id!);
        await _localStorage.put(_pokemonBox, _caughtIdsKey, jsonEncode(caughtIds));
      }

      // 3. Guardar el objeto completo (ya sea nuevo o actualizado) como capturado
      await _updateSinglePokemonCache(pokemon.copyWith(isCaught: true));
    }
  }

  Future<void> _updateSinglePokemonCache(Pokemon pokemon) async {
    final cached = await _getCachedPokemons() ?? AllPokemons(results: []);

    final results = cached.results ?? [];
    bool found = false;
    final updatedResults = results.map((p) {
      if (p.name == pokemon.name) {
        found = true;
        return pokemon;
      }
      return p;
    }).toList();

    if (!found) {
      updatedResults.add(pokemon);
    }

    final updatedData = cached.copyWith(results: updatedResults);
    await _localStorage.put(_pokemonBox, _allPokemonsKey, jsonEncode(updatedData.toJson()));
  }

  Future<List<int>> _getCaughtIds() async {
    try {
      final jsonString = await _localStorage.get<String>(_pokemonBox, _caughtIdsKey);
      if (jsonString != null) {
        return List<int>.from(jsonDecode(jsonString));
      }
    } catch (_) {}
    return [];
  }

  @override
  Future<Pokemon?> getPokemonByName(String name) async {
    // 1. Intentar obtener de local storage si tiene información completa
    final cachedSet = await _getCachedPokemons();
    final cachedPokemon = cachedSet?.results?.firstWhere((p) => p.name == name, orElse: () => Pokemon(name: name));

    if (cachedPokemon != null && cachedPokemon.stats != null && cachedPokemon.stats!.isNotEmpty) {
      final caughtIds = await _getCaughtIds();
      return cachedPokemon.copyWith(isCaught: caughtIds.contains(cachedPokemon.id));
    }

    // 2. Si no hay cache completo, consultar API
    final result = await _api.getPokemonByName(name);

    if (result is Success<Pokemon?>) {
      final pokemon = result.data;
      if (pokemon != null && pokemon.id != null) {
        await _updateSinglePokemonCache(pokemon);
        final caughtIds = await _getCaughtIds();
        return pokemon.copyWith(isCaught: caughtIds.contains(pokemon.id));
      }
      return pokemon;
    } else if (result is Failure<Pokemon?>) {
      throw Exception(result.error);
    }
    throw Exception('Unknown state');
  }

  @override
  Future<AllPokemons?> getPokemons(int limitPokemons, int offset) async {
    // 1. Verificar si ya tenemos los pokemons solicitados en local storage
    final cachedSlice = await _getCachedSlice(limitPokemons, offset, strict: true);
    if (cachedSlice != null) {
      return _applyCaughtStatus(cachedSlice);
    }

    // 2. Si no están en local o la página está incompleta, llamar a la API
    try {
      final result = await _api.getAllPokemons(offset, limitPokemons);

      if (result is Success<AllPokemons?>) {
        final data = result.data;
        if (data != null) {
          await _cachePokemons(data, offset);
        }
        return data != null ? await _applyCaughtStatus(data) : null;
      }

      final fallback = await _getCachedSlice(limitPokemons, offset, strict: false);
      return fallback != null ? await _applyCaughtStatus(fallback) : null;
    } catch (e) {
      final fallback = await _getCachedSlice(limitPokemons, offset, strict: false);
      return fallback != null ? await _applyCaughtStatus(fallback) : null;
    }
  }

  Future<AllPokemons> _applyCaughtStatus(AllPokemons data) async {
    final caughtIds = await _getCaughtIds();
    final updatedResults = data.results?.map((p) {
      if (p.id != null) {
        return p.copyWith(isCaught: caughtIds.contains(p.id));
      }
      return p;
    }).toList();
    return data.copyWith(results: updatedResults);
  }

  Future<void> _cachePokemons(AllPokemons data, int offset) async {
    final cached = await _getCachedPokemons();

    AllPokemons updatedData;
    if (offset == 0 || cached == null) {
      // First page or no cache, replace
      updatedData = data;
    } else {
      // Append new results to cached ones
      // We use a Map to avoid duplicates by name
      final resultsMap = {for (final p in cached.results ?? <Pokemon>[]) p.name: p};
      for (final p in data.results ?? <Pokemon>[]) {
        if (p.name != null) {
          resultsMap[p.name!] = p;
        }
      }

      updatedData = cached.copyWith(results: resultsMap.values.toList(), next: data.next, count: data.count);
    }

    await _localStorage.put(_pokemonBox, _allPokemonsKey, jsonEncode(updatedData.toJson()));
  }

  Future<AllPokemons?> _getCachedSlice(int limit, int offset, {bool strict = false}) async {
    final cached = await _getCachedPokemons();
    if (cached == null) return null;

    final results = cached.results;
    if (results == null || results.isEmpty) return null;

    if (offset >= results.length) return null;

    final end = (offset + limit).clamp(0, results.length);
    final slice = results.sublist(offset, end);

    // Si es estricto, solo devolvemos si tenemos la página solicitada completa
    // O si ya tenemos todos los pokemons que existen según el count total
    if (strict && slice.length < limit) {
      final totalCount = cached.count ?? 0;
      if (results.length < totalCount) {
        return null; // Necesitamos cargar más de la API
      }
    }

    return cached.copyWith(results: slice);
  }

  Future<AllPokemons?> _getCachedPokemons() async {
    try {
      final jsonString = await _localStorage.get<String>(_pokemonBox, _allPokemonsKey);
      if (jsonString != null) {
        return AllPokemons.fromJson(jsonDecode(jsonString));
      }
    } catch (e) {
      // silent error, we return null
    }
    return null;
  }
}
