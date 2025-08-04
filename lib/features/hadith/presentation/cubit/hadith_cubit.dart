import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muslim_app/features/hadith/data/repo/hadith_repo.dart';
import 'package:muslim_app/features/hadith/domain/entity/hadith_entity.dart';

part 'hadith_state.dart';

class HadithCubit extends Cubit<HadithState> {
  HadithCubit(this.hadithRepo) : super(HadithInitial());
  final HadithRepo hadithRepo;

  Future<void> getAllHadith() async {
    emit(GetAllHadithLoading());
    final result = await hadithRepo.getAllHadith();
    result.fold(
      (l) => emit(GetAllHadithError(error: l)),
      (r) => emit(GetAllHadithSuccess(hadiths: r)),
    );
  }
}
