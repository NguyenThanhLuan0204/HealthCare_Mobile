import 'package:fit/Screen/Table/deviceTable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Add/Add_Device.dart';
import '../Add/Add_Hospital.dart';


class Device extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Device> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body:Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Add'.tr),
                        Icon(Icons.add),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddDevice()),
                      );
                    },
                  ),
                  Container(
                    width:200,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search...',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            DeviceTable(),
          ],
        )
    );
  }
}

