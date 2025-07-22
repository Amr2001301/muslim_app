import 'package:dartz/dartz.dart';
import 'package:muslim_app/features/quran/domain/entity/sura_entity.dart';

abstract class QuranRepo {
  Future<Either<String, List<SuraEntity>>> getAllSura();
}
