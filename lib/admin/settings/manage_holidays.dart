import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:time_and_attendance/admin/provider/get_holidays.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test App",
      home: ManageHolidays(),
    );
  }
}

class ManageHolidays extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String companyName;
  final String designation;
  final String department;
  final String photo;
  String date;
  ManageHolidays(
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
    return _ManageHolidays();
  }
}

class _ManageHolidays extends State<ManageHolidays> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController dateinputTo = TextEditingController();
  TextEditingController dateinputFrom = TextEditingController();
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingController1 = TextEditingController();
  Future insertHoliday(context, String holidayName, String startingDate, String endingDate, String remark, String companyID) async {
    // set up POST request arguments
    final url =
    Uri.parse('https://www.zentrack.co.za/API/insert_Holiday.php');
    final headers = {"Content-type": "application/json"};
    var json = '{"HolidayName": "'+ holidayName +'","StartingDate": "'+ startingDate +'","EndingDate": "'+ endingDate +'","Remark": "'+ remark +'","CompanyID": "'+ companyID +'"}';

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
                        decoration: const InputDecoration(
                            hintText: "Please Enter Holiday Name"),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 400,
                            child: TextField(
                              controller:
                                  dateinputFrom, //editing controller of this TextField
                              decoration: const InputDecoration(
                                  icon: Icon(Icons
                                      .calendar_today), //icon of text field
                                  labelText:
                                      "Enter Date From" //label text of field
                                  ),
                              readOnly:
                                  true, //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now())),
                                    firstDate: DateTime(
                                        2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  //you can implement different kind of Date Format here according to your requirement

                                  setState(() {
                                    dateinputFrom.text = formattedDate;

                                    //set output date to TextField value.
                                  });
                                  print(dateinputFrom.text);
                                } else {
                                  print("Date is not selected");
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 400,
                            child: TextField(
                              controller:
                                  dateinputTo, //editing controller of this TextField
                              decoration: const InputDecoration(
                                  icon: Icon(Icons
                                      .calendar_today), //icon of text field
                                  labelText:
                                      "Enter Date To" //label text of field
                                  ),
                              readOnly:
                                  true, //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now())),
                                    firstDate: DateTime(
                                        2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  //you can implement different kind of Date Format here according to your requirement

                                  setState(() {
                                    dateinputTo.text = formattedDate;

                                    //set output date to TextField value.
                                  });
                                  print(dateinputTo.text);
                                } else {
                                  print("Date is not selected");
                                }
                              },
                            ),
                          ),
                          TextFormField(
                            controller: _textEditingController1,
                            validator: (value) {
                              return value.isNotEmpty ? null : "Enter any text";
                            },
                            decoration: const InputDecoration(
                                hintText: "Please Enter a Remark"),
                          ),
                        ],
                      )
                    ],
                  )),
              title: const Text('Add Holiday'),
              actions: <Widget>[
                InkWell(
                  child: const Text('OK   '),
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      insertHoliday(context,_textEditingController.text, dateinputFrom.text,dateinputTo.text, _textEditingController1.text, "1");
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
        title: const Text("Manage Holidays"),
        backgroundColor: Colors.lightBlue, //background color of app bar
      ),
      body: Column(children: <Widget>[
        ElevatedButton(
          onPressed: () async {
            await showInformationDialog(context);
          },
          child: const Icon(Icons.add, color: Colors.white),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            primary: Colors.blue, // <-- Button color
            onPrimary: Colors.red, // <-- Splash color
          ),
        ),
        ChangeNotifierProvider<GetHolidaysProvider>(
          create: (context) => GetHolidaysProvider(),
          child: Consumer<GetHolidaysProvider>(
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
                          label: Text('From Date'),
                          tooltip: 'Represents time in of the user.'),
                      DataColumn(
                          label: Text('To Date'),
                          tooltip: 'Represents time in of the user.'),
                      DataColumn(
                          label: Text('Total Days'),
                          tooltip: 'Represents time out of the user.'),
                    ],
                    rows: provider.data.holidays
                        .map((data) =>
                            // we return a DataRow every time
                            DataRow(
                                // List<DataCell> cells is required in every row
                                cells: [
                                  DataCell(SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25, //SET width
                        child: Text(data.name))),
                                  DataCell(SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.25, //SET width
                                      child: Text(data.fromDate))),
                                  DataCell(SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.25, //SET width
                                      child: Text(data.toDate))),
                                  DataCell(SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.25, //SET width
                                      child: Text(data.totalDays))),
                                ]))
                        .toList(),
                  ),
                ),
                )
              );
            },
          ),
        ),
      ]),
    );
  }
}
