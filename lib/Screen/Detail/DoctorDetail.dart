import 'dart:convert';

import 'package:fit/Controller/getData/HospitalData.dart';
import 'package:fit/models/DoctorModel.dart';
import 'package:fit/models/hospitalModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/DoctorModel.dart';
class DoctorDetail extends StatefulWidget {
  Doctor doctor;
  DoctorDetail({Key? key, required this.doctor}) : super(key: key);
  @override
  _DoctorDetailState createState() => _DoctorDetailState();
}

class _DoctorDetailState extends State<DoctorDetail> {
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
  Widget build(BuildContext context) {
    name.text=widget.doctor.name!;
    phone.text=widget.doctor.phone!;
    specialist.text=widget.doctor.specialist!;
    email.text=widget.doctor.email!;
    _selectedValue.label=widget.doctor.hospitalId!.name;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Doctor Detail".tr),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                bool confirm = await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Confirm'.tr),
                      content: Text('Are you sure you want to delete this item?'.tr),
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child:  Text('Cancel'.tr),
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
                            var token= await FlutterSecureStorage().read(key: 'token');
                            var headers = {
                              'Content-Type': 'application/json',
                              'Authorization': 'Bearer $token'
                            };
                            var request = http.Request('POST', Uri.parse('http://192.168.1.49:5000/api/v1/doctor/delete_doctor'));
                            request.body = json.encode({
                              "doctorId":{
                                "id":widget.doctor.sId
                              }
                            });
                            request.headers.addAll(headers);
                            print(widget.doctor.sId);
                            http.StreamedResponse response = await request.send();

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
                                          Navigator.of(context).pop(); // close 2nd dialog
                                          Navigator.of(context).pop(true);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            else {
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
                      Text(widget.doctor.name!,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text("Phone: ".tr+
                          widget.doctor.phone!,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text("Specialist: ".tr+
                          widget.doctor.specialist!,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text("Email: "+
                          widget.doctor.email!,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text("Hospital Name: ".tr+
                 widget.doctor.hospitalId!.name!,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
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
                          builder: (context,snapshot){
                            List<HospitalName> items = [];
                            if (snapshot.hasData) {
                              print(snapshot.data!.length);
                              items = snapshot.data!;
                            }
                            return  AlertDialog(
                              title: Text('Edit Infomation'.tr),
                              content: Form(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: name,
                                      decoration: InputDecoration(labelText: 'Name'.tr),
                                      validator: (value) {
                                        if (value!.length == 0) {
                                          return 'Please enter a name';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: phone,
                                      decoration: InputDecoration(labelText: 'Phone'.tr),
                                      validator: (value) {
                                        if (value!.length == 0) {
                                          return 'Please enter phone';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: specialist,
                                      decoration: InputDecoration(labelText: 'Specialist'.tr),
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
                                  ],
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
                                  style: ElevatedButton.styleFrom(primary: Colors.green),
                                  onPressed: () async {
                                    var token = await FlutterSecureStorage().read(key: 'token');
                                    var headers = {
                                      'Content-Type': 'application/json',
                                      'Authorization': 'Bearer $token'
                                    };
                                    var request = http.Request(
                                        'PUT',
                                        Uri.parse(
                                            'http://192.168.1.49:5000/api/v1/doctor/update_doctor'));
                                    request.body = json.encode(
                                        {
                                          "doctorUpdate": {
                                            "id": widget.doctor.sId,
                                            "name": name.text.toString(),
                                            "phone": phone.text.toString(),
                                            "specialist": specialist.text.toString(),
                                            "email": email.text.toString(),
                                            "Hospital_Id": _selectedValue.value
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
                            );
                          },
                        );
                      },
                    );

                  },
                ),
              ],
            )
        )
    );
  }
}
void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Thành công"),
        content: Text("Đã sửa thành công"),
        actions: [
          ElevatedButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(true);
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