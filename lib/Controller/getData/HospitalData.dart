import 'dart:convert';

import 'package:fit/models/hospitalModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
Future<List<Hospital>> getHospitalList() async {
  var token=await FlutterSecureStorage().read(key: 'token');
  var headers = {
    'Authorization': 'Bearer $token'
  };
  var request = http.Request('GET', Uri.parse('http://157.245.204.4:8080/api/v1/hospital/get_all'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var result=json.decode(await response.stream.bytesToString());
    List<Hospital> hospitals = [];
    for (var hospital in result) {
      hospitals.add(Hospital.fromJson(hospital));
    }
    return hospitals;
  }
  else {
    print(response.reasonPhrase);
  }
return [];

}
Future<List<HospitalName>> getHospitalListName() async {
  var token=await FlutterSecureStorage().read(key: 'token');
  var headers = {
    'Authorization': 'Bearer $token'
  };
  var request = http.Request('GET', Uri.parse('http://157.245.204.4:8080/api/v1/hospital/get_all_cbb'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var result=json.decode(await response.stream.bytesToString());
    List<HospitalName> hospitals = [];
    for (var hospital in result) {
      hospitals.add(HospitalName.fromJson(hospital));
    }
    return hospitals;
  }
  else {
    print(response.reasonPhrase);
  }
  return [];
}