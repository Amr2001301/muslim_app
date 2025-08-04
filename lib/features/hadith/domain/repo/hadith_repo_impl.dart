import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';
import 'package:muslim_app/core/api/api_consumer.dart';
import 'package:muslim_app/core/api/api_endpiont.dart';
import 'package:muslim_app/core/api/api_keys.dart';
import 'package:muslim_app/core/api/errors/exception.dart';
import 'package:muslim_app/features/hadith/data/model/hadith_model/hadith_model.dart';
import 'package:muslim_app/features/hadith/data/repo/hadith_repo.dart';
import 'package:muslim_app/features/hadith/domain/entity/hadith_entity.dart';

class HadithRepoImpl extends HadithRepo {
  final ApiConsumer api;
  final Box<HadithModel> hadithBox;

  HadithRepoImpl({required this.api, required this.hadithBox});
  @override
  Future<Either<String, List<HadithEntity>>> getAllHadith() async {
    try {
      final response = await api.get(
        path: ApiEndpiont.getAllHadith,
        queryParameters: {'apiKey': ApiKeys.hadithAPIKey},
      );
      List<HadithModel> hadithModelList = (response['chapters'] as List)
          .map((e) => HadithModel.fromJson(e))
          .toList();
      for (var element in hadithModelList) {
        hadithBox.add(element);
      }
      List<HadithEntity> hadithEntityList = hadithModelList
          .map((e) => e.toEntity())
          .toList();
      return Right(hadithEntityList);
    } on ServerException catch (e) {
      if (hadithBox.isNotEmpty) {
        List<HadithEntity> hadithEntityList = hadithBox.values
            .toList()
            .map((e) => e.toEntity())
            .toList();
        return Right(hadithEntityList);
      }
      log('getAllHadith ServerException: $e');
      return Left(e.errorModel.error);
    } catch (e) {
      log('getAllHadith ERROR: $e');
      return Left('error'.tr());
    }
  }
}
