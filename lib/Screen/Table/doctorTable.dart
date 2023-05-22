import 'package:fit/Screen/Detail/DoctorDetail.dart';
import 'package:fit/models/DoctorModel.dart';
import 'package:flutter/material.dart';

import '../../Controller/getData/DoctorData.dart';

class DoctorTable extends StatefulWidget {
  @override
  _DoctorTableState createState() => _DoctorTableState();
}

class _DoctorTableState extends State<DoctorTable> {
  ListTile makeListTile(Doctor Doctor) => ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Icon(Icons.person, color: Colors.white),
      ),
      title: Text(
        Doctor.name!,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(Doctor.email!,
                    style: TextStyle(color: Colors.white))),
          )
        ],
      ),
      trailing:
      Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorDetail(
              doctor: Doctor,
            ),
          ),
        ).then((value) => setState(() {}));
      });
  Card makeCard(Doctor Doctor) => Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
      child: makeListTile(Doctor),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: getDoctorList(),
        builder: (context, snapshot) {
          print(snapshot.hasData.toString());
          if (snapshot.hasData) {
            List<Doctor> data = snapshot.data!;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: data
                  .length, // Add one to the item count to include the labels row
              itemBuilder: (context, index) {
                return makeCard(data[index]);
              },
            );
          } else {
            print("không có dữ liệu");
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
