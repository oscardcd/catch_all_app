import 'package:catch_poke_app/data/model/ability.dart';
import 'package:catch_poke_app/data/model/game_index.dart';
import 'package:catch_poke_app/data/model/pokemon_type.dart';
import 'package:catch_poke_app/data/model/species.dart';
import 'package:catch_poke_app/data/model/stat.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon.freezed.dart';
part 'pokemon.g.dart';

@freezed
class Pokemon with _$Pokemon {
  factory Pokemon({
    List<Ability>? abilities,
    int? baseExperience,
    List<Species>? forms,
    List<GameIndex>? gameIndices,
    int? height,
    int? id,
    bool? isDefault,
    String? locationAreaEncounters,
    String? name,
    int? order,
    Species? species,
    List<Stat>? stats,
    @Default([]) List<PokemonType> types,
    int? weight,
  }) = _Pokemon;

  factory Pokemon.fromJson(Map<String, dynamic> json) => _$PokemonFromJson(json);
}
