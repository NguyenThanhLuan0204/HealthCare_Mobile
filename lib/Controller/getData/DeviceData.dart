import 'dart:convert';

import 'package:fit/models/DoctorModel.dart';
import 'package:fit/models/deviceModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
Future<List<Device>> getDeviceList() async {
  var token=await FlutterSecureStorage().read(key: 'token');
  var headers = {
    'Authorization': 'Bearer $token'
  };
  var request = http.Request('GET', Uri.parse('http://157.245.204.4:8080/api/v1/esp/get_hb'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var result=json.decode(await response.stream.bytesToString());
    List<Device> doctors = [];
    for (var doctor in result) {
      doctors.add(Device.fromJson(doctor));
    }
    return doctors;
  }
  else {
    print(response.reasonPhrase);
  }
  return [];

}