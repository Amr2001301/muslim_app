import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:muslim_app/core/api/api_consumer.dart';
import 'package:muslim_app/core/api/api_endpiont.dart';
import 'package:muslim_app/core/api/errors/exception.dart';
import 'package:muslim_app/features/pray/data/model/azkar_model/azkar_model.dart';
import 'package:muslim_app/features/pray/domain/entitiy/azkar_entity.dart/azkar_entity.dart';
import 'package:muslim_app/features/pray/domain/repo/azkar_repo.dart';

class AzkarRepoImpl extends AzkarRepo {
  final ApiConsumer api;
  AzkarRepoImpl({required this.api});

  @override
  Future<Either<String, List<AzkarEntity>>> getAzkar({
    required String azkarName,
  }) async {
    try {
      final response = await api.get(
        path: "${ApiEndpiont.azkar}$azkarName.json",
      );
      final List<AzkarModel> azkarModel = (response['content'] as List)
          .map((e) => AzkarModel.fromJson(e))
          .toList();

      final List<AzkarEntity> azkarEntity = azkarModel
          .map((e) => e.toEntity())
          .toList();
      return Right(azkarEntity);
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      return Left('error'.tr());
    }
  }
}
