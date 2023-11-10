part of 'theme_cubit.dart';

@immutable
class ThemeState {
  static final List<AppTheme> themes = [
    AppTheme(),
    AppThemeDark(),
    AppThemeMcDo(),
  ];
  final int activeIndex;

  const ThemeState({
    this.activeIndex = 0,
  });

  AppTheme get current => themes[activeIndex];

  ThemeState copyWith({
    int? activeIndex,
  }) =>
      ThemeState(
        activeIndex: activeIndex ?? this.activeIndex,
      );
}
