import 'package:dartz/dartz.dart';
import 'package:muslim_app/features/quran/domain/entity/sura_details_entity.dart';
import 'package:muslim_app/features/quran/domain/entity/sura_entity.dart';

abstract class QuranRepo {
  Future<Either<String, List<SuraEntity>>> getAllSura(String? name);
  Future<Either<String, SuraDetailsEntity>> getSuraByIndex(int index);
}
