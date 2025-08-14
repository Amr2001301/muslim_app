import 'package:equatable/equatable.dart';
import 'package:muslim_app/features/pray/domain/entitiy/pray_entity/data_pray_info_entity.dart';

import 'gregorian.dart';
import 'hijri.dart';

class DatePray extends Equatable {
  final String? readable;
  final String? timestamp;
  final Hijri? hijri;
  final Gregorian? gregorian;

  const DatePray({this.readable, this.timestamp, this.hijri, this.gregorian});

  factory DatePray.fromJson(Map<String, dynamic> json) => DatePray(
    readable: json['readable'] as String?,
    timestamp: json['timestamp'] as String?,
    hijri: json['hijri'] == null
        ? null
        : Hijri.fromJson(json['hijri'] as Map<String, dynamic>),
    gregorian: json['gregorian'] == null
        ? null
        : Gregorian.fromJson(json['gregorian'] as Map<String, dynamic>),
  );

  DataPrayInfoEntity toEntity() {
    return DataPrayInfoEntity(
      gregorian: gregorian?.toEntity(),
      readable: readable,
      hijri: hijri?.toEntity(),
    );
  }

  Map<String, dynamic> toJson() => {
    'readable': readable,
    'timestamp': timestamp,
    'hijri': hijri?.toJson(),
    'gregorian': gregorian?.toJson(),
  };

  @override
  List<Object?> get props => [readable, timestamp, hijri, gregorian];
}
