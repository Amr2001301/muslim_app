import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';
import 'package:muslim_app/core/api/api_consumer.dart';
import 'package:muslim_app/core/api/api_endpiont.dart';
import 'package:muslim_app/core/api/errors/exception.dart';
import 'package:muslim_app/core/utils/functions/remove_basmala.dart';
import 'package:muslim_app/features/quran/data/model/sura_details_model/sura_details_model.dart';
import 'package:muslim_app/features/quran/data/model/sura_model/sura_model.dart';
import 'package:muslim_app/features/quran/domain/entity/sura_details_entity.dart';
import 'package:muslim_app/features/quran/domain/entity/sura_entity.dart';
import 'package:muslim_app/features/quran/domain/repo/quran_repo.dart';

class QuranRepoImpl implements QuranRepo {
  final ApiConsumer api;
  final Box<SuraModel> suraBox;
  final Box<SuraDetailsModel> suraDetailsBox;

  QuranRepoImpl({
    required this.suraDetailsBox,
    required this.suraBox,
    required this.api,
  });

  @override
  Future<Either<String, List<SuraEntity>>> getAllSura(String? name) async {
    try {
      if (suraBox.isNotEmpty) {
        List<SuraEntity> cachedList = suraBox.values
            .map((e) => e.toEntity())
            .toList();
        List<SuraEntity> filterList = cachedList
            .where(
              (e) => removeDiacritics(
                e.name.trim(),
              ).contains(removeDiacritics(name ?? '')),
            )
            .toList();
        return Right(filterList);
      }
      final response = await api.get(path: ApiEndpiont.getAllSurah);
      final List<SuraModel> suraModel = (response['data'] as List)
          .map((e) => SuraModel.fromJson(e))
          .toList();
      await suraBox.clear();
      for (var element in suraModel) {
        await suraBox.add(element);
      }
      List<SuraEntity> suraListEntity = suraModel
          .map((e) => e.toEntity())
          .toList();
      List<SuraEntity> filterList = suraListEntity
          .where(
            (e) => removeDiacritics(
              e.name.trim(),
            ).contains(removeDiacritics(name ?? '')),
          )
          .toList();
      return Right(filterList);
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e, st) {
      log('getQuran ERROR: $e');
      log('STACK: $st');
      if (suraBox.isNotEmpty) {
        log('suraBox.isNotEmpty');
        return Right(suraBox.values.map((e) => e.toEntity()).toList());
      }
      return Left('error'.tr());
    }
  }

  @override
  Future<Either<String, SuraDetailsEntity>> getSuraByIndex(int index) async {
    try {
      final response = await api.get(path: '${ApiEndpiont.getSurah}/$index');
      SuraDetailsModel suraDetailsModel = SuraDetailsModel.fromJson(
        response['data'],
      );
      suraDetailsBox.clear();
      await suraDetailsBox.put(index, suraDetailsModel);
      return Right(suraDetailsModel.toEntity());
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e, st) {
      if (suraDetailsBox.isNotEmpty) {
        final suraDetails = suraDetailsBox.get(index);
        return Right(suraDetails?.toEntity());
      }
      log('getQuran ERROR: $e');
      log('STACK: $st');
      return Left('error'.tr());
    }
  }
}
