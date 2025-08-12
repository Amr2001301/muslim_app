import 'package:equatable/equatable.dart';
import 'package:muslim_app/features/pray/domain/entitiy/month_entity.dart';
import 'package:muslim_app/features/pray/domain/entitiy/weekday_entity.dart';

class HijriTimeEntity extends Equatable {
  final String? date;
  final String? format;
  final String? day;
  final WeekdayEntity? weekday;
  final MonthEntity? month;

  const HijriTimeEntity({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
  });

  @override
  List<Object?> get props => [date, format, day, weekday, month];
}
