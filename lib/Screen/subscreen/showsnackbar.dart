import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(String text, bool isSuccess) {
  Get.snackbar('Notification', text,
      dismissDirection: DismissDirection.down,
      isDismissible: true,
      titleText: const Text(
        'Notification',
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      messageText: Text(
        text,
        style: TextStyle(color: Colors.red[600]),
      ),
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM);
}