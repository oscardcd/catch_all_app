import 'package:catch_all_app/domain/entities/species.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_index.freezed.dart';
part 'game_index.g.dart';

@freezed
abstract class GameIndex with _$GameIndex {
  factory GameIndex({
    int? gameIndex,
    Species? version,
  }) = _GameIndex;

  factory GameIndex.fromJson(Map<String, dynamic> json) =>
      _$GameIndexFromJson(json);
}
