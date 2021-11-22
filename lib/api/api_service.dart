import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/login_model.dart';

class APIServiceLogin {
  Future<LoginResponseModelLogin> login(LoginRequestModelLogin requestModel) async {
    Uri url = Uri.parse("https://www.zentrack.co.za/API/time_and_atten_login.php");
    const headers = {'Content-Type': 'application/json'};
    final response = await http.post(url,headers: headers, body: jsonEncode(requestModel.toJson()));
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModelLogin.fromJson(
        json.decode(response.body),

      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
