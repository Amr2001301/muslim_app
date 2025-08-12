import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:muslim_app/core/api/api_consumer.dart';
import 'package:muslim_app/core/api/api_endpiont.dart';
import 'package:muslim_app/core/api/errors/exception.dart';
import 'package:muslim_app/features/pray/data/model/pray_model/pray_model.dart';
import 'package:muslim_app/features/pray/domain/entitiy/pray_entity.dart';
import 'package:muslim_app/features/pray/domain/repo/pray_repo.dart';

class PrayRepoImpl extends PrayRepo {
  final ApiConsumer api;

  PrayRepoImpl({required this.api});
  @override
  Future<Either<String, PrayEntity>> getAllPray({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await api.get(
        path: ApiEndpiont.getPrayerTime,
        queryParameters: {"latitude": latitude, "longitude": longitude},
      );
      final PrayModel prayModel = PrayModel.fromJson(response['data']);
      return Right(prayModel.toEntity());
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      return Left('error'.tr());
    }
  }
}
