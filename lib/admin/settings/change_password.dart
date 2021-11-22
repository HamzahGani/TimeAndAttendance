import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test App",
      home: ChangePassword(),
    );
  }
}

class ChangePassword extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String companyName;
  final String designation;
  final String department;
  final String photo;
  String date;
  ChangePassword(
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
    return _ChangePassword();
  }
}

class _ChangePassword extends State<ChangePassword> {

  Future getData(context, String firstName, String lastName,String currentPassword,String newPassword) async {
    // set up POST request arguments
    final url =
    Uri.parse('https://www.zentrack.co.za/API/change_password.php');
    final headers = {"Content-type": "application/json"};
    var json = '{"FirstName": "'+ firstName +'","LastName": "'+ lastName +'", "CurrentPassword": "'+ currentPassword +'", "NewPassword" : "'+ newPassword+'"}';
  print(json);
    // make POST request
    final response = await post(url, headers: headers, body: json);
    print(response.body);

  }

  final _changePassKey = GlobalKey<FormState>();
  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showRenewPassword = false;

  Widget _buildCurrentPasswordTextFormField() {
    return Form(
        key: _changePassKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Divider(),
            TextFormField(
              validator: (value){
                if (value == null || value.isEmpty){
                  return "Please Make Sure You Filled Out All The Fields";
                }
                return null;
              },
              obscureText: !_showCurrentPassword,
              decoration: InputDecoration(
                labelText: 'Current Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: _showCurrentPassword ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() => _showCurrentPassword = !_showCurrentPassword);
                  },
                ),
              ),
            ),
            const Divider(),
            TextFormField(
              validator: (value){
                if (value == null || value.isEmpty){
                  return "Please Make Sure You Filled Out All The Fields";
                }
                return null;
              },
              obscureText: !_showNewPassword,
              decoration: InputDecoration(
                labelText: 'New Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: _showNewPassword ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() => _showNewPassword = !_showNewPassword);
                  },
                ),
              ),
            ),
            const Divider(),
            TextFormField(
              validator: (value){
                if (value == null || value.isEmpty){
                  return "Please Make Sure You Filled Out All The Fields";
                }
                return null;
              },
              obscureText: !_showRenewPassword,
              decoration: InputDecoration(
                labelText: 'Re-enter New Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: _showRenewPassword ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() => _showRenewPassword = !_showRenewPassword);
                  },
                ),
              ),
            ),
            const Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Wrap(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: (){
                        if (_changePassKey.currentState.validate() == true){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing')));
                        }
                      },

                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        if (_changePassKey.currentState.validate() == true){
                          getData(context,widget.firstName, widget.lastName, "Test124", "Test124");
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successful')));
                        }
                      },

                      child: const Text('Submit'),
                    ),
                  ]),),
          ],
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        backgroundColor: Colors.lightBlue, //background color of app bar
      ),
      body: _buildCurrentPasswordTextFormField(),);
  }
}