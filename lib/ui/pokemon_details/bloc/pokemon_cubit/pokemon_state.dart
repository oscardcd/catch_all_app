part of 'pokemon_cubit.dart';

@freezed
class PokemonState with _$PokemonState {
  const factory PokemonState.initial() = _Initial;
  const factory PokemonState.loadInProgress() = _LoadInProgress;
  factory PokemonState.pokemonLoaded(Pokemon pokemon) = _PokemonLoaded;
  factory PokemonState.failure(String error) = _Failure;
}

extension PokemonStateX on PokemonState {
  Pokemon? get pokemon => maybeWhen(pokemonLoaded: (pokemon) => pokemon, orElse: () => null);
}
