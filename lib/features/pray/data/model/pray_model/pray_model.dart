import 'package:equatable/equatable.dart';
import 'package:muslim_app/features/pray/domain/entitiy/pray_entity.dart';

import 'date_pray.dart';
import 'meta.dart';
import 'timings.dart';

class PrayModel extends Equatable {
  final Timings? timings;
  final DatePray? date;
  final Meta? meta;

  PrayEntity toEntity() {
    return PrayEntity(
      timingEntity: timings!.toEntity(),
      dataInfoEntity: date!.toEntity(),
    );
  }

  const PrayModel({this.timings, this.date, this.meta});

  factory PrayModel.fromJson(Map<String, dynamic> json) => PrayModel(
    timings: json['timings'] == null
        ? null
        : Timings.fromJson(json['timings'] as Map<String, dynamic>),
    date: json['date'] == null
        ? null
        : DatePray.fromJson(json['date'] as Map<String, dynamic>),
    meta: json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'timings': timings?.toJson(),
    'date': date?.toJson(),
    'meta': meta?.toJson(),
  };

  @override
  List<Object?> get props => [timings, date, meta];
}
