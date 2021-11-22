import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test App",
      home: ManageGeoFence(),
    );
  }
}

class ManageGeoFence extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String companyName;
  final String designation;
  final String department;
  final String photo;
  String date;
  ManageGeoFence(
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
    return _ManageGeoFence();
  }
}

class _ManageGeoFence extends State<ManageGeoFence> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configure Geo Fence"),
        backgroundColor: Colors.lightBlue, //background color of app bar
      ),
      body: Text("Gary"),);
  }
}

