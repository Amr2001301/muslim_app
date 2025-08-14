part of 'azkar_cubit.dart';

sealed class AzkarState extends Equatable {
  const AzkarState();

  @override
  List<Object> get props => [];
}

final class AzkarInitial extends AzkarState {}

class AzkarLoading extends AzkarState {}

class AzkarSuccess extends AzkarState {
  final List<AzkarEntity> azkarEntity;
  const AzkarSuccess({required this.azkarEntity});
  @override
  List<Object> get props => [azkarEntity];
}

class AzkarFailure extends AzkarState {
  final String message;
  const AzkarFailure({required this.message});
  @override
  List<Object> get props => [message];
}
