import 'package:catch_poke_app/data/model/all_pokemons.dart';
import 'package:catch_poke_app/data/model/pokemon.dart';
import 'package:client_api/api/model/api_result.dart';

abstract class PokemonApi {
  Future<ApiResult<AllPokemons?>> getAllPokemons(int offSet, int limitPokemons);
  Future<ApiResult<Pokemon?>> getPokemonByName(String name);
}
