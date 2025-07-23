part of 'quran_cubit.dart';

sealed class QuranState extends Equatable {
  const QuranState();

  @override
  List<Object> get props => [];
}

final class QuranInitial extends QuranState {}

final class GetAllSuraLoading extends QuranState {}

final class GetAllSuraSuccess extends QuranState {
  final List<SuraEntity> suras;
  const GetAllSuraSuccess({required this.suras});
}

final class GetAllSuraError extends QuranState {
  final String errMessage;
  const GetAllSuraError({required this.errMessage});
}

final class GetSuraByIndexLoading extends QuranState {}

final class GetSuraByIndexSuccess extends QuranState {
  final SuraDetailsEntity sura;
  const GetSuraByIndexSuccess({required this.sura});
}

final class GetSuraByIndexError extends QuranState {
  final String errMessage;
  const GetSuraByIndexError({required this.errMessage});
}
