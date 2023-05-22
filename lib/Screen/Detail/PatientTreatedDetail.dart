import 'dart:convert';

import 'package:fit/Controller/getData/HospitalData.dart';
import 'package:fit/models/PatientTreatedModel.dart';
import 'package:fit/models/hospitalModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PatientTreatedDetail extends StatefulWidget {
  PatientTreated patientTreated;
  PatientTreatedDetail({Key? key, required this.patientTreated})
      : super(key: key);
  @override
  _PatientTreatedDetailState createState() => _PatientTreatedDetailState();
}

class _PatientTreatedDetailState extends State<PatientTreatedDetail> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController cCCD = TextEditingController();
  TextEditingController hospitalname = TextEditingController();
  HospitalName _selectedValue =
      HospitalName.fromJson({"value": "none", "label": "none"});
  String _selectedValue1 = '';
  @override
  Widget build(BuildContext context) {
    name.text = widget.patientTreated.name!;
    age.text = widget.patientTreated.age!.toString();
    gender.text = widget.patientTreated.gender == 1 ? "Male" : "FeMale";
    phone.text = widget.patientTreated.phone!;
    cCCD.text = widget.patientTreated.cCCD!;
    _selectedValue.label = widget.patientTreated.hospitalId!.name;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Chi tiết bệnh nhân"),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                bool confirm = await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Confirm'.tr),
                      content:
                          Text('Are you sure you want to delete this item?'.tr),
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: Text('Cancel'.tr),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: Text('Delete'.tr),
                          onPressed: () async {
                            var token =
                                await FlutterSecureStorage().read(key: 'token');
                            var headers = {
                              'Content-Type': 'application/json',
                              'Authorization': 'Bearer $token'
                            };
                            var request = http.Request(
                                'POST',
                                Uri.parse(
                                    'http://157.245.204.4:8080/api/v1/patient/delete_patient'));
                            request.body = json.encode(
                               {"id": [widget.patientTreated.sId]}
                            );
                            print(request.body);
                            request.headers.addAll(headers);

                            http.StreamedResponse response =
                                await request.send();

                            if (response.statusCode == 200) {
                              print(await response.stream.bytesToString());
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Success'.tr),
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                        ),
                                        child: Text("ok"),
                                        onPressed: () {
                                          // Add your code here to save the changes
                                          Navigator.of(context)
                                              .pop(); // close 2nd dialog
                                          Navigator.of(context).pop(true);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              print(response.reasonPhrase);
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
                if (confirm) {
                  // Perform the delete action
                }
              },
            ),
          ],
        ),
        body: Container(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.patientTreated.name!,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Age: ".tr + widget.patientTreated.age!.toString(),
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        "Gender: ".tr,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        widget.patientTreated.gender!.toString()=="0"?"Woman":"Man",
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Phone: ".tr + widget.patientTreated.phone!,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "CCCD/CMND: " + widget.patientTreated.cCCD!,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Hospital: ".tr + widget.patientTreated.hospitalId!.name!,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.edit),
                    Text('Edit'.tr),
                  ],
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FutureBuilder(
                          future: getHospitalListName(),
                          builder: (context, snapshot) {
                            List<HospitalName> items = [];
                            if (snapshot.hasData) {
                              print(snapshot.data!.length);
                              items = snapshot.data!;
                            }
                            return AlertDialog(
                              title: Text("Edit Information".tr),
                              content: SingleChildScrollView(
                                child: Form(
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: name,
                                        decoration:
                                            InputDecoration(labelText: 'Name'.tr),
                                        validator: (value) {
                                          if (value!.length == 0) {
                                            return 'Please enter a name';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: age,
                                        decoration:
                                            InputDecoration(labelText: 'Age'.tr),
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
                                          labelText: 'Gender'.tr,
                                          suffixIcon: PopupMenuButton<String>(
                                            itemBuilder: (BuildContext context1) {
                                              List<String> genderitem = [
                                                'Male',
                                                'Female'
                                              ];
                                              return genderitem
                                                  .map((value) => PopupMenuItem(
                                                      child: Text(value),
                                                      value: value))
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
                                        decoration:
                                            InputDecoration(labelText: 'Phone'.tr),
                                        validator: (value) {
                                          if (value!.length == 0) {
                                            return 'Please enter phone';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: cCCD,
                                        decoration:
                                            InputDecoration(labelText: 'CCCD'),
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
                                          suffixIcon:
                                              PopupMenuButton<HospitalName>(
                                            itemBuilder: (BuildContext context) {
                                              return items
                                                  .map((value1) => PopupMenuItem(
                                                      child: Text(value1.label!),
                                                      value: value1))
                                                  .toList();
                                            },
                                            onSelected: (value) {
                                              setState(() {
                                                _selectedValue = value;
                                                hospitalname.text =
                                                    _selectedValue.label!;
                                              });
                                            },
                                            child: Icon(Icons.arrow_drop_down),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                  ),
                                  child: Text("Cancel".tr),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                                ElevatedButton(
                                  child: Text('Save'.tr),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green),
                                  onPressed: () async {
                                    var token = await FlutterSecureStorage()
                                        .read(key: 'token');
                                    var headers = {
                                      'Content-Type': 'application/json',
                                      'Authorization': 'Bearer $token'
                                    };
                                    var request = http.Request(
                                        'PUT',
                                        Uri.parse(
                                            'http://157.245.204.4:8080/api/v1/patient/update_patient'));
                                    request.body = json.encode({
                                      "patientUD": {
                                        "id": widget.patientTreated.sId,
                                        "name": name.text.toString(),
                                        "age": age.text.toString(),
                                        "gender":
                                            gender.text.toString() == "Male"
                                                ? 1
                                                : 0,
                                        "phone": phone.text.toString(),
                                        "CCCD": cCCD.text.toString(),
                                        "Hospital_Id":
                                            _selectedValue.value.toString(),
                                        "status":widget.patientTreated.status
                                      }
                                    });
                                    print(request.body);
                                    request.headers.addAll(headers);

                                    http.StreamedResponse response =
                                        await request.send();
                                    print(
                                        await response.stream.bytesToString());
                                    if (response.statusCode == 200) {
                                      showSuccessDialog(context);
                                    } else {
                                      print(response.reasonPhrase);
                                      showSuccessDialogfalse(context);
                                    }
                                  },
                                ),
                              ],
                            );
                          });
                    },
                  );
                },
              ),
            ),
          ],
        )));
  }
}

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
