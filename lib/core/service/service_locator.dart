import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:muslim_app/core/api/api_consumer.dart';
import 'package:muslim_app/core/api/api_keys.dart';
import 'package:muslim_app/core/api/dio_consumer.dart';
import 'package:muslim_app/features/quran/data/repo/quran_repo_impl.dart';
import 'package:muslim_app/features/quran/domain/repo/quran_repo.dart';

GetIt getIt = GetIt.instance;

abstract class ServiceLocator {
  static void init() {
    getIt.registerSingleton<ApiConsumer>(DioConsumer(dio: Dio()));
    getIt.registerSingleton<QuranRepo>(
      QuranRepoImpl(
        suraBox: Hive.box(ApiKeys.suraBox),
        api: getIt<ApiConsumer>(),
        suraDetailsBox: Hive.box(ApiKeys.suraDetailsBox),
        audioBox: Hive.box(ApiKeys.audioBox),
      ),
    );
  }
}
