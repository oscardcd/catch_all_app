import 'package:catch_poke_app/data/model/pokemon.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_pokemons.freezed.dart';
part 'all_pokemons.g.dart';

@freezed
class AllPokemons with _$AllPokemons {
  factory AllPokemons({
    int? count,
    String? next,
    String? previous,
    List<Pokemon>? results,
  }) = _AllPokemons;

  factory AllPokemons.fromJson(Map<String, dynamic> json) => _$AllPokemonsFromJson(json);
}
