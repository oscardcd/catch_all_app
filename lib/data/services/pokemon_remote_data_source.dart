import 'package:catch_all_app/domain/entities/all_pokemons.dart';
import 'package:catch_all_app/domain/entities/pokemon.dart';
import 'package:client_api/api/model/api_result.dart';

abstract class PokemonRemoteDataSource {
  Future<ApiResult<AllPokemons?>> getAllPokemons(int offSet, int limitPokemons);
  Future<ApiResult<Pokemon?>> getPokemonByName(String name);
}
