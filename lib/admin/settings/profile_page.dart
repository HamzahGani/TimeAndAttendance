import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test App",
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String companyName;
  final String designation;
  final String department;
  final String photo;
  String date;
  ProfilePage(
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
    return _ProfilePage();
  }
}

class _ProfilePage extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile Page"),
          backgroundColor: Colors.lightBlue, //background color of app bar
        ),
        body: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  SizedBox(
                      height: 100,
                      child: CircleAvatar(
                        radius: 80.0,
                        backgroundImage: NetworkImage(
                            "https://www.zentrack.co.za/profileImages/" +
                                widget.photo),
                        backgroundColor: Colors.grey,
                      )),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(widget.firstName + ' ' + widget.lastName,
                      style: const TextStyle(fontSize: 24)),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Material(
                      child: Container (
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                              child: Column(
                                  children : [
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: widget.email,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25.0),
                                          borderSide: const BorderSide(
                                          ),
                                        ),
                                        //fillColor: Colors.green
                                      ),
                                      validator: (val) {
                                        if(val.isEmpty) {
                                          return "Email cannot be empty";
                                        }else{
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      style: const TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ]
                              )
                          )
                      )
                  ),
                  Material(
                      child: Container (
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                              child: Column(
                                  children : [
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: widget.department,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25.0),
                                          borderSide: const BorderSide(
                                          ),
                                        ),
                                        //fillColor: Colors.green
                                      ),
                                      validator: (val) {
                                        if(val.isEmpty) {
                                          return "Email cannot be empty";
                                        }else{
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      style: const TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ]
                              )
                          )
                      )
                  ),
                  Material(
                      child: Container (
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                              child: Column(
                                  children : [
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: widget.designation,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25.0),
                                          borderSide: const BorderSide(
                                          ),
                                        ),
                                        //fillColor: Colors.green
                                      ),
                                      validator: (val) {
                                        if(val.isEmpty) {
                                          return "Email cannot be empty";
                                        }else{
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      style: const TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ]
                              )
                          )
                      )
                  ),
                  Material(
                      child: Container (
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                              child: Column(
                                  children : [
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: widget.mobileNumber,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25.0),
                                          borderSide: const BorderSide(
                                          ),
                                        ),
                                        //fillColor: Colors.green
                                      ),
                                      validator: (val) {
                                        if(val.isEmpty) {
                                          return "Email cannot be empty";
                                        }else{
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      style: const TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ]
                              )
                          )
                      )
                  ),
                  Material(
                      child: Container (
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                              child: Column(
                                  children : [
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: widget.companyName,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25.0),
                                          borderSide: const BorderSide(
                                          ),
                                        ),
                                        //fillColor: Colors.green
                                      ),
                                      validator: (val) {
                                        if(val.isEmpty) {
                                          return "Email cannot be empty";
                                        }else{
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      style: const TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ]
                              )
                          )
                      )
                  ),
                ],
              ),
            ),
          ],
        ),);
  }
}

