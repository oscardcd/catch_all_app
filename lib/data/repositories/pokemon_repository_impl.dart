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

  @override
  Future<Pokemon?> getPokemonByName(String name) async {
    final result = await _api.getPokemonByName(name);

    return switch (result) {
      Success<Pokemon?>(:final data) => data,
      Failure<Pokemon?>(:final error) => throw Exception(error),
      _ => throw Exception('Unknown state'),
    };
  }

  @override
  Future<AllPokemons?> getPokemons(int limitPokemons, int offset) async {
    // 1. Verificar si ya tenemos los pokemons solicitados en local storage (Página completa)
    final cachedSlice = await _getCachedSlice(limitPokemons, offset, strict: true);
    if (cachedSlice != null) {
      return cachedSlice;
    }

    // 2. Si no están en local o la página está incompleta, llamar a la API
    try {
      final result = await _api.getAllPokemons(offset, limitPokemons);

      if (result is Success<AllPokemons?>) {
        final data = result.data;
        if (data != null) {
          await _cachePokemons(data, offset);
        }
        return data;
      }

      // Si la API falla, intentamos devolver lo que tengamos aunque sea parcial
      return await _getCachedSlice(limitPokemons, offset, strict: false);
    } catch (e) {
      // En caso de error de conexión, devolvemos lo que tengamos en local
      return await _getCachedSlice(limitPokemons, offset, strict: false);
    }
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
