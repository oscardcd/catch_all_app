import 'package:catch_poke_app/data/model/all_pokemons.dart';
import 'package:catch_poke_app/data/model/pokemon.dart';
import 'package:catch_poke_app/domain/repositories/pokemon_repository.dart';
import 'package:injectable/injectable.dart';

abstract class PokemonUseCase {
  Future<AllPokemons?> getAllPokemons(int offset, int limitOfPokemons);
}

@Injectable(as: PokemonUseCase)
class PokemonUseCaseImpl implements PokemonUseCase {
  PokemonUseCaseImpl(this._pokemonRepository);

  final PokemonRepository _pokemonRepository;
  @override
  Future<AllPokemons?> getAllPokemons(int offset, int limitOfPokemons) {
    return _pokemonRepository.getPokemons(limitOfPokemons, offset);
  }
}
