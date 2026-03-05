import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:catch_all_app/domain/repositories/pokemon_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

/// Lightweight entry from the list endpoint – only name & id (derived from url).
class PokemonEntry {
  const PokemonEntry({required this.id, required this.name});

  final int id;
  final String name;

  String get spriteUrl => 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._pokemonRepository) : super(const HomeState.initial()) {
    on<_LoadInitialPokemons>(_onLoadInitialPokemons);
    on<_LoadMorePokemons>(_onLoadMorePokemons);
    on<_ToggleFavorite>(_onToggleFavorite);
  }

  final PokemonRepository _pokemonRepository;

  static const int _initialLimit = 150;
  static const int _pageSize = 50;

  FutureOr<void> _onLoadInitialPokemons(
    _LoadInitialPokemons event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState.loading());
    try {
      final result = await _pokemonRepository.getPokemons(_initialLimit, 0);
      final count = result?.count ?? 0;
      final entries = _buildEntries(result?.results ?? [], 0);
      emit(HomeState.loaded(
        allPokemons: entries,
        favoriteIds: const [],
        hasMore: entries.length < count,
        currentOffset: entries.length,
      ));
    } catch (e) {
      emit(HomeState.failure(e.toString()));
    }
  }

  FutureOr<void> _onLoadMorePokemons(
    _LoadMorePokemons event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is! _Loaded) return;

    emit(HomeState.loadingMore(
      allPokemons: currentState.allPokemons,
      favoriteIds: currentState.favoriteIds,
      currentOffset: currentState.currentOffset,
    ));

    try {
      final result = await _pokemonRepository.getPokemons(
        _pageSize,
        currentState.currentOffset,
      );
      final count = result?.count ?? 0;
      final newEntries = _buildEntries(
        result?.results ?? [],
        currentState.currentOffset,
      );
      final merged = [...currentState.allPokemons, ...newEntries];
      emit(HomeState.loaded(
        allPokemons: merged,
        favoriteIds: currentState.favoriteIds,
        hasMore: merged.length < count,
        currentOffset: merged.length,
      ));
    } catch (e) {
      // Revert to previous loaded state on error
      emit(HomeState.loaded(
        allPokemons: currentState.allPokemons,
        favoriteIds: currentState.favoriteIds,
        hasMore: true,
        currentOffset: currentState.currentOffset,
      ));
    }
  }

  FutureOr<void> _onToggleFavorite(
    _ToggleFavorite event,
    Emitter<HomeState> emit,
  ) {
    final currentState = state;
    List<int> favorites;
    List<PokemonEntry> allPokemons;
    bool hasMore;
    int currentOffset;

    if (currentState is _Loaded) {
      favorites = currentState.favoriteIds;
      allPokemons = currentState.allPokemons;
      hasMore = currentState.hasMore;
      currentOffset = currentState.currentOffset;
    } else if (currentState is _LoadingMore) {
      favorites = currentState.favoriteIds;
      allPokemons = currentState.allPokemons;
      hasMore = true;
      currentOffset = currentState.currentOffset;
    } else {
      return null;
    }

    final updated = favorites.contains(event.pokemonId)
        ? favorites.where((id) => id != event.pokemonId).toList()
        : [...favorites, event.pokemonId];

    emit(HomeState.loaded(
      allPokemons: allPokemons,
      favoriteIds: updated,
      hasMore: hasMore,
      currentOffset: currentOffset,
    ));
  }

  List<PokemonEntry> _buildEntries(List<dynamic> results, int offset) {
    final entries = <PokemonEntry>[];
    for (var i = 0; i < results.length; i++) {
      final item = results[i];
      final id = offset + i + 1;
      final rawName = item?.name;
      final name = rawName is String ? rawName : 'unknown';
      entries.add(PokemonEntry(id: id, name: name));
    }
    return entries;
  }
}
