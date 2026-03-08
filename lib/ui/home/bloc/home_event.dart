part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.loadInitialPokemons() = _LoadInitialPokemons;
  const factory HomeEvent.loadMorePokemons() = _LoadMorePokemons;
  const factory HomeEvent.toggleFavorite(int pokemonId) = _ToggleFavorite;
  const factory HomeEvent.catchPokemon(int pokemonId) = _CatchPokemon;
}
