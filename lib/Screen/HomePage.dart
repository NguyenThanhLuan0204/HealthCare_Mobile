import 'package:fit/Screen/Menu/Analytics.dart';
import 'package:fit/Screen/Menu/MedRecord.dart';
import 'package:fit/Screen/Menu/NotificationManagerScreen.dart';
import 'package:fit/Screen/Menu/dashboard.dart';
import 'package:fit/Screen/Menu/device.dart';
import 'package:fit/Screen/Menu/doctor.dart';
import 'package:fit/Screen/Menu/medicalLawbook.dart';
import 'package:fit/Screen/Menu/patients_treated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'Menu/hospital.dart';
import 'Menu/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

final kTitleTextStyle = TextStyle(
  fontSize: (10 * 1.7),
  fontWeight: FontWeight.w600,
);
final kCaptionTextStyle = TextStyle(
  fontSize: (10 * 1.3),
  fontWeight: FontWeight.w100,
);

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _title = 'Dashboard'.tr;
  Widget _body = Dashboard();
  void handleMenuItemSelected(String title, Widget body) {
    Navigator.pop(context);
    setState(() {
      _title = title;
      _body = body;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: isAdmin(),
        builder: (context,snapshot) {
          if(snapshot.hasData){
            bool isAdmin=snapshot.data!;
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor:Colors.green,
                title: Text(_title),
                actions: [
                  _selectedIndex==0?IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationsPage(
                          ),
                        ),
                      ).then((value) => setState(() {}));
                    },
                  ):SizedBox(),

                ],
              ),
              drawer: Drawer(
                backgroundColor:Theme.of(context).scaffoldBackgroundColor,
                //backgroundColor:Colors.white,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 250.0,
                      child: DrawerHeader(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 10 * 10,
                              width: 10 * 10,
                              margin: EdgeInsets.only(top: 10 * 3),
                              child: Stack(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 10 * 5,
                                    backgroundImage: AssetImage('images/fitimage.png'),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      height: 10 * 2.5,
                                      width: 10 * 2.5,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).backgroundColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        heightFactor: 10 * 1.5,
                                        widthFactor: 10 * 1.5,
                                        child: Icon(
                                          Icons.edit,
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          size: (10 * 1.5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10 * 2),
                            FutureBuilder<String>(
                              future: getDisplayName(),
                              builder: (context,snapshot) {
                                return Text(
                                  snapshot.data.toString(),
                                  style: kTitleTextStyle,
                                );
                              }
                            ),
                            // SizedBox(height: 10 * 0.5),
                            // Text(
                            //   'nguyenthanhluan@gmail.com',
                            //   style: kCaptionTextStyle,
                            // ),
                    SizedBox(height: 10 * 0.5),
                            isAdmin?  Text(
                              'Admin',
                              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                            ): Text(
                              'User',
                              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Dashboard
                    Container(
                      decoration: BoxDecoration(
                        color: _selectedIndex==0 ? Colors.green : Theme.of(context).scaffoldBackgroundColor, // set the color of the Container to red
                      ),
                      child: ListTile(
                        title: Text(
                          'Dashboard'.tr,
                          style: TextStyle(
                              color: _selectedIndex!=0 ? Colors.green : Colors.white // set the color of the Container to red
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _selectedIndex = 0;
                          });
                          handleMenuItemSelected('Dashboard'.tr, Dashboard());
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: _selectedIndex==1 ? Colors.green : Theme.of(context).scaffoldBackgroundColor, // set the color of the Container to red
                      ),
                      child: ListTile(
                        title: Text('Doctors'.tr,style: TextStyle(
                            color: _selectedIndex!=1 ? Colors.green : Colors.white // set the color of the Container to red
                        ),),
                        onTap: () {
                          setState(() {
                            _selectedIndex = 1;
                          });
                          handleMenuItemSelected('Doctors'.tr, DoctorPage());
                        },
                        selectedColor: Colors.red,
                      ),
                    ),
                   Container(
                      decoration: BoxDecoration(
                        color: _selectedIndex==2 ? Colors.green : Theme.of(context).scaffoldBackgroundColor, // set the color of the Container to red
                      ),
                      child: ListTile(
                        title:  Text('Patients'.tr,style: TextStyle(
                            color: _selectedIndex!=2 ? Colors.green : Colors.white // set the color of the Container to red
                        ),),
                        onTap: () {
                          setState(() {
                            _selectedIndex = 2;
                          });
                          handleMenuItemSelected('Patients'.tr, Patient_treated());
                        },
                        selectedColor: Colors.red,
                      ),
                    )  ,
                     Container(
                      decoration: BoxDecoration(
                        color: _selectedIndex==3 ? Colors.green : Theme.of(context).scaffoldBackgroundColor, // set the color of the Container to red
                      ),
                      child: ListTile(
                        title: Text('HeartBeat-IOT'.tr,style: TextStyle(
                            color: _selectedIndex!=3 ? Colors.green : Colors.white // set the color of the Container to red
                        ),),
                        onTap: () {
                          setState(() {
                            _selectedIndex = 3;
                          });
                          handleMenuItemSelected('Hearthbeat-IOT'.tr, Device());
                        },
                        selectedColor: Colors.red,
                      ),
                    )  ,
                    Container(
                      decoration: BoxDecoration(
                        color: _selectedIndex==4 ? Colors.green : Theme.of(context).scaffoldBackgroundColor, // set the color of the Container to red
                      ),
                      child: ListTile(
                        title:  Text('Med-Rules'.tr,style: TextStyle(
                            color: _selectedIndex!=4 ? Colors.green : Colors.white // set the color of the Container to red
                        ),),
                        onTap: () {
                          setState(() {
                            _selectedIndex = 4;
                          });
                          handleMenuItemSelected(
                              'Med-Rules'.tr, medicalLawbook());
                        },
                        selectedColor: Colors.red,
                      ),
                    ),
                     Container(
                      decoration: BoxDecoration(
                        color: _selectedIndex==5 ? Colors.green : Theme.of(context).scaffoldBackgroundColor, // set the color of the Container to red
                      ),
                      child: ListTile(
                        title:  Text('Hospital'.tr,style: TextStyle(
                            color: _selectedIndex!=5 ? Colors.green : Colors.white // set the color of the Container to red
                        ),),
                        onTap: () {
                          setState(() {
                            _selectedIndex = 5;
                          });
                          handleMenuItemSelected('Hospital'.tr, HospitalPage());
                        },
                        selectedColor: Colors.red,
                      ),
                    )  ,
                    Container(
                      decoration: BoxDecoration(
                        color: _selectedIndex==6 ? Colors.green : Theme.of(context).scaffoldBackgroundColor, // set the color of the Container to red
                      ),
                      child: ListTile(
                        title:  Text('Statistics'.tr,style: TextStyle(
                            color: _selectedIndex!=6 ? Colors.green : Colors.white // set the color of the Container to red
                        ),),
                        onTap: () {
                          setState(() {
                            _selectedIndex = 6;
                          });
                          handleMenuItemSelected('Statistics'.tr, Analytics());
                        },
                        selectedColor: Colors.red,
                      ),
                    )  ,
                    Container(
                      decoration: BoxDecoration(
                        color: _selectedIndex==8 ? Colors.green : Theme.of(context).scaffoldBackgroundColor, // set the color of the Container to red
                      ),
                      child: ListTile(
                        title:  Text('Medical-Records'.tr,style: TextStyle(
                            color: _selectedIndex!=8 ? Colors.green : Colors.white // set the color of the Container to red
                        ),),
                        onTap: () {
                          setState(() {
                            _selectedIndex = 8;
                          });
                          handleMenuItemSelected('Medical-Records'.tr, MedRecord());
                        },
                        selectedColor: Colors.red,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: _selectedIndex==7 ? Colors.green : Theme.of(context).scaffoldBackgroundColor, // set the color of the Container to red
                      ),
                      child: ListTile(
                        title:  Text('Setting'.tr,style: TextStyle(
                            color: _selectedIndex!=7 ? Colors.green : Colors.white // set the color of the Container to red
                        ),),
                        onTap: () {
                          setState(() {
                            _selectedIndex = 7;
                          });
                          handleMenuItemSelected('Setting'.tr, ProfilePage());
                        },
                        selectedColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              body: _body,
            );
          }else return CircularProgressIndicator();
        }
      ),
    );
  }
}
Future<String> getDisplayName() async {
  var displayname= await FlutterSecureStorage().read(key: "displayName")??"";
  return displayname;
}