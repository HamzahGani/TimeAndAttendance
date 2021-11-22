import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:time_and_attendance/admin/admin_dashboard.dart';
import 'package:time_and_attendance/login_page.dart';
import 'package:http/http.dart';

class AddEmployee extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String companyID;
  final String designation;
  final String department;
  final String photo;
  const AddEmployee(
      {Key key,
      this.firstName,
      this.lastName,
      this.email,
      this.mobileNumber,
      this.companyID,
      this.designation,
      this.department,
      this.photo})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  List dataDesig = List();
  List dataDept = List();
  String _mySelection;
  String _mySelection1;
  Future myFuture;
  Future myFuture1;
  Future<String> fetchDesig(String companyID) async {
    const String uri = 'https://www.zentrack.co.za/API/get_designations.php';
    var json = '{"CompanyID": "' + companyID + '"}';
    var res = await post(Uri.parse(uri),
        headers: {"Accept": "application/json"}, body: json);

    var resBody = jsonDecode(res.body);
    Map<String, dynamic> data1 = Map<String, dynamic>.from(resBody);
    setState(() {
      dataDesig = data1['designations'];
    });

    print(dataDesig.toString());

    return "Loaded Successfully";
  }

  Future<String> fetchDept(String companyID) async {
    const String uri = 'https://www.zentrack.co.za/API/get_departments.php';
    var json = '{"CompanyID": "' + companyID + '"}';
    var res = await post(Uri.parse(uri),
        headers: {"Accept": "application/json"}, body: json);

    var resBody = jsonDecode(res.body);
    Map<String, dynamic> data2 = Map<String, dynamic>.from(resBody);
    setState(() {
      dataDept = data2['departments'];
    });

    print(dataDept.toString());

    return "Loaded Successfully";
  }

  @override
  void initState() {
    myFuture = fetchDesig(widget.companyID);
    myFuture1 = fetchDept(widget.companyID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var drawerHeader = UserAccountsDrawerHeader(
        accountName: Text(widget.firstName + ' ' + widget.lastName),
        accountEmail: Text(widget.email),
        currentAccountPicture: CircleAvatar(
          radius: 80.0,
          backgroundImage: NetworkImage(
              "https://www.zentrack.co.za/profileImages/" + widget.photo),
          backgroundColor: Colors.white,
        ));
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          leading: Icon(Icons.house),
          title: const Text('Home'),
          onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => AdminDashboard(
                      firstName: widget.firstName,
                      lastName: widget.lastName,
                      email: widget.email,
                      mobileNumber: widget.mobileNumber,
                      companyName: "widget.companyName",
                      designation: widget.designation,
                      department: widget.department,
                      photo: widget.photo,
                    )),
            (Route<dynamic> route) => false,
          ),
        ),
        ListTile(
          leading: Icon(Icons.add),
          title: const Text('Extra Button'),
          onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => AdminDashboard(
                      firstName: widget.firstName,
                      lastName: widget.lastName,
                      email: widget.email,
                      mobileNumber: widget.mobileNumber,
                      companyName: "widget.companyName",
                      designation: widget.designation,
                      department: widget.department,
                      photo: widget.photo,
                    )),
            (Route<dynamic> route) => false,
          ),
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: const Text('Logout'),
          onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false,
          ),
        ),
      ],
    );

    return Scaffold(
        body: Column(children: <Widget>[
          Material(
              child: Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                      child: Column(children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "First Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "First Name cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ])))),
          Material(
              child: Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                      child: Column(children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Last Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Last cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ])))),
          Material(
              child: Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                      child: Column(children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "E-mail",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Email cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ])))),
          Material(
              child: Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                      child: Column(children: [
                    DropdownButton(
                      items: dataDesig.map((item) {
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
                  ])))),
          Material(
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
                          _mySelection1 = newVal;
                        });
                      },
                      value: _mySelection1,
                    ),
                  ])))),
          Material(
              child: Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                      child: Column(children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Mobile Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Mobile Number cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ])))),
          Material(
              child: Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                      child: Column(children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Company Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Company Name cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ])))),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, otherwise false.
              if (_formKey.currentState.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.

                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')));
              }
            },
            child: const Text('Submit'),
          ),
        ]),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Add Employee"),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminDashboard(
                          firstName: widget.firstName,
                          lastName: widget.lastName,
                          email: widget.email,
                          mobileNumber: widget.mobileNumber,
                          companyName: "Zentyl",
                          designation: widget.designation,
                          department: widget.department,
                          photo: widget.photo,
                        )),
                (Route<dynamic> route) => false,
              )
            },
          ),
        ),
        endDrawer: Drawer(
          child: drawerItems,
        ));
  }
}
