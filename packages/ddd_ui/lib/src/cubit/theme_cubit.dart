import 'package:ddd_commons/ddd_commons.dart';
import 'package:ddd_ui/ddd_ui.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit({int activeIndex = 0})
      : super(ThemeState(activeIndex: activeIndex));

  @override
  ThemeState? fromJson(Map<String, dynamic> json) =>
      ThemeState(activeIndex: json['activeIndex'] ?? 0);

  @override
  Map<String, dynamic>? toJson(ThemeState state) => {
        'activeIndex': state.activeIndex,
      };

  void changeTheme(int activeIndex) {
    emit(state.copyWith(activeIndex: activeIndex));
  }
}
