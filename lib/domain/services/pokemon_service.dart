import 'package:catch_all_app/domain/entities/all_pokemons.dart';
import 'package:catch_all_app/domain/entities/pokemon.dart';
import 'package:client_api/client_api.dart';

abstract class PokemonService {
  Future<ApiResult<AllPokemons?>> getAllPokemons(int offSet, int limitOfPokemons);
  Future<ApiResult<Pokemon?>> getPokemonByName(String name);
}
