import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:catch_all_app/domain/entities/pokemon.dart';
import 'package:catch_all_app/domain/repositories/pokemon_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_state.dart';
part 'pokemon_cubit.freezed.dart';

class PokemonCubit extends Cubit<PokemonState> {
  PokemonCubit(this._pokemonRepository) : super(const PokemonState.initial());

  final PokemonRepository _pokemonRepository;

  Future<void> fetchPokemonDetails(String name) async {
    emit(const PokemonState.loadInProgress());
    try {
      final result = await _pokemonRepository.getPokemonByName(name);
      if (result != null) {
        emit(PokemonState.pokemonLoaded(result));
      } else {
        emit(PokemonState.failure('Pokemon not found'));
      }
    } on Exception catch (e) {
      emit(PokemonState.failure(e.toString()));
    }
  }
}
