import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';

class AppTheme {
  static ThemeData light(BuildContext context) {
    return ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
        foregroundColor: AppColor.secondary,
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.primary,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      scaffoldBackgroundColor: AppColor.secondary,
      canvasColor: AppColor.accentColor,
      listTileTheme: const ListTileThemeData(
        tileColor: AppColor.secondary,
      ),
      cardTheme: CardTheme(
        margin: const EdgeInsets.only(
          right: 20.0,
          left: 20.0,
          bottom: 10.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
      ),
      textTheme: TextTheme(
        bodyLarge: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: AppColor.color2),
        bodyMedium: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: AppColor.color2),
        headlineLarge: Theme.of(context)
            .textTheme
            .headlineLarge!
            .copyWith(color: AppColor.color2),
        headlineMedium: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(color: AppColor.color2),
        titleLarge: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: AppColor.color2),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
        // backgroundColor: Color(0xFF0A132E),
        backgroundColor: AppColor.color2,
        elevation: 0,
        foregroundColor: Color(0xFFD3DEFF),
      ),
      scaffoldBackgroundColor: const Color(0xFFD3DEFF),
      canvasColor: const Color(0xFF4d4dff),
      listTileTheme: const ListTileThemeData(
          tileColor: Color(0xFFD3DEFF), style: ListTileStyle.list),
    );
  }
}
