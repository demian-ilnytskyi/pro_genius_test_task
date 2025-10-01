import 'package:flutter/widgets.dart';
import 'package:pro_genius_test_task/l10n/generated/app_localizations.g.dart';

/// COMMENT: Adds localization in App

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

const locale = AppLocalizations.localizationsDelegates;
const supportedLocales = AppLocalizations.supportedLocales;
