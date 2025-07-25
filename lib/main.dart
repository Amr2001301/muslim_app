import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:muslim_app/core/service/hive_service.dart';
import 'package:muslim_app/core/service/my_bloc_observer.dart';
import 'package:muslim_app/core/service/service_locator.dart';
import 'package:muslim_app/core/service/shared_prefs_service.dart';
import 'package:muslim_app/muslim_app.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await HiveService.initHive();
  await SharedPrefsService.init();
  Bloc.observer = MyBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );
  ServiceLocator.init();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('ar'),
      child: const MuslimApp(),
    ),
  );
}
