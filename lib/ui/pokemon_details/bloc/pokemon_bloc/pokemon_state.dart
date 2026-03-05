part of 'pokemon_bloc.dart';

@freezed
class PokemonState with _$PokemonState {
  const factory PokemonState.initial() = _Initial;
  const factory PokemonState.loadInProgress() = _LoadInProgress;
  factory PokemonState.pokemonsLoaded(List<Pokemon> pokemons) = _pokemonLoaded;
  factory PokemonState.failure(String error) = _Failure;
}
