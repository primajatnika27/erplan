import 'package:flutter/material.dart';

abstract class LanguageRepositoryLocal {
  Future<Locale?> load();

  Future<bool> save(Locale locale);
}
