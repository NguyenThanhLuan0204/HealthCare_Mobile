import 'dart:convert';

import 'package:fit/models/RecordModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<List<MedRecord>> getMedRecordList() async {
  var token=await FlutterSecureStorage().read(key: 'token');
  DateTime now = DateTime.now();
  DateTime tomorrow = now.add(Duration(days: 1));
  DateTime thirtyDaysAgo = now.subtract(Duration(days: 30));
  String tomorrowDate = tomorrow.toString().substring(0, 10);
  String thirtyDaysAgoDate = thirtyDaysAgo.toString().substring(0, 10);
  // var headers = {
  //   'Content-Type': 'application/json',
  //   'Authorization': 'Bearer $token'
  // };
  // var request = http.Request('POST', Uri.parse('http://157.245.204.4:8080/api/v1/mediaRecord/get_media_record'));
  // request.body = json.encode({
  //   "date_start": "$thirtyDaysAgoDate",
  //   "date_end": "$tomorrowDate"
  // });
  // request.headers.addAll(headers);
  //
  // http.StreamedResponse response = await request.send();
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  var request = http.Request('POST', Uri.parse('http://157.245.204.4:8080/api/v1/mediaRecord/get_media_record'));
  request.body = json.encode({
    "date_start": thirtyDaysAgoDate,
    "date_end": tomorrowDate
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    var result=json.decode(await response.stream.bytesToString());
    List<MedRecord> hospitals = [];
    for (var hospital in result) {
      hospitals.add(MedRecord.fromJson(hospital));
    }
    return hospitals;

  }
  else {
    print(response.reasonPhrase);
  }

  return [];
}