import 'package:hive/hive.dart';
import 'package:muslim_app/core/api/api_keys.dart';
import 'package:muslim_app/features/quran/data/model/sura_details_model/ayah.dart';
import 'package:muslim_app/features/quran/data/model/sura_details_model/edition.dart';
import 'package:muslim_app/features/quran/data/model/sura_details_model/sura_details_model.dart';
import 'package:muslim_app/features/quran/data/model/sura_model/sura_model.dart';
import 'package:path_provider/path_provider.dart';

abstract class HiveService {
  static Future<void> initHive() async {
    await initAdapter();
    await initBox();
  }

  static Future<void> initAdapter() async {
    var directory = await getApplicationCacheDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(SuraModelAdapter());
    Hive.registerAdapter(AyahModelAdapter());
    Hive.registerAdapter(EditionModelAdapter());
    Hive.registerAdapter(SuraDetailsModelAdapter());
  }

  static Future<void> initBox() async {
    await Hive.openBox<SuraModel>(ApiKeys.suraBox);
    await Hive.openBox<SuraDetailsModel>(ApiKeys.suraDetailsBox);
  }
}
