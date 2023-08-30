import 'dart:convert';

import 'package:fit/Controller/getData/HospitalData.dart';
import 'package:fit/models/hospitalModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddDoctor extends StatefulWidget {
  @override
  _AddHospitalState createState() => _AddHospitalState();
}

class _AddHospitalState extends State<AddDoctor> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController specialist = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController hospitalname = TextEditingController();
  HospitalName _selectedValue=HospitalName.fromJson({
    "value": "none",
    "label": "none"
  });
  @override
  void dispose() {
    hospitalname.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    hospitalname.text = _selectedValue.value!;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HospitalName>>(
      future: getHospitalListName(),
      builder: (contextfuture, snapshot) {
        List<HospitalName> items = [];
        if (snapshot.hasData) {
          print(snapshot.data!.length);
          items = snapshot.data!;
        }
        //items.add("none");
        var selectedItem;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text("Add Doctor"),
          ),
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.length == 0) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phone,
                  decoration: InputDecoration(labelText: 'phone'),
                  validator: (value) {
                    if (value!.length == 0) {
                      return 'Please enter phone';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: specialist,
                  decoration: InputDecoration(labelText: 'Specialist'),
                  validator: (value) {
                    if (value!.length == 0) {
                      return 'Please enter Specialist';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.length == 0) {
                      return 'Please enter Email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: hospitalname,
                  decoration: InputDecoration(
                    labelText: 'Hospital Name'.tr,
                    suffixIcon: PopupMenuButton<HospitalName>(
                      itemBuilder: (BuildContext context) {
                        return items
                            .map((value) =>
                                PopupMenuItem(child: Text(value.label!), value: value))
                            .toList();
                      },
                      onSelected: (value) {
                        setState(() {
                          _selectedValue = value;
                          hospitalname.text = _selectedValue.label!;
                        });
                      },
                      child: Icon(Icons.arrow_drop_down),
                    ),
                  ),
                ),
                ElevatedButton(
                  child: Text('Confirm'.tr),
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () async {
                    var token = await FlutterSecureStorage().read(key: 'token');
                    var headers = {
                      'Content-Type': 'application/json',
                      'Authorization': 'Bearer $token'
                    };
                    var request = http.Request(
                        'POST',
                        Uri.parse(
                            'http://192.168.1.49:5000/api/v1/doctor/add_doctor'));
                    request.body = json.encode(
                        {
                          "doctorNew":
                          {
                            "doctor":
                            {
                              "name": name.text.toString(),
                              "phone": phone.text.toString(),
                              "specialist": specialist.text.toString(),
                              "email": email.text.toString(),
                              "Hospital_Id": _selectedValue.value
                            }
                          }
                        }
                    );
                    print(request.body);
                    request.headers.addAll(headers);

                    http.StreamedResponse response = await request.send();
                    print(await response.stream.bytesToString());
                    if (response.statusCode == 200) {
                      showSuccessDialog(context);
                    } else {
                      print(response.reasonPhrase);
                      showSuccessDialogfalse(context);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

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
