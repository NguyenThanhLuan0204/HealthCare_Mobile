import 'dart:convert';

import 'package:fit/models/DoctorModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
Future<List<Doctor>> getDoctorList() async {
  var token=await FlutterSecureStorage().read(key: 'token');
  var headers = {
    'Authorization': 'Bearer $token'
  };
  var request = http.Request('GET', Uri.parse('http://192.168.1.49:5000/api/v1/doctor/get_all_doctor'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var result=json.decode(await response.stream.bytesToString());
    List<Doctor> doctors = [];
    for (var doctor in result) {
      doctors.add(Doctor.fromJson(doctor));
    }
    return doctors;
  }
  else {
    print(response.reasonPhrase);
  }
  return [];

}