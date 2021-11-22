import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:time_and_attendance/admin/model/by_employee.dart';

class ByEmployeeProvider extends ChangeNotifier {
  ByEmployee data;
  Future getData(context, String companyID, String id) async {
    // set up POST request arguments
    final url =
    Uri.parse('https://www.zentrack.co.za/API/get_by_employee.php');
    final headers = {"Content-type": "application/json"};
    var json = '{"CompanyID": "'+ companyID +'", "ID": "'+ id +'"}';

    // make POST request
    final response = await post(url, headers: headers, body: json);
    print(response.body);
    // this API passes back the id of the new item added to the body
    var mJson = jsonDecode(response.body);
    // now we have a json...
    data = ByEmployee.fromJson(mJson);
    notifyListeners();
  }

}