import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/theme_provider.dart';
import 'package:frontend/providers/locale_provider.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/utils/constant.dart';
import 'package:url_launcher/url_launcher.dart'; // Required to launch URLs

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final String email = 'support@sncft.com';
  final String phone = '+21612345678';
  final String linkedinURL = 'https://www.linkedin.com/company/sncf';
  final String facebookURL = 'https://www.facebook.com/sncf';
  final String instagramURL = 'https://www.instagram.com/sncf';

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
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Support'),
            subtitle: const Text('Contact support for help'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Support'),
                    content: const Text('Contact support at: support@sncft.com'),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            onTap: () {
              // Navigate to Privacy Policy Page or show dialog
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About SNCFT'),
            onTap: () {
              // Show about dialog or navigate to about page
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification Settings'),
            onTap: () {
              // Navigate to notification settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email Us'),
            subtitle: Text(email),
            onTap: () => _launchEmail(email),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Call Us'),
            subtitle: Text(phone),
            onTap: () => _launchPhone(phone),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Social Media'),
            subtitle: const Text('Follow us on social media'),
          ),
          _buildSocialMediaRow(),
        ],
      ),
    );
  }

  // Function to open email client
  void _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('Could not launch $emailUri');
    }
  }

  // Function to initiate a phone call
  void _launchPhone(String phone) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      print('Could not launch $phoneUri');
    }
  }

  // Widget to build social media row with icons
  Widget _buildSocialMediaRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSocialMediaIcon(Icons.linked_camera, linkedinURL),
          _buildSocialMediaIcon(Icons.facebook, facebookURL),
          _buildSocialMediaIcon(Icons.camera_alt, instagramURL),
        ],
      ),
    );
  }

  // Function to launch social media links
  Widget _buildSocialMediaIcon(IconData icon, String url) {
    return IconButton(
      icon: Icon(icon, size: 32.0),
      onPressed: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          print('Could not launch $url');
        }
      },
    );
  }
}
