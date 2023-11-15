import 'package:flutter/material.dart';

part 'dark_theme.dart';
part 'mcdo_theme.dart';

class AppTheme {
  static double gapSize = 8;
  static get gap1 => SizedBox(height: gapSize * 1);
  static get gap2 => SizedBox(height: gapSize * 1.5);
  static get gap3 => SizedBox(height: gapSize * 2);

  String get themeName => 'Light';

  ThemeData get theme => ThemeData(
        useMaterial3: true,
        appBarTheme: _appBarTheme,
        inputDecorationTheme: _inputDecorationTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        dialogTheme: _dialogTheme,
        textButtonTheme: _textButtonTheme,
        checkboxTheme: _checkBoxTheme,
        listTileTheme: _listTileTheme,
        cardTheme: _cardTheme,
        progressIndicatorTheme: _progressIndicatorTheme,
        buttonTheme: _buttonTheme,
        iconButtonTheme: _iconButtonTheme,
        textTheme: _textTheme,
      );

  final _appBarTheme = const AppBarTheme();

  final _inputDecorationTheme = const InputDecorationTheme(
    isDense: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  );

  final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  final _dialogTheme = DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );

  final _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(),
  );

  final _checkBoxTheme = CheckboxThemeData(
    side: const BorderSide(color: Colors.black),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );

  final _listTileTheme = const ListTileThemeData(
    horizontalTitleGap: 4,
    dense: true,
  );

  final _cardTheme = const CardTheme();

  final _progressIndicatorTheme = const ProgressIndicatorThemeData();

  final _buttonTheme = const ButtonThemeData();

  final _iconButtonTheme = const IconButtonThemeData();

  final _textTheme = const TextTheme();
}
