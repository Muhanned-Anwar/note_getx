import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:note_getx/getx/language_change_notifier_getx.dart';
import 'package:note_getx/prefs/app_settings_prefs.dart';
import 'package:note_getx/screens/about_app_screen.dart';
import 'package:note_getx/screens/add_note_screen.dart';
import 'package:note_getx/screens/launch_screen.dart';
import 'package:note_getx/screens/main_screen.dart';
import 'package:note_getx/screens/note_screen.dart';
import 'package:note_getx/screens/settings_screen.dart';
import 'package:note_getx/storage/db_getx.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbGetx().initDb();
  await AppSettingsPreferences().initPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyMaterialApp();
  }
}

class MyMaterialApp extends StatelessWidget {
  LanguageChangeNotifierGetx _languageChangeNotifierGetx =
      Get.put(LanguageChangeNotifierGetx());

  @override
  Widget build(BuildContext context) {
    return GetX<LanguageChangeNotifierGetx>(builder: (controller) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar'),
          Locale('en'),
        ],
        locale: Locale(_languageChangeNotifierGetx.languageCode),
        initialRoute: '/launch_screen',
        routes: {
          '/launch_screen': (context) => LaunchScreen(),
          '/main_screen': (context) => MainScreen(),
          '/add_note_screen': (context) => AddNoteScreen(),
          '/note_screen': (context) => NoteScreen(),
          '/settings_screen': (context) => SettingsScreen(),
          '/about_app_screen': (context) => AboutAppScreen(),
        },
      );
    });
  }
}
