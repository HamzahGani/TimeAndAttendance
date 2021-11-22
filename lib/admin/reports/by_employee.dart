import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_and_attendance/admin/provider/by_employee.dart';
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
      home: ByEmployee(),
    );
  }
}

class ByEmployee extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String companyName;
  final String designation;
  final String department;
  final String photo;
  String date;
  ByEmployee(
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
    return _ByEmployee();
  }
}

class _ByEmployee extends State<ByEmployee> {
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
          title: Text("By Employee"),
          backgroundColor: Colors.lightBlue, //background color of app bar
        ),
        body: Column(children: <Widget>[
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
                        builder: (context) => ByEmployee(
                            firstName: widget.firstName,
                            lastName: widget.lastName,
                            email: widget.email,
                            mobileNumber: widget.mobileNumber,
                            companyName: widget.companyName,
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
          ChangeNotifierProvider<ByEmployeeProvider>(
            create: (context) => ByEmployeeProvider(),
            child: Consumer<ByEmployeeProvider>(
              builder: (context, provider, child) {
                if (provider.data == null) {
                  provider.getData(context, "1", "24");
                  return const Center(child: CircularProgressIndicator());
                }
                // when we have the json loaded... let's put the data into a data table widget
                return Expanded(
                  // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columnSpacing: 10,
                      columns: const [
                        DataColumn(
                            label: Text('Date'),
                            tooltip: 'Represents first name of the user.'),
                        DataColumn(
                            label: Text('Time In Image'),
                            tooltip: 'Represents time in of the user.'),
                        DataColumn(
                            label: Text('Time In'),
                            tooltip: 'Represents time in of the user.'),
                        DataColumn(
                            label: Text('Time Out Image'),
                            tooltip: 'Represents time in of the user.'),
                        DataColumn(
                            label: Text('Time Out'),
                            tooltip: 'Represents time in of the user.'),
                        DataColumn(
                            label: Text('Status'),
                            tooltip: 'Represents time out of the user.'),
                      ],
                      rows: provider.data.employee
                          .map((data) =>
                      // we return a DataRow every time
                      DataRow(
                        // List<DataCell> cells is required in every row
                          cells: [
                            DataCell(SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2, //SET width
                                child: Text(data.date))),
                            DataCell(SizedBox(
                                width: MediaQuery.of(context).size.width * 0.15, //SET width
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage: NetworkImage(
                                      "https://www.zentrack.co.za/timeIn_images/" +
                                          data.timeInImage),
                                  backgroundColor: Colors.white,
                                ))),
                            DataCell(SizedBox(
                                width: MediaQuery.of(context).size.width * 0.15, //SET width
                                child: Text(data.timeIn))),
                            DataCell(SizedBox(
                                width: MediaQuery.of(context).size.width * 0.15, //SET width
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage: NetworkImage(
                                      "https://www.zentrack.co.za/timeIn_images/" +
                                          data.timeOutImage),
                                  backgroundColor: Colors.white,
                                ))),
                            DataCell(SizedBox(
                                width: MediaQuery.of(context).size.width * 0.15, //SET width
                                child: Text(data.timeOut))),
                            DataCell(SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.15, //SET width
                                child: Text(data.status))),
                          ]))
                          .toList(),
                    ),
                  ),
                ),
                );
              },
            ),
          ),
        ]));
  }
}
