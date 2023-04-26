import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';

class AppTheme {
  static ThemeData light(BuildContext context) {
    return ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
        foregroundColor: AppColor.color2,
        elevation: 0,
        backgroundColor: AppColor.primary,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      scaffoldBackgroundColor: AppColor.secondary,
      canvasColor: AppColor.primary,
      colorScheme:
          Theme.of(context).colorScheme.copyWith(secondary: AppColor.primary),
      listTileTheme: const ListTileThemeData(
        tileColor: AppColor.secondary,
      ),
      textTheme: AppTextTheme.lightTextTheme(context),
    );
  }

  static ThemeData dark(BuildContext context) {
    return ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          // backgroundColor: Color(0xFF0A132E),
          foregroundColor: AppColor.secondary,
          elevation: 0,
          backgroundColor: Color(0xFFD3DEFF),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        scaffoldBackgroundColor: AppColor.color2,
        canvasColor: const Color(0xFF4d4dff),
        listTileTheme: const ListTileThemeData(
            tileColor: Color(0xFFD3DEFF), style: ListTileStyle.list),
        textTheme: AppTextTheme.darkTextTheme(context));
  }
}

class AppTextTheme {
  static TextTheme lightTextTheme(BuildContext context) {
    return TextTheme(
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
    );
  }

  static TextTheme darkTextTheme(BuildContext context) {
    return TextTheme(
      bodyLarge: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: AppColor.secondary),
      bodyMedium: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: AppColor.secondary),
      headlineLarge: Theme.of(context)
          .textTheme
          .headlineLarge!
          .copyWith(color: AppColor.secondary),
      headlineMedium: Theme.of(context)
          .textTheme
          .headlineMedium!
          .copyWith(color: AppColor.secondary),
      titleLarge: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(color: AppColor.secondary),
    );
  }
}
