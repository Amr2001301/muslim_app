import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muslim_app/features/quran/domain/entity/sura_details_entity.dart';
import 'package:muslim_app/features/quran/domain/entity/sura_entity.dart';
import 'package:muslim_app/features/quran/domain/repo/quran_repo.dart';
part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit(this.quranRepo) : super(QuranInitial());
  final QuranRepo quranRepo;

  Future<void> getAllSura() async {
    emit(GetAllSuraLoading());
    final result = await quranRepo.getAllSura();
    result.fold(
      (l) => emit(GetAllSuraError(errMessage: l)),
      (r) => emit(GetAllSuraSuccess(suras: r)),
    );
  }

  Future<void> getSuraByIndex(int index) async {
    emit(GetSuraByIndexLoading());
    final result = await quranRepo.getSuraByIndex(index);
    result.fold(
      (l) => emit(GetSuraByIndexError(errMessage: l)),
      (r) => emit(GetSuraByIndexSuccess(sura: r)),
    );
  }
}
