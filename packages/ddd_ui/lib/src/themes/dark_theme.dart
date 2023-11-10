part of 'app_theme.dart';

class AppThemeDark extends AppTheme {
  @override
  String get themeName => 'Dark';

  @override
  ThemeData get theme => ThemeData.dark().copyWith(
        useMaterial3: true,
        appBarTheme: _appBarTheme,
        inputDecorationTheme: _inputDecorationTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        dialogTheme: _dialogTheme,
        textButtonTheme: _textButtonTheme,
        checkboxTheme: _checkBoxTheme,
        listTileTheme: _listTileTheme,
      );

  @override
  ElevatedButtonThemeData get _elevatedButtonTheme => ElevatedButtonThemeData(
        style: super._elevatedButtonTheme.style?.copyWith(
          foregroundColor: MaterialStateColor.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) return Colors.grey;
              return Colors.white;
            },
          ),
        ),
      );

  @override
  TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
        style: super._textButtonTheme.style?.copyWith(
          foregroundColor: MaterialStateColor.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) return Colors.black;
              return Colors.white;
            },
          ),
        ),
      );

  @override
  CheckboxThemeData get _checkBoxTheme => super._checkBoxTheme.copyWith(
        side: const BorderSide(color: Colors.white),
        checkColor: MaterialStateColor.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) return Colors.black;
            return Colors.white;
          },
        ),
      );
}
