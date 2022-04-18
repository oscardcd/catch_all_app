import 'package:catch_poke_app/data/model/all_pokemons.dart';
import 'package:catch_poke_app/data/model/pokemon.dart';
import 'package:catch_poke_app/domain/repositories/pokemon_repository.dart';
import 'package:catch_poke_app/domain/services/pokemon_api.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PokemonRepository)
class PokemonRepositoryImpl implements PokemonRepository {
  PokemonRepositoryImpl(this._api);
  final PokemonApi _api;
  @override
  Future<Pokemon?> getPokemonByName(String name) async {
    final result = await _api.getPokemonByName(name);

    return result.when(
      success: (Pokemon? data) => data,
      failure: (error) => throw Exception(error),
    );
  }

  @override
  Future<AllPokemons?> getPokemons(int limitPokemons, int offset) async {
    final result = await _api.getAllPokemons(offset, limitPokemons);

    return result.when(
      success: (success) => success,
      failure: (error) => throw Exception(error),
    );
  }
}
