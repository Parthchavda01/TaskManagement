// theme_data.dart

import 'package:flutter/material.dart';
import 'package:taskmanagementapp/utils/dimensions.dart';
import 'package:taskmanagementapp/utils/text_styles.dart';
import 'package:taskmanagementapp/models/theme_model.dart';

ThemeData customTheme(ThemeModel theme,BuildContext context ) {
  return ThemeData(
          useMaterial3: true,
          brightness: theme.isDarkTheme ? Brightness.dark : Brightness.light,
          dialogTheme: DialogTheme(
            contentTextStyle: openSansTextStyle(context),
            backgroundColor: Colors.white,
            
            titleTextStyle: montserratTextStyle(context),
            insetPadding: EdgeInsets.all(Dimensions.paddingLeftRight10),
            // alignment: MainAxisAlignment.spaceBetween,
            actionsPadding: EdgeInsets.all(Dimensions.paddingLeftRight10 / 2),
          ),
          listTileTheme: ListTileThemeData(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(Dimensions.commonBorderRadius)),
            tileColor: Colors.grey.shade200,
          ),
       
          
              primaryColor: theme.isDarkTheme
              ? Colors.black // Dark theme background
              : Colors.white, // Light theme background ,
          scaffoldBackgroundColor: theme.isDarkTheme
              ? Colors.black // Dark theme background
              : Colors.white, // Light theme background
          appBarTheme: AppBarTheme(iconTheme: IconThemeData(color:theme.isDarkTheme
                  ? Colors.white 
                  : Colors.black ),
              titleTextStyle: montserratTextStyle(context,color: theme.isDarkTheme
                  ? Colors.white 
                  : Colors.black),
              backgroundColor: theme.isDarkTheme
                  ? Colors.black // Dark theme appBarTheme
                  : Colors.white),
          bottomAppBarTheme: BottomAppBarTheme(
              color: theme.isDarkTheme
                  ? Colors.black // Dark theme bottomAppBarTheme
                  : Colors.white),
          checkboxTheme: CheckboxThemeData(
            side: const BorderSide(color: Colors.transparent),
            checkColor: WidgetStatePropertyAll(theme.isDarkTheme
                ? Colors.white // Dark theme background
                : Colors.black),
            fillColor: WidgetStatePropertyAll(theme.isDarkTheme
                ? Colors.black // Dark theme background
                : Colors.white),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: theme.isDarkTheme
                  ? Colors.white // Dark theme bottomAppBarTheme
                  : Colors.black));
}
