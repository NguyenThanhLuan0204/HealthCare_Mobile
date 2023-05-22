import 'dart:convert';

import 'package:fit/models/PatientTreatedModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
Future<List<PatientTreated>> getPatientTreatedList() async {
  var token=await FlutterSecureStorage().read(key: 'token');
  var headers = {
    'Authorization': 'Bearer $token'
  };
  var request = http.Request('GET', Uri.parse('http://157.245.204.4:8080/api/v1/patient/get_all'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var result=json.decode(await response.stream.bytesToString());
    List<PatientTreated> doctors = [];
    for (var doctor in result) {
      doctors.add(PatientTreated.fromJson(doctor));
    }
    return doctors;
  }
  else {
    print(response.reasonPhrase);
  }
  return [];

}