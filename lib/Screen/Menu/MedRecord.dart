import 'package:fit/Screen/Add/Add_Hospital.dart';
import 'package:fit/Screen/Table/MedRecordTable.dart';
import 'package:fit/Screen/Table/hospitalTable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MedRecord extends StatefulWidget {
  @override
  _MedRecordState createState() => _MedRecordState();
}

class _MedRecordState extends State<MedRecord> {
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
                        MaterialPageRoute(builder: (context) => AddHospital()),
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
            RecordTable(),
          ],
        )
    );
  }
}