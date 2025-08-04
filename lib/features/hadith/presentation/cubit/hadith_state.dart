part of 'hadith_cubit.dart';

sealed class HadithState extends Equatable {
  const HadithState();

  @override
  List<Object> get props => [];
}

final class HadithInitial extends HadithState {}

final class GetAllHadithLoading extends HadithState {}

final class GetAllHadithSuccess extends HadithState {
  final List<HadithEntity> hadiths;
  const GetAllHadithSuccess({required this.hadiths});
}

final class GetAllHadithError extends HadithState {
  final String error;
  const GetAllHadithError({required this.error});
}
