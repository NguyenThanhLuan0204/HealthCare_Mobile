//
// import 'package:fit/appLanguage/constanst.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
//
// class ChangeThemeButtonWidget extends StatefulWidget {
//   const ChangeThemeButtonWidget({Key? key}) : super(key: key);
//
//   @override
//   State<ChangeThemeButtonWidget> createState() =>
//       _ChangeThemeButtonWidgetState();
// }
//
// class _ChangeThemeButtonWidgetState extends State<ChangeThemeButtonWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Switch.adaptive(
//       value: Get.isDarkMode,
//       activeColor: Colors.grey[600],
//       onChanged: (value) {
//         value=!value;
//         //  print("value: $value");
//         // print("themecode: $themeCode");
//         setState(() {
//           String themeCode = value ? "dark" : "light";
//           GetStorage('MyStorage').write(THEME_KEY, themeCode);
//           Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
//         });
//       },
//     );
//   }
// }

import 'package:fit/appLanguage/constanst.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    String themeCode = isDarkMode.value ? "dark" : "light";
    GetStorage('MyStorage').write(THEME_KEY, themeCode);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}

class ChangeThemeButtonWidget extends StatelessWidget {
  final ThemeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (controller) => Switch.adaptive(
        value: controller.isDarkMode.value,
        activeColor: Colors.grey[600],
        onChanged: (value) {
          controller.toggleTheme();
        },
      ),
    );
  }
}

