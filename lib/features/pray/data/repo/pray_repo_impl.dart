import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';
import 'package:muslim_app/core/api/api_consumer.dart';
import 'package:muslim_app/core/api/api_endpiont.dart';
import 'package:muslim_app/core/api/errors/exception.dart';
import 'package:muslim_app/features/pray/data/model/pray_model/pray_model.dart';
import 'package:muslim_app/features/pray/domain/entitiy/pray_entity/pray_entity.dart';
import 'package:muslim_app/features/pray/domain/repo/pray_repo.dart';

class PrayRepoImpl extends PrayRepo {
  final ApiConsumer api;
  final Box<PrayModel> prayBox;

  PrayRepoImpl({required this.api, required this.prayBox});
  @override
  Future<Either<String, PrayEntity>> getAllPray({
    required double latitude,
    required double longitude,
  }) async {
    try {
      if (prayBox.isNotEmpty) {
        final cashed = prayBox.values.first;
        return Right(cashed.toEntity());
      }
      final response = await api.get(
        path: ApiEndpiont.getPrayerTime,
        queryParameters: {"latitude": latitude, "longitude": longitude},
      );
      final PrayModel prayModel = PrayModel.fromJson(response['data']);
      await prayBox.add(prayModel);
      return Right(prayModel.toEntity());
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      if (prayBox.isNotEmpty) {
        final cashed = prayBox.values.first;
        return Right(cashed.toEntity());
      }
      return Left('error'.tr());
    }
  }
}
