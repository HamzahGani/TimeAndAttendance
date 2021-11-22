import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:time_and_attendance/admin/model/past_visits.dart';

class PunchedVisitsProvider extends ChangeNotifier {
  PunchedVisits data;
  Future getData(context, String companyID, String date) async {
    // set up POST request arguments
    final url =
    Uri.parse('https://www.zentrack.co.za/API/get_punched_visits.php');
    final headers = {"Content-type": "application/json"};
    var json = '{"CompanyID": "'+ companyID +'", "Date": "'+ date +'"}';

    // make POST request
    final response = await post(url, headers: headers, body: json);

    // this API passes back the id of the new item added to the body
    var mJson = jsonDecode(response.body);
    // now we have a json...
    data = PunchedVisits.fromJson(mJson);
    notifyListeners();
  }

}