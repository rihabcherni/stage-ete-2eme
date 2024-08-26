// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to SNCFT Fret Ferroviaire`
  String get welcome {
    return Intl.message(
      'Welcome to SNCFT Fret Ferroviaire',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Introducing our integrated solution to optimize railway freight logistics. Learn how we enhance efficiency, resource management, and customer satisfaction.`
  String get description1 {
    return Intl.message(
      'Introducing our integrated solution to optimize railway freight logistics. Learn how we enhance efficiency, resource management, and customer satisfaction.',
      name: 'description1',
      desc: '',
      args: [],
    );
  }

  /// `For Clients`
  String get clients {
    return Intl.message(
      'For Clients',
      name: 'clients',
      desc: '',
      args: [],
    );
  }

  /// `Track your shipments in real-time, ensure timely deliveries, and reduce carbon emissions with our advanced freight management system.`
  String get description2 {
    return Intl.message(
      'Track your shipments in real-time, ensure timely deliveries, and reduce carbon emissions with our advanced freight management system.',
      name: 'description2',
      desc: '',
      args: [],
    );
  }

  /// `For Operators and Conductors`
  String get operators {
    return Intl.message(
      'For Operators and Conductors',
      name: 'operators',
      desc: '',
      args: [],
    );
  }

  /// `Manage routes, monitor resources, and optimize schedules efficiently. Our system provides tools to adapt plans and ensure smooth operations.`
  String get description3 {
    return Intl.message(
      'Manage routes, monitor resources, and optimize schedules efficiently. Our system provides tools to adapt plans and ensure smooth operations.',
      name: 'description3',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
