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
    try {
      final result = await _api.getAllPokemons(offset, limitPokemons);

      if (result is Success<AllPokemons?>) {
        final data = result.data;
        if (data != null) {
          await _cachePokemons(data, offset);
        }
        return data;
      }

      // If it's a failure (e.g. 404, 500), try to load from cache
      return await _getCachedSlice(limitPokemons, offset);
    } catch (e) {
      // On any error (connection, etc.), try to load from cache
      return await _getCachedSlice(limitPokemons, offset);
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

  Future<AllPokemons?> _getCachedSlice(int limit, int offset) async {
    final cached = await _getCachedPokemons();
    if (cached == null) return null;

    final results = cached.results;
    if (results == null || offset >= results.length) {
      return cached.copyWith(results: []);
    }

    final end = (offset + limit).clamp(0, results.length);
    final slice = results.sublist(offset, end);

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
