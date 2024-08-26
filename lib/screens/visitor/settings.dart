import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/theme_provider.dart';
import 'package:frontend/providers/locale_provider.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/utils/constant.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('settings'),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context).translate('dark_mode')),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ),
          const SizedBox(height: 16.0),
          ListTile(
            title: Text(AppLocalizations.of(context).translate('language')),
            trailing: DropdownButton<Locale>(
              value: localeProvider.locale,
              onChanged: (Locale? newLocale) {
                localeProvider.setLocale(newLocale!);
              },
              items: [
                DropdownMenuItem(
                  value: const Locale('en', ''),
                  child: Row(
                    children: [
                      Image.asset('assets/images/en.png', width: 24),
                      const SizedBox(width: 8),
                      const Text('English'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: const Locale('fr', ''),
                  child: Row(
                    children: [
                      Image.asset('assets/images/fr.png', width: 24),
                      const SizedBox(width: 8),
                      const Text('Français'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: const Locale('ar', ''),
                  child: Row(
                    children: [
                      Image.asset('assets/images/arb.png', width: 24),
                      const SizedBox(width: 8),
                      const Text('العربية'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
