import 'package:fit/Controller/getData/PatientTreatedData.dart';
import 'package:fit/Screen/Detail/PatientTreatedDetail.dart';
import 'package:fit/models/PatientTreatedModel.dart';
import 'package:flutter/material.dart';

class PatientTreatedTable extends StatefulWidget {
  @override
  _PatientTreatedTableState createState() => _PatientTreatedTableState();
}

class _PatientTreatedTableState extends State<PatientTreatedTable> {
  ListTile makeListTile(PatientTreated pa) => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Icon(Icons.person, color: Colors.white),
      ),
      title: Text(
        pa.name!,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(pa.age!.toString()+" tuổi",
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
            builder: (context) => PatientTreatedDetail(patientTreated:pa,),
          ),
        ).then((value) => setState(() {}));
      }
  );
  Card makeCard(PatientTreated pa) => Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
      child: makeListTile(pa),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: getPatientTreatedList(),
        builder: (context, snapshot) {
          print(snapshot.hasData.toString());
          if (snapshot.hasData) {
            List<PatientTreated> data = snapshot.data!;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: data.length, // Add one to the item count to include the labels row
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
