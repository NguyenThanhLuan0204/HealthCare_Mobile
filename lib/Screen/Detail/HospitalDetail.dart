import 'dart:convert';

import 'package:fit/models/hospitalModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class HospitalDetail extends StatefulWidget {
  Hospital hospital;
  HospitalDetail({Key? key, required this.hospital}) : super(key: key);
  @override
  _HospitalDetailState createState() => _HospitalDetailState();
}

class _HospitalDetailState extends State<HospitalDetail> {
  TextEditingController name=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController phone=TextEditingController();
  @override
  Widget build(BuildContext context) {
    name.text=widget.hospital.name!;
    address.text=widget.hospital.address!;
    phone.text=widget.hospital.phone!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Hospital Detail".tr),
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
                          var token= await FlutterSecureStorage().read(key: 'token');
                          var headers = {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer $token'
                          };
                          var request = http.Request('POST', Uri.parse('http://192.168.1.49:5000/api/v1/hospital/delete_hospital'));
                          request.body = json.encode({
                            "id": "${widget.hospital.key}"
                          });
                          request.headers.addAll(headers);

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
                  Text(widget.hospital.name!,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text("Address: ".tr+
                    widget.hospital.address!,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text("SDT: ".tr+
                    widget.hospital.phone!,
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
                    return AlertDialog(
                      title: Text('Edit Infomation'.tr),
                      content: Form(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller:name,
                              decoration: InputDecoration(labelText: "Name".tr),
                            ),
                            TextFormField(
                              controller:address,
                              decoration: InputDecoration(labelText: "Address".tr),
                            ),
                            TextFormField(
                              controller:phone,
                              decoration: InputDecoration(labelText: "Phone".tr),
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: Text("Save".tr),
                          onPressed: () {
                            // Add your code here to save the changes
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
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