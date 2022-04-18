import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:catch_poke_app/data/model/pokemon.dart';
import 'package:catch_poke_app/domain/use_case/pokemon_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'pokemon_state.dart';
part 'pokemon_event.dart';
part 'pokemon_bloc.freezed.dart';

@injectable
class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc(this._useCase) : super(const PokemonState.initial()) {
    on<_FetchPokemon>(_fetchPokemonsToState);
  }

  final PokemonUseCase _useCase;

  FutureOr<void> _fetchPokemonsToState(event, Emitter<PokemonState> emit) async {
    emit(const PokemonState.loadInProgress());
    try {
      final result = await _useCase.getAllPokemons(0, 6);

      emit(PokemonState.pokemonsLoaded(result?.results ?? []));
    } on Exception catch (e) {
      emit(PokemonState.failure(e.toString()));
    }
  }
}
