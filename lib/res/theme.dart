import 'package:flutter/material.dart';
import 'package:foyer/res/themes.dart';

class ThemeModel extends ChangeNotifier {
  Themes currentTheme = LightThemes();

  ThemeData theme(context) {
    return ThemeData(
      primaryColor: currentTheme.primary(),
      secondaryHeaderColor: currentTheme.secondary(),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(foregroundColor: getMaterialColor())),
appBarTheme: AppBarTheme(
  color: currentTheme.primary(),
),
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: currentTheme.primary()),
      platform: TargetPlatform.iOS,
    );
  }

  MaterialStateProperty<Color> getMaterialColor() =>
      MaterialStateProperty.resolveWith((states) {
        return currentTheme.primary();
      });
}
