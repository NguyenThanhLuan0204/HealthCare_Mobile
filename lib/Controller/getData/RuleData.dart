import 'dart:convert';

import 'package:fit/models/DoctorModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../models/RuleModel.dart';
Future<List<Rule>> getRuleList() async {
  var token=await FlutterSecureStorage().read(key: 'token');
  var headers = {
    'Authorization': 'Bearer $token'
  };
  var request = http.Request('GET', Uri.parse('http://157.245.204.4:8080/api/v1/rule/getRule'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var result=json.decode(await response.stream.bytesToString());
    List<Rule> doctors = [];
    for (var doctor in result) {
      doctors.add(Rule.fromJson(doctor));
    }
    return doctors;
  }
  else {
    print(response.reasonPhrase);
  }
  return [];

}