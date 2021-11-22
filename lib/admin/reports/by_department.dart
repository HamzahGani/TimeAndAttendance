import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:time_and_attendance/admin/provider/by_department.dart';
import 'package:time_and_attendance/admin/provider/daily_attendance.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test App",
      home: ByDepartment(),
    );
  }
}

class ByDepartment extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String companyName;
  final String designation;
  final String department;
  final String photo;
  String date;
  ByDepartment(
      {Key key,
        this.firstName,
        this.lastName,
        this.email,
        this.mobileNumber,
        this.companyName,
        this.designation,
        this.department,
        this.photo,
        this.date})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ByDepartment();
  }
}

class _ByDepartment extends State<ByDepartment> {
  TextEditingController dateinput = TextEditingController();
  //text editing controller for text field
  List dataDept = List();
  String _mySelection;
  Future myFuture;
  Future<String> fetchDept(String companyID) async {
    const String uri = 'https://www.zentrack.co.za/API/get_departments.php';
    var json = '{"CompanyID": "' + companyID + '"}';
    var res = await post(Uri.parse(uri),
        headers: {"Accept": "application/json"}, body: json);

    var resBody = jsonDecode(res.body);
    Map<String, dynamic> data1 = Map<String, dynamic>.from(resBody);
    setState(() {
      dataDept = data1['departments'];
    });

    print(dataDept.toString());

    return "Loaded Successfully";
  }
  @override
  void initState() {
    fetchDept("1");
    if (widget.date == null || widget.date == "") {
      widget.date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    }
    dateinput.text = widget.date;
    print(dateinput.text); //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("By Department"),
          backgroundColor: Colors.lightBlue, //background color of app bar
        ),
        body: Column(children: <Widget>[
          Center(
              child: Material(
                  child: Container(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                          child: Column(children: [
                            DropdownButton(
                              items: dataDept.map((item) {
                                return DropdownMenuItem(
                                  child: Text(item['name']),
                                  value: item['status'].toString(),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                setState(() {
                                  _mySelection = newVal;
                                });
                              },
                              value: _mySelection,
                            ),
                          ])))),),
          ChangeNotifierProvider<ByDepartmentProvider>(
            create: (context) => ByDepartmentProvider(),
            child: Consumer<ByDepartmentProvider>(
              builder: (context, provider, child) {
                if (provider.data == null) {
                  provider.getData(context, "1", dateinput.text);
                  return const Center(child: CircularProgressIndicator());
                }
                // when we have the json loaded... let's put the data into a data table widget
                return Expanded(
                  // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columnSpacing: 10,
                      columns: const [
                        DataColumn(
                            label: Text('First Name'),
                            tooltip: 'Represents first name of the user.'),
                        DataColumn(
                            label: Text('Total'),
                            tooltip: 'Represents time in of the user.'),
                        DataColumn(
                            label: Text('Present'),
                            tooltip: 'Represents time in of the user.'),
                        DataColumn(
                            label: Text('Absent'),
                            tooltip: 'Represents time out of the user.'),
                      ],
                      rows: provider.data.departments
                          .map((data) =>
                      // we return a DataRow every time
                      DataRow(
                        // List<DataCell> cells is required in every row
                          cells: [
                            DataCell(SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25, //SET width
                                child: Text(data.name))),
                            DataCell(SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25, //SET width
                                child: Text(data.absent))),
                            DataCell(SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25, //SET width
                                child: Text(data.present))),
                            DataCell(SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25, //SET width
                                child: Text(data.absent))),
                          ]))
                          .toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ]));
  }
}
