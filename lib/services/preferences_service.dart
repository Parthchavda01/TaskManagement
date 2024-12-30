import 'package:hive/hive.dart';
import 'package:riverpod/riverpod.dart';
import 'package:taskmanagementapp/models/theme_model.dart';

const String themeBox = 'themeBox';
const String themeKey = 'themeKey';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeModel>((ref) {
  final box = Hive.box(themeBox);
  final themePreference = box.get(themeKey, defaultValue: ThemeModel());
  return ThemeNotifier(themePreference);
});

class ThemeNotifier extends StateNotifier<ThemeModel> {
  ThemeNotifier(ThemeModel themeModel) : super(themeModel);

  // Method to toggle the theme between light and dark
  void toggleTheme() {
    final newThemeMode = state.isDarkTheme
        ? ThemeModel(isDarkTheme: false, sortOrder: state.sortOrder)
        : ThemeModel(isDarkTheme: true, sortOrder: state.sortOrder);
    state = newThemeMode; // Update the state to the new theme
    _saveThemePreference(newThemeMode); // Save the new theme to Hive
  }

  // Method to change the sort order (optional)
  void updateSortOrder(String newSortOrder) {
    final updatedTheme =
        ThemeModel(isDarkTheme: state.isDarkTheme, sortOrder: newSortOrder);
    state = updatedTheme; // Update the state
    _saveThemePreference(updatedTheme); // Save the updated preference to Hive
  }

  // Save the theme model to Hive
  void _saveThemePreference(ThemeModel themeModel) async {
    final box = await Hive.openBox(themeBox);
    box.put(themeKey, themeModel); // Save the updated theme model to the box
  }
}
