import 'package:get/get.dart';
import 'package:note_getx/prefs/app_settings_prefs.dart';

class LanguageChangeNotifierGetx extends GetxController{

  // RxString languageCode = AppSettingsPreferences().langCode.obs;
  RxString _languageCode = AppSettingsPreferences().langCode.obs;

  static LanguageChangeNotifierGetx get to => Get.find();


  @override
  void onInit() {
    super.onInit();
  }

  Future<void> changeLanguage({required String languageCode}) async{
    this._languageCode.value = languageCode;
    await AppSettingsPreferences().saveLanguage(language: languageCode);
    // update();
    // refresh();
    _languageCode.refresh();
  }

  String get languageCode => _languageCode.value;
}