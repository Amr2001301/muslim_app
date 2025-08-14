import 'package:equatable/equatable.dart';
import 'package:muslim_app/features/pray/domain/entitiy/pray_entity/pray_entity.dart';

abstract class PrayState extends Equatable {
  const PrayState();
  @override
  List<Object?> get props => [];
}

class PrayInitial extends PrayState {}

class PrayLoading extends PrayState {}

class PraySuccess extends PrayState {
  final PrayEntity prayEntity;
  final String nextPrayerName;
  final DateTime nextPrayerTime;

  const PraySuccess({
    required this.prayEntity,
    required this.nextPrayerName,
    required this.nextPrayerTime,
  });

  @override
  List<Object?> get props => [prayEntity, nextPrayerName, nextPrayerTime];
}

class PrayFailure extends PrayState {
  final String message;
  const PrayFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
