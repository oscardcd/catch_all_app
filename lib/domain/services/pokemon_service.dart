import 'package:catch_all_app/domain/entities/all_pokemons.dart';
import 'package:catch_all_app/domain/repositories/pokemon_repository.dart';
import 'package:injectable/injectable.dart';

abstract class PokemonUseCase {
  Future<AllPokemons?> getAllPokemons(int offset, int limitOfPokemons);
}

@Injectable(as: PokemonUseCase)
class PokemonService implements PokemonUseCase {
  PokemonService(this._pokemonRepository);

  final PokemonRepository _pokemonRepository;
  @override
  Future<AllPokemons?> getAllPokemons(int offset, int limitOfPokemons) {
    return _pokemonRepository.getPokemons(limitOfPokemons, offset);
  }
}
