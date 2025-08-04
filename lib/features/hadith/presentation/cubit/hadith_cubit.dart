import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:muslim_app/features/hadith/data/repo/hadith_repo.dart';
import 'package:muslim_app/features/hadith/domain/entity/hadith_entity.dart';

part 'hadith_state.dart';

class HadithCubit extends Cubit<HadithState> {
  HadithCubit(this.hadithRepo) : super(HadithInitial());
  final HadithRepo hadithRepo;
  TextEditingController hadithController = TextEditingController();

  Future<void> getAllHadith() async {
    emit(GetAllHadithLoading());
    final result = await hadithRepo.getAllHadith(hadithController.text);
    result.fold(
      (l) => emit(GetAllHadithError(error: l)),
      (r) => emit(GetAllHadithSuccess(hadiths: r)),
    );
  }
}
