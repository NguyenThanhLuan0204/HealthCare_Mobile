import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDevice extends StatefulWidget {
  @override
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  final _formKey = GlobalKey<FormState>();
  bool light=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Add Device"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value!.length == 0) {
                  return 'Please enter a name';
                }
                return null;
              },
              onSaved: (value) {},
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Address'),
              validator: (value) {
                if (value!.length == 0) {
                  return 'Please enter an address';
                }
                return null;
              },
              onSaved: (value) {},
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Hospital'),
              validator: (value) {
                if (value!.length == 0) {
                  return 'Please enter an address';
                }
                return null;
              },
              onSaved: (value) {},
            ),
            Row(
              children: [
                Text("Do you Active this Device now? "),
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: Text('Confirm'.tr),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Perform the confirm action
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
