import 'package:catch_all_app/domain/entities/ability.dart';
import 'package:catch_all_app/domain/entities/cries.dart';
import 'package:catch_all_app/domain/entities/game_index.dart';
import 'package:catch_all_app/domain/entities/held_item.dart';
import 'package:catch_all_app/domain/entities/move.dart';
import 'package:catch_all_app/domain/entities/past_ability.dart';
import 'package:catch_all_app/domain/entities/past_stat.dart';
import 'package:catch_all_app/domain/entities/pokemon_type.dart';
import 'package:catch_all_app/domain/entities/species.dart';
import 'package:catch_all_app/domain/entities/stat.dart';
import 'package:catch_all_app/domain/entities/sprites.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon.freezed.dart';
part 'pokemon.g.dart';

@freezed
abstract class Pokemon with _$Pokemon {
  factory Pokemon({
    List<Ability>? abilities,
    @JsonKey(name: 'base_experience') int? baseExperience,
    Cries? cries,
    List<Species>? forms,
    @JsonKey(name: 'game_indices') List<GameIndex>? gameIndices,
    int? height,
    @JsonKey(name: 'held_items') List<HeldItem>? heldItems,
    int? id,
    @JsonKey(name: 'is_default') bool? isDefault,
    @JsonKey(name: 'location_area_encounters') String? locationAreaEncounters,
    List<Move>? moves,
    String? name,
    int? order,
    @JsonKey(name: 'past_abilities') List<PastAbility>? pastAbilities,
    @JsonKey(name: 'past_stats') List<PastStat>? pastStats,
    @JsonKey(name: 'past_types') List<dynamic>? pastTypes,
    Species? species,
    List<Stat>? stats,
    @Default([]) List<PokemonType> types,
    int? weight,
    Sprites? sprites,
    @Default(false) bool? isCaught,
  }) = _Pokemon;

  factory Pokemon.fromJson(Map<String, dynamic> json) => _$PokemonFromJson(json);
}
