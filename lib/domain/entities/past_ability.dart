import 'package:catch_all_app/domain/entities/ability.dart';
import 'package:catch_all_app/domain/entities/species.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'past_ability.freezed.dart';
part 'past_ability.g.dart';

@freezed
abstract class PastAbility with _$PastAbility {
  factory PastAbility({
    List<Ability>? abilities,
    Species? generation,
  }) = _PastAbility;

  factory PastAbility.fromJson(Map<String, dynamic> json) => _$PastAbilityFromJson(json);
}
