/*
 * Copyright (c) 2020, Kanan Yusubov. - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * Proprietary and confidential
 * Written by: Kanan Yusubov <kanan.yusubov@yandex.com>, July 2020
 */

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:cubit/cubit.dart';
import './impl_theme_cubit.dart';
import '../../data/services/shared_preferences_service.dart';

part './theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> implements IThemeCubit {
  ThemeCubit(ThemeMode defaultThemeMode) : super(ThemeState(defaultThemeMode));

  @override
  Future<void> changeTheme(bool value) async {
    final sharedPrefService = await SharedPreferencesService.instance;
    final isDarkModeEnabled = sharedPrefService.isDarkModeEnabled;

    if (isDarkModeEnabled == value) return;

    await sharedPrefService.setDarkModeInfo(value);
    emit(ThemeState(value ? ThemeMode.dark : ThemeMode.light));
  }

  @override
  Future<ThemeMode> loadDefaultTheme() async {
    final sharedPrefService = await SharedPreferencesService.instance;
    final isDarkModeEnabled = sharedPrefService.isDarkModeEnabled;

    if (isDarkModeEnabled == null) {
      await sharedPrefService.setDarkModeInfo(false);
      return ThemeMode.light;
    } else {
      ThemeMode defaultThemeMode =
          isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light;
      return defaultThemeMode;
    }
  }
}