import 'package:flutter/material.dart';

import 'admin_dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test App",
      home: GroupVisit(),
    );
  }
}

class GroupVisit extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String companyID;
  final String designation;
  final String department;
  final String photo;
  String date;
  GroupVisit(
      {Key key,
      this.firstName,
      this.lastName,
      this.email,
      this.mobileNumber,
      this.companyID,
      this.designation,
      this.department,
      this.photo,
      this.date})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _GroupVisit();
  }
}

class _GroupVisit extends State<GroupVisit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
          title: const Text("Group"),
        ),
        body: new ContactList(kContacts));
  }
}

const kContacts = <Contact>[
  Contact(fullName: 'Keyan de Klerk', timeIn: '00:00', timeOut: "00:00"),
  Contact(fullName: 'Conan Campbell', timeIn: '00:00', timeOut: "00:00")
];

List<DropdownMenuItem<String>> get dropdownAdmin {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: Text("Admin"), value: "Admin"),
    const DropdownMenuItem(child: Text("QR Code"), value: "QR"),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get dropdownDay {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: Text("Today"), value: "Today"),
    const DropdownMenuItem(child: Text("Yesterday"), value: "Yesterday"),
  ];
  return menuItems;
}

class ContactList extends StatelessWidget {
  final List<Contact> _contacts;

  ContactList(this._contacts, {Key key}) : super(key: key);
  String selectedValueAdmin = "Admin";
  String selectedValueDay = "Today";
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 100,
            child: Column(children: <Widget>[
              DropdownButton(value: selectedValueAdmin, items: dropdownAdmin),
              DropdownButton(value: selectedValueDay, items: dropdownDay),
            ]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              itemBuilder: (context, index) {
                return _ContactListItem(_contacts[index]);
              },
              itemCount: _contacts.length,
            ),
          ),
        ]);
  }
}

class _ContactListItem extends ListTile {
  _ContactListItem(Contact contact)
      : super(
            title: Text(contact.fullName),
            subtitle: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(contact.timeIn),
                SizedBox(width: 50),
                Text(contact.timeOut),
              ],
            ),
            leading: CircleAvatar(child: Text(contact.fullName[0])));
}

class Contact {
  final String fullName;
  final String timeIn;
  final String timeOut;

  const Contact({this.fullName, this.timeIn, this.timeOut});
}
