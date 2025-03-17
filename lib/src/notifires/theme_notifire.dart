import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifire extends StateNotifier<ThemeMode> {
  ThemeNotifire() : super(ThemeMode.light);

  void toogleTheme() {
    if (state == ThemeMode.light) {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.dark;
    }
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifire, ThemeMode>((ref) {
  return ThemeNotifire();
});
