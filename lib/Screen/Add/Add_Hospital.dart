import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class AddHospital extends StatefulWidget {
  @override
  _AddHospitalState createState() => _AddHospitalState();
}

class _AddHospitalState extends State<AddHospital> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController phone=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Add Hospital"),
      ),
      body:Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: name,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value!.length ==0 ) {
                  return 'Please enter a name';
                }
                return null;
              },

            ),
            TextFormField(
              controller: address,
              decoration: InputDecoration(labelText: 'Address'),
              validator: (value) {
                if (value!.length ==0) {
                  return 'Please enter an address';
                }
                return null;
              },
            ),
            TextFormField(
              controller: phone,
              decoration: InputDecoration(labelText: 'Phone'),
              validator: (value) {
                if (value!.length ==0) {
                  return 'Please enter phone number';
                }
                return null;
              },
            ),
            ElevatedButton(
              child: Text('Confirm'.tr),
              style: ElevatedButton.styleFrom(
                primary: Colors.green
              ),
              onPressed: () async {
                var token=await FlutterSecureStorage().read(key: 'token');
                var headers = {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $token'
                };
              print(name.toString());
                var request = http.Request('POST', Uri.parse('http://157.245.204.4:8080/api/v1/hospital/add_hospital'));
                request.body = json.encode({
                  "name": name.text.toString(),
                  "address": address.text.toString(),
                  "phone": phone.text.toString(),
                });
                request.headers.addAll(headers);

                http.StreamedResponse response = await request.send();
                print(await response.stream.bytesToString());
                if (response.statusCode == 200) {
                  showSuccessDialog(context);
                }
                else {
                print(response.reasonPhrase);
                showSuccessDialogfalse(context);
                }

              },
            ),
          ],
        ),
      ),
    );
  }}
// Tạo một hàm để hiển thị thông báo pop-up
void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Thành công"),
        content: Text("Đã thêm thành công"),
        actions: [
          ElevatedButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
void showSuccessDialogfalse(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Thất bại"),
        content: Text("Vui lòng kiểm tra lại !"),
        actions: [
          ElevatedButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
