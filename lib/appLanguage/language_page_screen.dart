import 'package:fit/appLanguage/language_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Theme.of(context).iconTheme.color,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(children: [
                  MaterialButton(
                    padding: const EdgeInsets.all(10),
                    minWidth: 0,
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xFFEDF0F3),
                      size: 24.0,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Language'.tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 32),
                  ),
                ]),
                const SizedBox(height: 25),
                const LanguageList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
