import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:taskmanagementapp/models/theme_model.dart';
import 'package:taskmanagementapp/services/preferences_service.dart';

import 'package:taskmanagementapp/utils/theme_data.dart';
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
      theme:customTheme(theme,context), // Use custom theme
      home: const TaskListScreen(),
    );
  }
}
