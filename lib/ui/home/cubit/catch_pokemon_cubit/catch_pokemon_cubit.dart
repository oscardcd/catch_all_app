import 'package:bloc/bloc.dart';
import 'package:catch_all_app/domain/repositories/pokemon_repository.dart';
import 'catch_pokemon_state.dart';

class CatchPokemonCubit extends Cubit<CatchPokemonState> {
  CatchPokemonCubit(this._pokemonRepository) : super(const CatchPokemonState.initial());

  final PokemonRepository _pokemonRepository;

  Future<void> catchPokemon(int id, String name) async {
    emit(const CatchPokemonState.catching());
    try {
      await _pokemonRepository.catchPokemon(name);
      emit(CatchPokemonState.success(id));
    } catch (e) {
      emit(CatchPokemonState.failure(e.toString()));
    }
  }

  void reset() => emit(const CatchPokemonState.initial());
}
