import 'package:catch_all_app/domain/entities/all_pokemons.dart';
import 'package:catch_all_app/domain/entities/pokemon.dart';

abstract class PokemonRepository {
  Future<AllPokemons?> getPokemons(
    int limitPokemons,
    int offset,
  );
  Future<Pokemon?> getPokemonByName(String name);
}
