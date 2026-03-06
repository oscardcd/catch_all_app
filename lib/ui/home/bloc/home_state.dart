part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = _Loading;
  const factory HomeState.loaded({
    required List<PokemonEntry> allPokemons,
    required List<int> favoriteIds,
    required bool hasMore,
    required int currentOffset,
  }) = _Loaded;
  const factory HomeState.loadingMore({
    required List<PokemonEntry> allPokemons,
    required List<int> favoriteIds,
    required int currentOffset,
  }) = _LoadingMore;
  const factory HomeState.failure(String message) = _Failure;
}
