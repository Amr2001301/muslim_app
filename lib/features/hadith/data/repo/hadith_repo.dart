import 'package:dartz/dartz.dart';
import 'package:muslim_app/features/hadith/domain/entity/hadith_entity.dart';

abstract class HadithRepo {
  Future<Either<String, List<HadithEntity>>> getAllHadith();
}
