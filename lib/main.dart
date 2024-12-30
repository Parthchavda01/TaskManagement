import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:taskmanagementapp/models/theme_model.dart';
import 'package:taskmanagementapp/services/preferences_service.dart';
import 'package:taskmanagementapp/utils/dimensions.dart';
import 'package:taskmanagementapp/utils/text_styles.dart';
import 'package:taskmanagementapp/views/task_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(ThemeModelAdapter());
  await Hive.openBox(themeBox); //  Box where theme preference is stored.

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
                  ? Colors.white // Dark theme appBarTheme
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
                  : Colors.black)),
      home: const TaskListScreen(),
    );
  }
}
