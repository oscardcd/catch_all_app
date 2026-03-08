import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:catch_all_app/domain/repositories/pokemon_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

/// Lightweight entry from the list endpoint – only name & id (derived from url).
class PokemonEntry {
  const PokemonEntry({required this.id, required this.name, this.isCaught = false});

  final int id;
  final String name;
  final bool isCaught;

  PokemonEntry copyWith({bool? isCaught}) {
    return PokemonEntry(id: id, name: name, isCaught: isCaught ?? this.isCaught);
  }

  String get spriteUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._pokemonRepository) : super(const HomeState.initial()) {
    on<_LoadInitialPokemons>(_onLoadInitialPokemons);
    on<_LoadMorePokemons>(_onLoadMorePokemons);
    on<_ToggleFavorite>(_onToggleFavorite);
    on<_CatchPokemon>(_onCatchPokemon);
  }

  final PokemonRepository _pokemonRepository;

  static const int _initialLimit = 150;
  static const int _pageSize = 50;

  FutureOr<void> _onLoadInitialPokemons(_LoadInitialPokemons event, Emitter<HomeState> emit) async {
    emit(const HomeState.loading());
    try {
      final result = await _pokemonRepository.getPokemons(_initialLimit, 0);
      final count = result?.count ?? 0;
      final entries = _buildEntries(result?.results ?? [], 0, const []);
      emit(
        HomeState.loaded(
          allPokemons: entries,
          favoriteIds: const [],
          caughtIds: const [],
          hasMore: entries.length < count,
          currentOffset: entries.length,
        ),
      );
    } catch (e) {
      emit(HomeState.failure(e.toString()));
    }
  }

  FutureOr<void> _onLoadMorePokemons(_LoadMorePokemons event, Emitter<HomeState> emit) async {
    final currentState = state;
    if (currentState is! _Loaded) return;

    emit(
      HomeState.loadingMore(
        allPokemons: currentState.allPokemons,
        favoriteIds: currentState.favoriteIds,
        caughtIds: currentState.caughtIds,
        currentOffset: currentState.currentOffset,
      ),
    );

    try {
      final result = await _pokemonRepository.getPokemons(_pageSize, currentState.currentOffset);
      final count = result?.count ?? 0;
      final newEntries = _buildEntries(result?.results ?? [], currentState.currentOffset, currentState.caughtIds);
      final merged = [...currentState.allPokemons, ...newEntries];
      emit(
        HomeState.loaded(
          allPokemons: merged,
          favoriteIds: currentState.favoriteIds,
          caughtIds: currentState.caughtIds,
          hasMore: merged.length < count,
          currentOffset: merged.length,
        ),
      );
    } catch (e) {
      // Revert to previous loaded state on error
      emit(
        HomeState.loaded(
          allPokemons: currentState.allPokemons,
          favoriteIds: currentState.favoriteIds,
          caughtIds: currentState.caughtIds,
          hasMore: true,
          currentOffset: currentState.currentOffset,
        ),
      );
    }
  }

  FutureOr<void> _onToggleFavorite(_ToggleFavorite event, Emitter<HomeState> emit) {
    state.maybeWhen(
      loaded: (allPokemons, favoriteIds, caughtIds, hasMore, currentOffset) {
        if (!caughtIds.contains(event.pokemonId)) return;

        final updated = Set<int>.from(favoriteIds);
        if (updated.contains(event.pokemonId)) {
          updated.remove(event.pokemonId);
        } else {
          updated.add(event.pokemonId);
        }

        emit(
          HomeState.loaded(
            allPokemons: allPokemons,
            favoriteIds: updated.toList(),
            caughtIds: caughtIds,
            hasMore: hasMore,
            currentOffset: currentOffset,
          ),
        );
      },
      loadingMore: (allPokemons, favoriteIds, caughtIds, currentOffset) {
        if (!caughtIds.contains(event.pokemonId)) return;

        final updated = Set<int>.from(favoriteIds);
        if (updated.contains(event.pokemonId)) {
          updated.remove(event.pokemonId);
        } else {
          updated.add(event.pokemonId);
        }

        emit(
          HomeState.loadingMore(
            allPokemons: allPokemons,
            favoriteIds: updated.toList(),
            caughtIds: caughtIds,
            currentOffset: currentOffset,
          ),
        );
      },
      orElse: () {},
    );
  }

  FutureOr<void> _onCatchPokemon(_CatchPokemon event, Emitter<HomeState> emit) {
    state.maybeWhen(
      loaded: (allPokemons, favoriteIds, caughtIds, hasMore, currentOffset) {
        if (caughtIds.contains(event.pokemonId)) return; // Already in state

        final updatedCaught = Set<int>.from(caughtIds)..add(event.pokemonId);

        final updatedAll = allPokemons.map((p) {
          if (p.id == event.pokemonId) {
            return p.copyWith(isCaught: true);
          }
          return p;
        }).toList();

        emit(
          HomeState.loaded(
            allPokemons: updatedAll,
            favoriteIds: favoriteIds,
            caughtIds: updatedCaught.toList(),
            hasMore: hasMore,
            currentOffset: currentOffset,
          ),
        );
      },
      loadingMore: (allPokemons, favoriteIds, caughtIds, currentOffset) {
        if (caughtIds.contains(event.pokemonId)) return; // Already in state

        final updatedCaught = Set<int>.from(caughtIds)..add(event.pokemonId);

        final updatedAll = allPokemons.map((p) {
          if (p.id == event.pokemonId) {
            return p.copyWith(isCaught: true);
          }
          return p;
        }).toList();

        emit(
          HomeState.loadingMore(
            allPokemons: updatedAll,
            favoriteIds: favoriteIds,
            caughtIds: updatedCaught.toList(),
            currentOffset: currentOffset,
          ),
        );
      },
      orElse: () {},
    );
  }

  List<PokemonEntry> _buildEntries(List<dynamic> results, int offset, List<int> caughtIds) {
    final entries = <PokemonEntry>[];
    for (var i = 0; i < results.length; i++) {
      final item = results[i];
      final id = offset + i + 1;
      final rawName = item?.name;
      final name = rawName is String ? rawName : 'unknown';
      entries.add(PokemonEntry(id: id, name: name, isCaught: caughtIds.contains(id)));
    }
    return entries;
  }
}
