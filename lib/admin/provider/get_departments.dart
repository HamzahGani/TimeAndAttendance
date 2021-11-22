import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:time_and_attendance/admin/model/get_departments.dart';

class GetDepartmentsProvider extends ChangeNotifier {
  GetDepartments data;
  Future getData(context, String companyID) async {
    // set up POST request arguments
    final url =
    Uri.parse('https://www.zentrack.co.za/API/get_departments.php');
    final headers = {"Content-type": "application/json"};
    var json = '{"CompanyID": "'+ companyID +'"}';

    // make POST request
    final response = await post(url, headers: headers, body: json);
    print(response.body);
    // this API passes back the id of the new item added to the body
    var mJson = jsonDecode(response.body);
    // now we have a json...
    data = GetDepartments.fromJson(mJson);
    notifyListeners();
  }

}