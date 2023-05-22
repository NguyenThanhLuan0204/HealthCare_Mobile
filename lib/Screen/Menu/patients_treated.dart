import 'package:fit/Screen/Add/Add_Hospital.dart';
import 'package:fit/Screen/Add/Add_Patient.dart';
import 'package:fit/Screen/Table/PatientTreatedTable.dart';
import 'package:fit/Screen/Table/hospitalTable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Patient_treated extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Patient_treated> {
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddPatient()),
                      ).then((value) => setState(() {}));
                    },
                  ),
                ],
              ),
            ),
            PatientTreatedTable(),
          ],
        )
    );
  }
}

