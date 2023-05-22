import 'package:fit/darkmode/component/change_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mode_Dark_Button extends StatelessWidget {

  const Mode_Dark_Button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ThemeController());
    return GestureDetector(
      // onTap: () async => {Get.find<AuthService>().logout()},
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Dark Mode'.tr,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                     ChangeThemeButtonWidget(),
                  ]),
            ),
          ),
          // const Positioned.fill(
          //   right: 20,
          //   child: Align(
          //     // child: Icon(
          //     //   Icons.language,
          //     //   // color: Colors.white,
          //     // ),
          //     child: ChangeThemeButtonWidget(),
          //     alignment: Alignment.centerRight,
          //   ),
          // )
        ],
      ),
    );
  }
}
