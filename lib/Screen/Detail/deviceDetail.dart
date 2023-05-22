import 'package:fit/models/hospitalModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/deviceModel.dart';

class DeviceDetail extends StatefulWidget {
  Device device;
  DeviceDetail({Key? key, required this.device}) : super(key: key);
  @override
  _DeviceDetailState createState() => _DeviceDetailState();
}
@override
class _DeviceDetailState extends State<DeviceDetail> {
  bool light=true;
  @override
  Widget build(BuildContext context) {
    light=widget.device.status!;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Device Detail"),
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
                          onPressed: () {
                            Navigator.of(context).pop(true);
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
                      Text(widget.device.nameDevice!,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        widget.device.ipMac!,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),

                      ),

                      // Text(
                      //   widget.device.hospitalId!.name!,
                      //   style: TextStyle(
                      //     fontSize: 16.0,
                      //     color: Colors.grey,
                      //   ),
                      //
                      // ),
                      Text(
                        widget.device.status==true?"Active":"Inactive",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: widget.device.nameDevice==true?Colors.green:Colors.red,
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
                                  decoration: InputDecoration(labelText: "Name"),
                                ),
                                TextFormField(
                                  decoration: InputDecoration(labelText: "Địa chỉ"),
                                ),
                                TextFormField(
                                  decoration: InputDecoration(labelText: "Hospital"),
                                ),
                                Row(
                                  children: [
                                    Text("Status "),
                                    Switch(
                                      // This bool value toggles the switch.
                                      value: light,
                                      activeColor: Colors.green,
                                      onChanged: (bool value) {
                                        // This is called when the user toggles the switch.
                                        setState(() {
                                          light = value;
                                        });
                                      },
                                    ),
                                  ],
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