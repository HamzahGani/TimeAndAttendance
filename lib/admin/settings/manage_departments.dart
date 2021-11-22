import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:time_and_attendance/admin/provider/get_departments.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test App",
      home: ManageDepartments(),
    );
  }
}

class ManageDepartments extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String companyName;
  final String designation;
  final String department;
  final String photo;
  String date;
  ManageDepartments(
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
    return _ManageDepartments();
  }
}

class _ManageDepartments extends State<ManageDepartments> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();

  Future insertDept(
      context, String departmentName, String companyID, int status) async {
    // set up POST request arguments
    final url =
        Uri.parse('https://www.zentrack.co.za/API/insert_Department.php');
    final headers = {"Content-type": "application/json"};
    var json = '{"DepartmentName": "' +
        departmentName +
        '","CompanyID": "' +
        companyID +
        '", "Status": "' +
        status.toString() +
        '"}';

    // make POST request
    final response = await post(url, headers: headers, body: json);
    print(response.body);
  }

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _textEditingController,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Enter any text";
                        },
                        decoration: InputDecoration(
                            hintText: "Please Enter Department Name"),
                      ),
                    ],
                  )),
              title: Text('Add Department'),
              actions: <Widget>[
                InkWell(
                  child: Text('OK   '),
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      insertDept(context, _textEditingController.text, "1", 1);
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Departments"),
        backgroundColor: Colors.lightBlue, //background color of app bar
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await showInformationDialog(context);
              },
              child: Icon(Icons.add, color: Colors.white),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                primary: Colors.blue, // <-- Button color
                onPrimary: Colors.red, // <-- Splash color
              ),
            ),
            ChangeNotifierProvider<GetDepartmentsProvider>(
              create: (context) => GetDepartmentsProvider(),
              child: Consumer<GetDepartmentsProvider>(
                builder: (context, provider, child) {
                  if (provider.data == null) {
                    provider.getData(context, "1");
                    return const Center(child: CircularProgressIndicator());
                  }
                  // when we have the json loaded... let's put the data into a data table widget
                  return Expanded(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child:
                        // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..
                        SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columnSpacing: 10,
                        columns: const [
                          DataColumn(
                              label: Text('First Name'),
                              tooltip: 'Represents first name of the user.'),
                          DataColumn(
                              label: Text('Status'),
                              tooltip: 'Represents time in of the user.'),
                        ],
                        rows: provider.data.departments
                            .map((data) =>
                                // we return a DataRow every time
                                DataRow(
                                    // List<DataCell> cells is required in every row
                                    cells: [
                                      DataCell(SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.5, //SET width
                                          child: Text(data.name))),
                                      DataCell(SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.5, //SET width
                                          child: Text(data.status))),
                                    ]))
                            .toList(),
                      ),
                    ),
                  ));
                },
              ),
            ),
          ]),
    );
  }
}
