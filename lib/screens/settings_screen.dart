import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_getx/getx/language_change_notifier_getx.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? _selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        alignment: AlignmentDirectional.topStart,
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 70, right: 20, left: 20, bottom: 20),
          child: Column(
            children: [
              Text(AppLocalizations.of(context)!.settings_title,
                  style: TextStyle(fontSize: 40)),
              SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.settings_language,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton<String>(
                hint: Text(
                    AppLocalizations.of(context)!.settings_language_hint_text),
                onTap: () {},
                onChanged: (value) {
                  setState(() {
                    LanguageChangeNotifierGetx.to.changeLanguage(languageCode: value ?? _selectedLanguage ?? 'en');
                  });
                },
                value: _selectedLanguage,
                items: [
                  DropdownMenuItem(
                    child: Text(
                        AppLocalizations.of(context)!.settings_language_arabic),
                    value: 'ar',
                    onTap: () {
                      setState(() {
                        _selectedLanguage = 'ar';
                        // _languageChangeNotifierGetx.changeLanguage(languageCode: _selectedLanguage!);
                      });
                    },
                  ),
                  DropdownMenuItem(
                    child: Text(AppLocalizations.of(context)!
                        .settings_language_english),
                    value: 'en',
                    onTap: () {
                      setState(() {
                        _selectedLanguage = 'en';
                        // _languageChangeNotifierGetx.changeLanguage(languageCode: _selectedLanguage!);
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
