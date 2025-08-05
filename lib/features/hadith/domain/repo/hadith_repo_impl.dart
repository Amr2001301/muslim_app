import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';
import 'package:muslim_app/core/api/api_consumer.dart';
import 'package:muslim_app/core/api/api_endpiont.dart';
import 'package:muslim_app/core/api/api_keys.dart';
import 'package:muslim_app/core/api/errors/exception.dart';
import 'package:muslim_app/core/utils/functions/remove_basmala.dart';
import 'package:muslim_app/features/hadith/data/model/hadith_chapter_details_model/hadith_details_model.dart';
import 'package:muslim_app/features/hadith/data/model/hadith_model/hadith_model.dart';
import 'package:muslim_app/features/hadith/data/repo/hadith_repo.dart';
import 'package:muslim_app/features/hadith/domain/entity/hadith_chapter_details_entity/hadith_details_entitiy.dart';
import 'package:muslim_app/features/hadith/domain/entity/hadith_entity/hadith_entity.dart';

class HadithRepoImpl extends HadithRepo {
  final ApiConsumer api;
  final Box<HadithModel> hadithBox;
  final Box<List<HadithDetailsModel>> hadithDetailsBox;

  HadithRepoImpl({
    required this.api,
    required this.hadithBox,
    required this.hadithDetailsBox,
  });
  @override
  Future<Either<String, List<HadithEntity>>> getAllHadith(String? name) async {
    try {
      if (hadithBox.isNotEmpty) {
        List<HadithEntity> cashedList = hadithBox.values
            .map((e) => e.toEntity())
            .toList();
        List<HadithEntity> filterList = cashedList
            .where(
              (e) => removeDiacritics(
                e.chapterArabic!,
              ).contains(removeDiacritics(name ?? '')),
            )
            .toList();
        return right(filterList);
      }

      final response = await api.get(
        path: ApiEndpiont.getAllHadith,
        queryParameters: {'apiKey': ApiKeys.hadithAPIKey},
      );
      List<HadithModel> hadithModelList = (response['chapters'] as List)
          .map((e) => HadithModel.fromJson(e))
          .toList();
      hadithBox.clear();
      for (var element in hadithModelList) {
        hadithBox.add(element);
      }
      log("hadithBox: ${hadithBox.values.toString()}");
      List<HadithEntity> hadithEntityList = hadithModelList
          .map((e) => e.toEntity())
          .toList();
      return Right(hadithEntityList);
    } on ServerException catch (e) {
      log('getAllHadith ServerException: $e');
      return Left(e.errorModel.error);
    } catch (e, st) {
      log('getQuran ERROR: $e');
      log('STACK: $st');
      if (hadithBox.isNotEmpty) {
        List<HadithEntity> hadithEntityList = hadithBox.values
            .toList()
            .map((e) => e.toEntity())
            .toList();
        return Right(hadithEntityList);
      }
      return Left('error'.tr());
    }
  }

  @override
  Future<Either<String, List<HadithDetailsEntitiy>>> getHadithById(
    String id,
  ) async {
    try {
      final response = await api.get(
        path: ApiEndpiont.getHadithByIndex,
        queryParameters: {
          'apiKey': ApiKeys.hadithAPIKey,
          'book': 'sahih-muslim',
          'chapter': id,
        },
      );
      List<HadithDetailsModel> hadithModelList =
          (response['hadiths']['data'] as List)
              .map((e) => HadithDetailsModel.fromJson(e))
              .toList();
      hadithDetailsBox.put(id, hadithModelList);
      log('hadithDetailsBox: ${hadithDetailsBox.get(id)}');
      List<HadithDetailsEntitiy> hadithDetailsEntityList = hadithModelList
          .map((e) => e.toEntity())
          .toList();
      return Right(hadithDetailsEntityList);
    } catch (e, st) {
      log('getQuran ERROR: $e');
      log('STACK: $st');
      if (hadithDetailsBox.isNotEmpty) {
        List<HadithDetailsModel> hadithModelList = hadithDetailsBox.get(id)!;
        List<HadithDetailsEntitiy> hadithDetailsEntityList = hadithModelList
            .map((e) => e.toEntity())
            .toList();
        return Right(hadithDetailsEntityList);
      }
      return Left('error'.tr());
    }
  }
}
