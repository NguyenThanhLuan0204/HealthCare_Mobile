import 'dart:convert';
import 'package:http/http.dart' as http;
Future<bool> SignUp(String username,String displayname, String password, String confirmpassword) async{
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('http://157.245.204.4:8080/api/v1/user/signup'));
  request.body = json.encode({
    "username": "$username",
    "password": "$password",
    "confirmPassword": "$confirmpassword",
    "displayName": "$displayname"
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  var data= jsonDecode(await response.stream.bytesToString());
  print(data);
  if (response.statusCode == 201) {
    if(data=="username already used"){
      print('Account tồn tại');
      return false;
    }else {
      return true;
    }
  }
  return false;
}