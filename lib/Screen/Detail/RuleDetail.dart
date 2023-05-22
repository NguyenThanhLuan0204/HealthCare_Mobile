import 'dart:convert';

import 'package:fit/models/DoctorModel.dart';
import 'package:fit/models/DoctorModel.dart';
import 'package:fit/models/RuleModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/DoctorModel.dart';
class RuleDetail extends StatefulWidget {
  Rule rule;
  RuleDetail({Key? key, required this.rule}) : super(key: key);
  @override
  _RuleDetailState createState() => _RuleDetailState();
}

class _RuleDetailState extends State<RuleDetail> {
  TextEditingController name=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController phone=TextEditingController();
  @override
  Widget build(BuildContext context) {
    name.text=widget.rule.name!;
    address.text=widget.rule.heartRateFrom!.toString();
    phone.text=widget.rule.heartRateTo!.toString();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Rule Detail".tr),
        ),
        body: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.rule.name!,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text("From: ".tr+
                          widget.rule.heartRateFrom!.toString(),
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text("To: ".tr+
                          widget.rule.heartRateTo!.toString(),
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
                                  decoration: InputDecoration(labelText: "From".tr),
                                ),
                                TextFormField(
                                  controller:phone,
                                  decoration: InputDecoration(labelText: "To".tr),
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
                                primary: Colors.green,
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