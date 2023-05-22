import 'dart:convert';

import 'package:fit/Controller/getData/HospitalData.dart';
import 'package:fit/models/hospitalModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddPatient extends StatefulWidget {
  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController cCCD = TextEditingController();
  TextEditingController hospitalname = TextEditingController();
  HospitalName _selectedValue=HospitalName.fromJson({
    "value": "none",
    "label": "none"
  });
  String _selectedValue1 = '';
  @override
  void dispose() {
    hospitalname.dispose();
    gender.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    gender.text = _selectedValue1;
    hospitalname.text = _selectedValue.label!;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HospitalName>>(
      future: getHospitalListName(),
      builder: (contextfuture, snapshot) {
        print("snapshot.hasdata: " + snapshot.hasData.toString());
        List<HospitalName> items = [];
        if (snapshot.hasData) {
          print(snapshot.data!.length);
          items = snapshot.data!;
        }
        var selectedItem;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text("Add Patient"),
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
                  controller: age,
                  decoration: InputDecoration(labelText: 'Age'),
                  validator: (value) {
                    if (value!.length == 0) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: gender,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    suffixIcon: PopupMenuButton<String>(
                      itemBuilder: (BuildContext context1) {
                        List<String> genderitem=['Male','Female'];
                        return genderitem
                            .map((value) =>
                            PopupMenuItem(child: Text(value), value: value))
                            .toList();
                      },
                      onSelected: (value) {
                        setState(() {
                          _selectedValue1 = value!;
                          gender.text = _selectedValue1;
                        });
                      },
                      child: Icon(Icons.arrow_drop_down),
                    ),
                  ),
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
                  controller: cCCD,
                  decoration: InputDecoration(labelText: 'CCCD'),
                  validator: (value) {
                    if (value!.length == 0) {
                      return 'Please enter Specialist';
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
                            .map((value1) =>
                            PopupMenuItem(child: Text(value1.label!), value: value1))
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
                            'http://157.245.204.4:8080/api/v1/patient/add_patient'));
                    request.body = json.encode(
                        {
                          "name": name.text.toString(),
                          "age": age.text.toString(),
                          "gender": gender.text.toString()=="Male"?1:0,
                          "phone": phone.text.toString(),
                          "CCCD": cCCD.text.toString(),
                          "hospital_id": _selectedValue.value.toString(),
                          "status": "false"
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
