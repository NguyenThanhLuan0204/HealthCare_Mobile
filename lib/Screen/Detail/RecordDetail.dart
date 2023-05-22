import 'dart:convert';

import 'package:fit/Controller/getData/HospitalData.dart';
import 'package:fit/models/PatientTreatedModel.dart';
import 'package:fit/models/RecordModel.dart';
import 'package:fit/models/hospitalModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class MedRecordDetail extends StatefulWidget {
  MedRecord medRecord;
  MedRecordDetail({Key? key, required this.medRecord}) : super(key: key);
  @override
  _MedRecordDetailState createState() => _MedRecordDetailState();
}

class _MedRecordDetailState extends State<MedRecordDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Chi tiết Bệnh Án"),
        ),
        body: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Full Name: "+widget.medRecord.patient!.name!),
                    Text("CCCD: "+widget.medRecord.patient!.cCCD!),
                    Text("Doctor: "+widget.medRecord.doctor!.name!),
                    Text("Email Doctor: "+widget.medRecord.doctor!.email!),
                    Text("Hospital: "+widget.medRecord.hospital!.name!),
                    Text(""),
                  ],
                )),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [Text("Age: "+widget.medRecord.patient!.age!.toString()), Text(widget.medRecord.patient!.gender!.toString()=="1"?"Male":"Female")],
                    ),
                    Text("Phone Patient: "+widget.medRecord.patient!.phone!),
                    Text('Phone Doctor: '+widget.medRecord.doctor!.phone!),
                    Text('Specialist: '+widget.medRecord.doctor!.specialist!),
                    Text('Phone Hospital: '+widget.medRecord.hospital!.phone!),
                  ],
                )),
              ],
            ),
            Text('Address Hospital: '+widget.medRecord.hospital!.address!),
            Text('IOT Device: '+widget.medRecord.iotId!.nameDevice!+"-"+widget.medRecord.iotId!.ipMac!),
            Text(
              "Vital Signs",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('cp: '+widget.medRecord.vitalSigns![2].toString()),
                    Text("restecg: "+widget.medRecord.vitalSigns![6].toString()),
                    Text('slope: '+widget.medRecord.vitalSigns![10].toString()),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('trestbps: '+widget.medRecord.vitalSigns![3].toString()),
                    Text("thalach: "+widget.medRecord.vitalSigns![7].toString()),
                    Text('ca: '+widget.medRecord.vitalSigns![11].toString()),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('chol: '+widget.medRecord.vitalSigns![4].toString()),
                    Text("exang: "+widget.medRecord.vitalSigns![8].toString()),
                    Text('thal: '+widget.medRecord.vitalSigns![12].toString()),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('fbs: '+widget.medRecord.vitalSigns![5].toString()),
                    Text("oldpeak: "),
                    Text(''),
                  ],
                ),

              ],
            ),
            // Text(
            //   "Action",
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            // ),
            // Text("Predictor "+widget.medRecord.)
          ],
        )));
  }
}
