import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';
import 'package:muslim_app/core/api/api_consumer.dart';
import 'package:muslim_app/core/api/api_endpiont.dart';
import 'package:muslim_app/core/api/errors/exception.dart';
import 'package:muslim_app/features/quran/data/model/sura_model/sura_model.dart';
import 'package:muslim_app/features/quran/domain/entity/sura_entity.dart';
import 'package:muslim_app/features/quran/domain/repo/quran_repo.dart';

class QuranRepoImpl implements QuranRepo {
  final ApiConsumer api;
  final Box<SuraModel> suraBox;

  QuranRepoImpl({required this.suraBox, required this.api});
  @override
  Future<Either<String, List<SuraEntity>>> getAllSura() async {
    try {
      final response = await api.get(path: ApiEndpiont.getAllSurah);
      final List<SuraModel> suraModel = (response['data'] as List)
          .map((e) => SuraModel.fromJson(e))
          .toList();
      await suraBox.clear();
      for (var element in suraModel) {
        await suraBox.add(element);
      }
      return Right(suraModel.map((e) => e.toEntity()).toList());
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
}
