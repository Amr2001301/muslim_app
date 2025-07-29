import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:muslim_app/core/service/shared_prefs_service.dart';
import 'package:muslim_app/core/utils/app_const.dart';
import 'package:muslim_app/features/quran/domain/entity/sura_audio_entity/audio_entity.dart';
import 'package:muslim_app/features/quran/domain/entity/sura_detail_entity/sura_details_entity.dart';
import 'package:muslim_app/features/quran/domain/entity/sura_entity/sura_entity.dart';
import 'package:muslim_app/features/quran/domain/repo/quran_repo.dart';
part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit(this.quranRepo) : super(QuranInitial());
  final QuranRepo quranRepo;
  List<int> pages = [];
  TextEditingController searchController = TextEditingController();
  double fontSize = 20.0;
  Future<void> getAllSura() async {
    emit(GetAllSuraLoading());
    final result = await quranRepo.getAllSura(searchController.text);
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

  Future<void> getSuraAudio(int index) async {
    emit(GetSuraAudioLoading());
    final result = await quranRepo.getSuraAudio(index);
    result.fold(
      (l) => emit(GetSuraAudioError(errMessage: l)),
      (r) => emit(GetSuraAudioSuccess(suraAudio: r)),
    );
  }

  void changeFontSized(double fontSized) async {
    fontSize = fontSized;
    await SharedPrefsService.setData(AppConst.kfontSized, fontSized);
    emit(ChangeFontSize(fontSize: fontSized));
    log('fontSize: $fontSize');
  }
}
