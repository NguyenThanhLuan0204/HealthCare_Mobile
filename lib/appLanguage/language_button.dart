import 'package:fit/appLanguage/language_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageButton extends StatelessWidget {
  final locales = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'Hindi', 'locale': const Locale('hi', 'IN')},
    {'name': 'German', 'locale': const Locale('de', 'DE')},
    {'name': 'Vietnamese', 'locale': const Locale('vi', 'VN')},
  ];

  LanguageButton({Key? key}) : super(key: key);

  // showLocaleDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       title: const Text("Choose your language"),
  //       content: Container(
  //         width: double.maxFinite,
  //         child: ListView.separated(
  //             shrinkWrap: true,
  //             itemBuilder: (context, index) => InkWell(
  //                   child: Padding(
  //                     child: Text(locales[index]['name'].toString()),
  //                     padding: const EdgeInsets.symmetric(vertical: 8),
  //                   ),
  //                   onTap: () => updateLocale(
  //                       locales[index]['locale'] as Locale, context),
  //                 ),
  //             separatorBuilder: (context, index) => const Divider(
  //                   color: Colors.black,
  //                 ),
  //             itemCount: 4),
  //       ),
  //     ),
  //   );
  // }

  // updateLocale(Locale locale, BuildContext context) {
  //   Navigator.of(context).pop();
  //   Get.updateLocale(locale);
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(context, MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return const LanguagePage();
          },
        ))
      },
      // onTap: () => showLocaleDialog(context),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            height: 48,
            width: 374,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor,
                    // spreadRadius: 10,
                    blurRadius: 3,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                'Languages'.tr,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const Positioned.fill(
            left: 20,
            child: Align(
              child: Icon(
                Icons.language,
                color: Colors.green,
              ),
              // child: ChangeThemeButtonWidget(),
              alignment: Alignment.centerLeft,
            ),
          )
        ],
      ),
    );
  }
}
