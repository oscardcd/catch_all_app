import 'package:catch_poke_app/data/model/all_pokemons.dart';
import 'package:catch_poke_app/data/model/pokemon.dart';

abstract class PokemonRepository {
  Future<AllPokemons?> getPokemons(
    int limitPokemons,
    int offset,
  );
  Future<Pokemon?> getPokemonByName(String name);
}
