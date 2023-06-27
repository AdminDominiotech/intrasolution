import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safe2biz/app/global/core/core.dart';

ThemeData get themeData => ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: S2BColors.primaryColor,
      //cursorColor: S2BColors.primaryColor,
      accentColor: S2BColors.black,
      errorColor: S2BColors.dangerColor,
      //-----------------------
      iconTheme: const IconThemeData(color: S2BColors.primaryColor),
      fontFamily: S2BTypography.roboto,
      canvasColor: S2BColors.background, //backgroundColor BottomNavigationBar
      scaffoldBackgroundColor: S2BColors.background, //backgroundColor pages
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: S2BColors.primaryColor,
      )
      // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      //   //==========PROPETIES==============
      //   showSelectedLabels: true,
      //   showUnselectedLabels: true,
      //   type: BottomNavigationBarType.shifting,
      //   elevation: 0,
      //   //==========NOT SELECT TAB==============
      //   unselectedItemColor: S2BColors.secundary,
      //   unselectedIconTheme: IconThemeData(color: S2BColors.secundary, size: 20),
      //   unselectedLabelStyle: TextStyles.txtDefaultOrange,
      //   //==========SELECT TAB==============
      //   // selectedItemColor: Colors.white,
      //   selectedItemColor: CColors.secundary,
      //   selectedIconTheme: IconThemeData(color: CColors.secundary, size: 30),
      //   // selectedLabelStyle: TextStyles.txtDefaultWhite,
      //   selectedLabelStyle: TextStyles.txtDefaultBlue,
      // ),
      ,
    );

SystemUiOverlayStyle get systemUILight => SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.light,
    );

SystemUiOverlayStyle get systemUIDark => SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: S2BColors.primaryColor,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: S2BColors.black,
      systemNavigationBarDividerColor: S2BColors.white,
      systemNavigationBarIconBrightness: Brightness.light,
    );
