import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_and_attendance/admin/provider/past_visits.dart';
import 'package:intl/intl.dart';
import 'admin_dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test App",
      home: PunchedVisit(),
    );
  }
}

class PunchedVisit extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String companyID;
  final String designation;
  final String department;
  final String photo;
  String date;
  PunchedVisit(
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
    return _PunchedVisit();
  }
}

class _PunchedVisit extends State<PunchedVisit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Choice Box"),
                          Checkbox(
                              value: isChecked,
                              onChanged: (checked) {
                                setState(() {
                                  isChecked = checked;
                                });
                              })
                        ],
                      )
                    ],
                  )),
              title: Text('Stateful Dialog'),
              actions: <Widget>[
                InkWell(
                  child: Text('OK   '),
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  TextEditingController dateinput = TextEditingController();
  //text editing controller for text field

  @override
  void initState() {
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
        title: const Text("Punched Visits"),
        backgroundColor: Colors.lightBlue,
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
        ), //background color of app bar
      ),
      body: Column(children: <Widget>[
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
        Column(children: <Widget>[
          Center(
              child: TextField(
            controller: dateinput, //editing controller of this TextField
            decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today), //icon of text field
                labelText: "Enter Date" //label text of field
                ),
            readOnly:
                true, //set it true, so that user will not able to edit text
            onTap: () async {
              DateTime pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.parse(widget.date),
                  firstDate: DateTime(
                      2000), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101));

              if (pickedDate != null) {
                print(
                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                print(
                    formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                setState(() {
                  dateinput.text = formattedDate;

                  //set output date to TextField value.
                });
                print(dateinput.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PunchedVisit(
                        firstName: widget.firstName,
                        lastName: widget.lastName,
                        email: widget.email,
                        mobileNumber: widget.mobileNumber,
                        companyID: "1",
                        designation: widget.designation,
                        department: widget.department,
                        photo: widget.photo,
                        date: dateinput.text),
                  ),
                );
              } else {
                print("Date is not selected");
              }
            },
          )),
        ]),
        ChangeNotifierProvider<PunchedVisitsProvider>(
          create: (context) => PunchedVisitsProvider(),
          child: Consumer<PunchedVisitsProvider>(
            builder: (context, provider, child) {
              if (provider.data == null) {
                provider.getData(context, "1", dateinput.text);
                return const Center(child: CircularProgressIndicator());
              }
              // when we have the json loaded... let's put the data into a data table widget
              return Expanded(
                // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 10,
                    columns: const [
                      DataColumn(
                          label: Text('First Name'),
                          tooltip: 'Represents first name of the user.'),
                      DataColumn(
                          label: Text('Time In Image'),
                          tooltip: 'Represents time in of the user.'),
                      DataColumn(
                          label: Text('Time In'),
                          tooltip: 'Represents first name of the user.'),
                      DataColumn(
                          label: Text('Time Out Image'),
                          tooltip: 'Represents time in of the user.'),
                      DataColumn(
                          label: Text('Time Out'),
                          tooltip: 'Represents first name of the user.'),
                      DataColumn(
                          label: Text('Client'),
                          tooltip: 'Represents time in of the user.'),
                    ],
                    rows: provider.data.visits
                        .map((data) =>
                            // we return a DataRow every time
                            DataRow(
                                // List<DataCell> cells is required in every row
                                cells: [
                                  DataCell(Text(data.name)),
                                  DataCell(CircleAvatar(
                                    radius: 80.0,
                                    backgroundImage: NetworkImage(
                                        "https://www.zentrack.co.za/timeIn_images/" +
                                            data.timeInImage),
                                    backgroundColor: Colors.grey,
                                  )),
                                  DataCell(Text(data.timeIn)),
                                  DataCell(CircleAvatar(
                                    radius: 80.0,
                                    backgroundImage: NetworkImage(
                                        "https://www.zentrack.co.za/timeIn_images/" +
                                            data.timeOutImage),
                                    backgroundColor: Colors.grey,
                                  )),
                                  DataCell(Text(data.timeOut)),
                                  DataCell(Text(data.client)),
                                ]))
                        .toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
