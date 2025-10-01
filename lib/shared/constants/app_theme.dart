import 'package:flutter/material.dart'
    show
        AppBar,
        AppBarTheme,
        BottomNavigationBarThemeData,
        Brightness,
        ButtonStyle,
        ButtonThemeData,
        Color,
        ColorScheme,
        Colors,
        IconButtonThemeData,
        MouseCursor,
        SystemMouseCursors,
        TextButtonThemeData,
        TextTheme,
        ThemeData,
        TooltipThemeData,
        WidgetState,
        WidgetStateProperty,
        WidgetStatePropertyAll;

WidgetStateProperty<MouseCursor?> get _buttonMouseCursor =>
    WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return SystemMouseCursors.forbidden;
      }
      return SystemMouseCursors.click;
    });

ThemeData themeData = ThemeData(
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(mouseCursor: _buttonMouseCursor),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(mouseCursor: _buttonMouseCursor),
  ),
  useMaterial3: true,
);
