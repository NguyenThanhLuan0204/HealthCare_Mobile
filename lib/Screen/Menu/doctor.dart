import 'package:fit/Screen/Add/Add_Doctor.dart';
import 'package:fit/Screen/Add/Add_Hospital.dart';
import 'package:fit/Screen/Table/doctorTable.dart';
import 'package:fit/Screen/Table/hospitalTable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class DoctorPage extends StatefulWidget {
  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<DoctorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddDoctor()),
                      ).then((value) => setState(() {}));
                    },
                  ),
                  // Container(
                  //   width:200,
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       prefixIcon: Icon(Icons.search),
                  //       hintText: 'Search...',
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            DoctorTable(),
          ],
        )
    );
  }
}