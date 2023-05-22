import 'package:fit/darkmode/component/change_button_widget.dart';
import 'package:flutter/material.dart';

class DarkModePage extends StatelessWidget {
  const DarkModePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Dark mode',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
           ChangeThemeButtonWidget(),
        ],
      ),
    );
  }
}
