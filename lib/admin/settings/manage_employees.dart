import 'package:flutter/material.dart';
import '../admin_dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test App",
      home: ManageEmployees(),
    );
  }
}

class ManageEmployees extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String companyID;
  final String designation;
  final String department;
  final String photo;
  String date;
  ManageEmployees(
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
    return _ManageEmployees();
  }
}

class _ManageEmployees extends State<ManageEmployees> {
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
  Contact(fullName: 'Keyan de Klerk'),
  Contact(fullName: 'Conan Campbell')
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

  ContactList(this._contacts);
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
      leading: CircleAvatar(child: Text(contact.fullName[0])),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_call,
              size: 20.0,
              color: Colors.brown[900],
            ),
            onPressed: () {
              //   _onDeleteItemPressed(index);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.account_box_sharp,
              size: 20.0,
              color: Colors.brown[900],
            ),
            onPressed: () {
              //   _onDeleteItemPressed(index);
            },
          ),
        ],
      ),

  );
}

class Contact {
  final String fullName;

  const Contact({this.fullName});
}
