import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:time_and_attendance/admin/provider/get_shifts.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test App",
      home: ManageShift(),
    );
  }
}

class ManageShift extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String companyName;
  final String designation;
  final String department;
  final String photo;
  String date;
  ManageShift(
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
    return _ManageShift();
  }
}

class _ManageShift extends State<ManageShift> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController timeControllerStart = TextEditingController();
  TextEditingController timeControllerEnd = TextEditingController();
  final TextEditingController _textEditingController = TextEditingController();
  Future insertHoliday(context, String shiftName, String startingTime, String endingTime, int status, String companyID) async {
    // set up POST request arguments
    final url =
    Uri.parse('https://www.zentrack.co.za/API/insert_Shift.php');
    final headers = {"Content-type": "application/json"};
    var json = '{"ShiftName": "'+ shiftName +'","StartingTime": "'+ startingTime +'","EndingTime": "'+ endingTime +'","Status": "'+ status.toString() +'","CompanyID": "'+ companyID +'"}';
    print(json);
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
                            hintText: "Please Enter Shift Name"),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 400,
                            child: TextField(
                              readOnly: true,
                              controller: timeControllerStart,
                              decoration: const InputDecoration(
                                  icon: Icon(Icons
                                      .alarm),
                                  hintText: 'Pick your Starting Time'
                              ),
                              onTap: () async {
                                var time =  await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: context,);
                                timeControllerStart.text = time.format(context);
                              },)
                          ),
                          SizedBox(width: 400,
                              child: TextField(
                                readOnly: true,
                                controller: timeControllerEnd,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons
                                        .alarm),
                                    hintText: 'Pick your Ending Time'
                                ),
                                onTap: () async {
                                  var time =  await showTimePicker(
                                    initialTime: TimeOfDay.now(),
                                    context: context,);
                                  timeControllerEnd.text = time.format(context);
                                },)
                          ),
                        ],
                      )
                    ],
                  )),
              title: const Text('Add Shifts'),
              actions: <Widget>[
                InkWell(
                  child: const Text('OK   '),
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      insertHoliday(context,_textEditingController.text, timeControllerStart.text,timeControllerEnd.text, 1, "1");
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
        title: const Text("Manage Shifts"),
        backgroundColor: Colors.lightBlue, //background color of app bar
      ),
      body: Column(children: <Widget>[
        ElevatedButton(
          onPressed: ()async {
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
        ChangeNotifierProvider<GetShiftsProvider>(
          create: (context) => GetShiftsProvider(),
          child: Consumer<GetShiftsProvider>(
            builder: (context, provider, child) {
              if (provider.data == null) {
                provider.getData(context, "1");
                return const Center(child: CircularProgressIndicator());
              }
              // when we have the json loaded... let's put the data into a data table widget
              return Expanded(
                // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..
                  child: Align(
                      alignment: Alignment.topCenter,
                      child:
                    SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columnSpacing: 10,
                    columns: const [
                      DataColumn(
                          label: Text('First Name'),
                          tooltip: 'Represents first name of the user.'),
                      DataColumn(
                          label: Text('Time In'),
                          tooltip: 'Represents time in of the user.'),
                      DataColumn(
                          label: Text('Time Out'),
                          tooltip: 'Represents time in of the user.'),
                      DataColumn(
                          label: Text('Status'),
                          tooltip: 'Represents time out of the user.'),
                    ],
                    rows: provider.data.shifts
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
                              child: Text(data.timeIn))),
                          DataCell(SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25, //SET width
                              child: Text(data.timeOut))),
                          DataCell(SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25, //SET width
                              child: Text(data.status))),
                        ]))
                        .toList(),
                  ),
                ),
              ));
            },
          ),
        ),
      ]),);
  }
}

