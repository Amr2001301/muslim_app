import 'package:hive/hive.dart';
import 'package:muslim_app/core/api/api_keys.dart';
import 'package:muslim_app/features/hadith/data/model/hadith_chapter_details_model/hadith_details_model.dart';
import 'package:muslim_app/features/hadith/data/model/hadith_model/hadith_model.dart';
import 'package:muslim_app/features/quran/data/model/sura_audio_model/audio_details_model.dart';
import 'package:muslim_app/features/quran/data/model/sura_audio_model/audio_model.dart';
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
    Hive.registerAdapter(AudioDetailsModelAdapter());
    Hive.registerAdapter(AudioModelAdapter());
    Hive.registerAdapter(HadithModelAdapter());
    Hive.registerAdapter(HadithDetailsModelAdapter());
  }

  static Future<void> initBox() async {
    await Hive.openBox<SuraModel>(ApiKeys.suraBox);
    await Hive.openBox<SuraDetailsModel>(ApiKeys.suraDetailsBox);
    await Hive.openBox<AudioDetailsModel>(ApiKeys.audioBox);
    await Hive.openBox<HadithModel>(ApiKeys.hadithBox);
    await Hive.openBox<HadithDetailsModel>(ApiKeys.hadithDetailsBox);
  }

  static Future<void> clearAll() async {
    await Hive.deleteFromDisk(); // احذر! يمسح كل البيانات
  }
}
