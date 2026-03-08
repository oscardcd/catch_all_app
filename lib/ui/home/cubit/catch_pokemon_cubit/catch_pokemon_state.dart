import 'package:freezed_annotation/freezed_annotation.dart';

part 'catch_pokemon_state.freezed.dart';

@freezed
class CatchPokemonState with _$CatchPokemonState {
  const factory CatchPokemonState.initial() = _Initial;
  const factory CatchPokemonState.catching() = _Catching;
  const factory CatchPokemonState.success(int pokemonId) = _Success;
  const factory CatchPokemonState.failure(String error) = _Failure;
}
