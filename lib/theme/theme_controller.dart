
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../savices/preferenes_manger.dart';

class ThemeController {
 static final ValueNotifier <ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

 init (){
   bool result = PreferenesManger().getBool("theme") ?? true ;
   themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;


 }
 static toggleTheme() async{
   if (themeNotifier.value == ThemeMode.dark) {
     themeNotifier.value = ThemeMode.light;
    await  PreferenesManger().setBool("theme", false);
   }
   else {
     themeNotifier.value = ThemeMode.dark;
     await PreferenesManger().setBool("theme", true);

   }


 }


}