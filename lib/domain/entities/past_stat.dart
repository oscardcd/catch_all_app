import 'package:catch_all_app/domain/entities/species.dart';
import 'package:catch_all_app/domain/entities/stat.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'past_stat.freezed.dart';
part 'past_stat.g.dart';

@freezed
abstract class PastStat with _$PastStat {
  factory PastStat({
    Species? generation,
    List<Stat>? stats,
  }) = _PastStat;

  factory PastStat.fromJson(Map<String, dynamic> json) => _$PastStatFromJson(json);
}
