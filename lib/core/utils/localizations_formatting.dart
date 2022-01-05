import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core.dart';

class LocalizationsFormatting {
  static final appLocaleLanguage =
      Localizations.localeOf(AppConstants.navigationKey.currentContext!)
          .languageCode;
  static final weekDayMonthAndYearWithBackSlash =
      DateFormat('EEEE, dd/MM/yyyy', appLocaleLanguage);
}
