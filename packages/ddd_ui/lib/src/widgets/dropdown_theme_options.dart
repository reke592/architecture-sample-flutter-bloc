import 'package:ddd_commons/ddd_commons.dart';
import 'package:ddd_ui/src/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';

class DropdownThemeOptions extends StatelessWidget {
  const DropdownThemeOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return PopupMenuButton(
          tooltip: 'change theme',
          child: Center(
            child: Text('Theme: ${state.current.themeName}'),
          ),
          itemBuilder: (context) => [
            for (var item in ThemeState.themes)
              PopupMenuItem(
                value: item,
                child: Text(item.themeName),
              ),
          ],
          onSelected: (value) {
            context
                .read<ThemeCubit>()
                .changeTheme(ThemeState.themes.indexOf(value));
          },
        );
      },
    );
  }
}
