import 'package:catch_all_app/domain/entities/all_pokemons.dart';
import 'package:catch_all_app/domain/entities/pokemon.dart';
import 'package:catch_all_app/domain/repositories/pokemon_repository.dart';
import 'package:catch_all_app/data/services/pokemon_remote_data_source.dart';
import 'package:client_api/api/model/api_result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PokemonRepository)
class PokemonRepositoryImpl implements PokemonRepository {
  PokemonRepositoryImpl(this._api);
  final PokemonRemoteDataSource _api;
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
    final result = await _api.getAllPokemons(offset, limitPokemons);

    return switch (result) {
      Success<AllPokemons?>(data: final success) => success,
      Failure<AllPokemons?>(:final error) => throw Exception(error),
      _ => throw Exception('Unknown state'),
    };
  }
}
