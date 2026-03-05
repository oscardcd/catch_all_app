import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:catch_all_app/domain/entities/pokemon.dart';
import 'package:catch_all_app/domain/repositories/pokemon_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_state.dart';
part 'pokemon_event.dart';
part '../pokemon_bloc.freezed.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc(this._pokemonRepository) : super(const PokemonState.initial()) {
    on<_FetchPokemon>(_fetchPokemonsToState);
  }

  final PokemonRepository _pokemonRepository;

  FutureOr<void> _fetchPokemonsToState(_FetchPokemon event, Emitter<PokemonState> emit) async {
    emit(const PokemonState.loadInProgress());
    try {
      final result = await _pokemonRepository.getPokemons(6, 0);

      emit(PokemonState.pokemonsLoaded(result?.results ?? []));
    } on Exception catch (e) {
      emit(PokemonState.failure(e.toString()));
    }
  }
}
