import 'dart:html';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('zentyl'),
          backgroundColor: Colors.greenAccent,
        ),
      ),
    );
  }
}




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(''),
            )
          ],
        )
      ),
    );
  }
}

class Name extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Name: ',
        prefixIcon: const Icon(Icons.account_circle_outlined)
      ),
    );
  }
}

class Designation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 3,
      decoration: InputDecoration(
          labelText: 'Designation: ',
          prefixIcon: const Icon(Icons.work)
      ),
    );
  }
}

class Department extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 3,
      decoration: InputDecoration(
          labelText: 'Department: ',
          prefixIcon: const Icon(Icons.account_balance)
      ),
    );
  }
}

class Shift extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 3,
      decoration: InputDecoration(
          labelText: 'Shift: ',
          prefixIcon: const Icon(Icons.timelapse)
      ),
    );
  }
}

class ShiftTimings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 3,
      decoration: InputDecoration(
          labelText: 'Shift Timings: ',
          prefixIcon: const Icon(Icons.access_alarms)
      ),
    );
  }
}

class PhoneNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        icon: const Icon(Icons.phone),
            labelText: 'Phone',
            hintText: '+27',
            errorText: /*_phoneInputIsValid(phone number from form)*/ /*? null :*/ 'Please enter the correct type of '
        'phone number',
            border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      ),
    );
  }
}

final _kButtonNavBarItems = <BottomNavigationBarItem>[
const BottomNavigationBarItem(icon: Icon(Icons.house), label: 'Home'),
const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
const BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Log'),
const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
];



