import 'package:flutter/material.dart';

class CustomColors {
  static const Color primaryColor = Color.fromRGBO(31, 41, 55, 1);
  static const Color secondaryColor = Color.fromRGBO(255, 69, 45, 1);
  static const Color backgroundColor = Color.fromRGBO(248, 250, 252, 1);
  static const Color drawerIconColor = Color.fromRGBO(126, 126, 126, 1);
  static const Color drawerTextColor = Color.fromRGBO(177, 177, 177, 1);
  static const Color drawerTextDividerColor = Color.fromRGBO(240, 240, 240, 1);
  static const Color dividerColor = Color.fromRGBO(0, 0, 0, 0.16);

  static const Color subheadingColor = Color.fromRGBO(122, 122, 122, 1);
  static const Color twilightBlue = Color.fromRGBO(245, 251, 255, 1);
  static const Color lightGrey1 = Color.fromRGBO(243, 244, 246, 1);
  static const Color lightGrey2 = Color.fromRGBO(229, 231, 235, 1);
  static const Color lightGrey3 = Color.fromRGBO(209, 213, 219, 1);
  static const Color mediumGrey1 = Color.fromRGBO(156, 163, 175, 1);
  static const Color mediumGrey2 = Color.fromRGBO(107, 114, 128, 1);
  static const Color mediumGrey3 = Color.fromRGBO(75, 85, 99, 1);
  static const Color dodgerBlue = Color.fromRGBO(45, 192, 255, 1);
  static const Color crustaOrange = Color.fromRGBO(255, 121, 45, 1);
  static const Color secondaryBlue = Color.fromRGBO(27, 140, 253, 1);
  static const Color tideColor = Color.fromRGBO(188, 184, 177, 1);
  static const Color tunaBlack = Color.fromRGBO(57, 57, 58, 1);
  static const Color blackOrange = Color.fromRGBO(138, 129, 124, 1);

  static const Color error = Color.fromRGBO(233, 0, 42, 1);

  static const Color orange100 = Color.fromRGBO(255, 240, 239, 1);
  static const Color orange200 = Color.fromRGBO(255, 162, 150, 1);
  static const Color orange400 = Color.fromRGBO(255, 69, 45, 1);

  static const Color secondaryBlueBackgroundFill =
      Color.fromRGBO(241, 245, 249, 1);
  static const Color accentBlue = Color.fromRGBO(50, 120, 255, 1);

  static const Color nobelGrey = Color.fromRGBO(179, 179, 179, 1);
  static const Color greyDark1 = Color.fromRGBO(31, 41, 55, 1);

  static const Color borderColor = Color.fromRGBO(232, 237, 243, 1);
  static const Color boxShadowColor = Color.fromRGBO(0, 0, 0, 0.04);

  static const Color gradientButtonColor1 = Color.fromRGBO(6, 45, 61, 1);
  static const Color gradientButtonColor2 = Color.fromRGBO(1, 15, 28, 1);

  static const Color illustrationPurple = Color.fromRGBO(64, 66, 226, 1);
  static const Color smokeColor = Color.fromRGBO(239, 239, 239, 1);

  //create highlight theme colors
  static const Color bluishPurple = Color.fromRGBO(95, 39, 205, 1);
  static const Color turquoiseCyan = Color.fromRGBO(72, 219, 251, 1);
  static const Color lightMustard = Color.fromRGBO(254, 202, 87, 1);
  static const Color violetPink = Color.fromRGBO(243, 104, 224, 1);
  static const Color darkSlateGrey = Color.fromRGBO(34, 47, 62, 1);
  static const Color persianGreen = Color.fromRGBO(16, 172, 132, 1);
  static const Color sandBrown = Color.fromRGBO(226, 167, 84, 1);
  static const Color regentGrey = Color.fromRGBO(131, 149, 167, 1);
  static const Color salmonPink = Color.fromRGBO(255, 107, 107, 1);
  static const Color darkSkyBlue = Color.fromRGBO(46, 134, 222, 1);
}

// Note: Use https://maketintsandshades.com/#1F2937 to generate any palette
class Palette {
  static const MaterialColor primarySwatch = MaterialColor(
    0xff1f2937,
    <int, Color>{
      50: Color(0xff1c2532),
      100: Color(0xff19212c),
      200: Color(0xff161d27),
      300: Color(0xff131921),
      400: Color(0xff10151c),
      500: Color(0xff0c1016),
      600: Color(0xff090c10),
      700: Color(0xff06080b),
      800: Color(0xff030405),
      900: Color(0xff000000),
    },
  );

  static const MaterialColor secondarySwatch = MaterialColor(
    0xffff452d,
    <int, Color>{
      50: Color(0xffe63e29),
      100: Color(0xffcc3724),
      200: Color(0xffb3301f),
      300: Color(0xff99291b),
      400: Color(0xff802317),
      500: Color(0xff661c12),
      600: Color(0xff4c150d),
      700: Color(0xff330e09),
      800: Color(0xff190704),
      900: Color(0xff000000),
    },
  );
}

class Themes {
  static ButtonStyle buttonsCommonTheme = ButtonStyle(
    shape: MaterialStateProperty.all(
      const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    ),
  );
  static FloatingActionButtonThemeData floatingActionButtonTheme =
      const FloatingActionButtonThemeData(
    shape: RoundedRectangleBorder(),
  );

  static BottomSheetThemeData bottomSheetTheme = const BottomSheetThemeData(
    shape: RoundedRectangleBorder(),
    modalBackgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
  );

  static DialogTheme dialogTheme = const DialogTheme(
    shape: RoundedRectangleBorder(),
  );

  static final ThemeData defaultTheme = ThemeData(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      fontFamily: "SourceSans3",
      primarySwatch: Palette.primarySwatch,
      primaryColor: CustomColors.secondaryColor,
      bottomSheetTheme: bottomSheetTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: buttonsCommonTheme.copyWith(),
      ),
      textButtonTheme: TextButtonThemeData(
        style: buttonsCommonTheme.copyWith(),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: buttonsCommonTheme.copyWith(),
      ),
      dialogTheme: dialogTheme,
      floatingActionButtonTheme: floatingActionButtonTheme,
      appBarTheme: const AppBarTheme(elevation: 0));
}
