


import 'package:hive/hive.dart';

part 'theme_model.g.dart';  

@HiveType(typeId: 0)  
class ThemeModel {
  @HiveField(0)
  final bool isDarkTheme;
 
  
  @HiveField(1)
    String sortOrder;
  
 

  ThemeModel({
    this.isDarkTheme = false,
    this.sortOrder = 'date',
   
  });
}
