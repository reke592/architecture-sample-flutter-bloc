part of 'app_theme.dart';

class AppThemeMcDo extends AppTheme {
  final colorWhite = Colors.white;
  final colorRed = Colors.red.shade900;
  final colorGreen = Colors.green.shade900;
  final colorYellow = Colors.yellow.shade700;
  final colorBlack = Colors.black87;

  @override
  String get themeName => 'McDo';

  @override
  ThemeData get theme => super.theme.copyWith(
        scaffoldBackgroundColor: colorRed,
      );

  @override
  AppBarTheme get _appBarTheme => super._appBarTheme.copyWith(
        backgroundColor: colorRed,
        foregroundColor: colorYellow,
      );

  @override
  ElevatedButtonThemeData get _elevatedButtonTheme => ElevatedButtonThemeData(
        style: super._elevatedButtonTheme.style?.copyWith(
          backgroundColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return colorRed.withOpacity(0.5);
            }
            return colorRed;
          }),
          foregroundColor: MaterialStateColor.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return colorYellow.withOpacity(0.5);
              }
              return colorWhite;
            },
          ),
        ),
      );

  @override
  TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
        style: super._textButtonTheme.style?.copyWith(
          foregroundColor: MaterialStateColor.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return colorBlack;
              }
              return colorWhite;
            },
          ),
        ),
      );

  @override
  CheckboxThemeData get _checkBoxTheme => super._checkBoxTheme.copyWith(
        side: BorderSide(color: colorBlack),
        checkColor: MaterialStateColor.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return colorWhite;
            }
            return colorWhite;
          },
        ),
        fillColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return colorGreen;
          }
          return colorWhite;
        }),
      );

  @override
  ListTileThemeData get _listTileTheme => super._listTileTheme.copyWith(
        tileColor: colorWhite,
        textColor: colorBlack,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      );

  @override
  ProgressIndicatorThemeData get _progressIndicatorTheme =>
      super._progressIndicatorTheme.copyWith(
            color: colorWhite,
            circularTrackColor: colorGreen,
            linearTrackColor: colorGreen,
          );
}
