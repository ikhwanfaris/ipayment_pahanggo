import 'package:flutterbase/language/en.dart';
import 'package:flutterbase/language/ms.dart';
import 'package:get/get.dart';

abstract class AppTranslation extends Translations {
  static Map<String, Map<String, String>> translationsKeys = {
    "en": en,
    "ms_MY": msMY,
  };
}
