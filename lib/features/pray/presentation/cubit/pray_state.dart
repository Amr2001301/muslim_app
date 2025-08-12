part of 'pray_cubit.dart';

sealed class PrayState extends Equatable {
  const PrayState();

  @override
  List<Object> get props => [];
}

final class PrayInitial extends PrayState {}

final class PrayLoading extends PrayState {}

final class PraySuccess extends PrayState {
  final PrayEntity prayEntity;
  const PraySuccess({required this.prayEntity});
}

final class PrayFailure extends PrayState {
  final String message;
  const PrayFailure({required this.message});
}
