import 'package:flutter/material.dart';

import '../presentation/core/app_localizations.dart';

extension ContextExt on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  AppLocalizations? get localization => AppLocalizations.of(this);
}
