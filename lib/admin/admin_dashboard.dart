import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:time_and_attendance/admin/add_employee.dart';
import 'package:time_and_attendance/admin/reports/by_designation.dart';
import 'package:time_and_attendance/admin/reports/by_employee.dart';
import 'package:time_and_attendance/admin/reports/daily_attendance.dart';
import 'package:time_and_attendance/admin/reports/early_leavers.dart';
import 'package:time_and_attendance/admin/reports/late_comers.dart';
import 'package:time_and_attendance/admin/reports/outside_geo_fence.dart';
import 'package:time_and_attendance/admin/reports/periodic_attendance.dart';
import 'package:time_and_attendance/admin/reports/punched_visits.dart';
import 'package:time_and_attendance/admin/reports/time_off.dart';
import 'package:time_and_attendance/admin/settings/change_password.dart';
import 'package:time_and_attendance/admin/settings/manage_departments.dart';
import 'package:time_and_attendance/admin/settings/manage_designations.dart';
import 'package:time_and_attendance/admin/settings/manage_employees.dart';
import 'package:time_and_attendance/admin/settings/manage_holidays.dart';
import 'package:time_and_attendance/admin/settings/manage_shifts.dart';
import 'package:time_and_attendance/admin/settings/profile_page.dart';
import 'package:time_and_attendance/admin/visits.dart';
import 'package:time_and_attendance/login_page.dart';
import 'package:geocoder/geocoder.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_and_attendance/admin/reports/by_department.dart';
import 'group.dart';
import 'liveTrackigUtils/choose_device.dart';
import 'package:intl/intl.dart';


class AdminDashboard extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String companyName;
  final String designation;
  final String department;
  final String photo;
  final bool timedIn;

  const AdminDashboard(
      {Key key,
      this.firstName,
      this.lastName,
      this.email,
      this.mobileNumber,
      this.companyName,
      this.designation,
      this.department,
      this.photo,
      this.timedIn})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    var drawerHeader = UserAccountsDrawerHeader(
        accountName: Text(widget.firstName + ' ' + widget.lastName),
        accountEmail: Text(widget.email),
        currentAccountPicture: CircleAvatar(
          radius: 80.0,
          backgroundImage: NetworkImage(
              "https://www.zentrack.co.za/profileImages/" + widget.photo),
          backgroundColor: Colors.white,
        ));
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          leading: const Icon(Icons.house),
          title: const Text('Home'),
          onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => AdminDashboard(
                      firstName: widget.firstName,
                      lastName: widget.lastName,
                      email: widget.email,
                      mobileNumber: widget.mobileNumber,
                      companyName: widget.companyName,
                      designation: widget.designation,
                      department: widget.department,
                      photo: widget.photo,
                    )),
            (Route<dynamic> route) => false,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.add),
          title: const Text('Show Locations'),
          onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ChooseDevice()),
            (Route<dynamic> route) => false,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Logout'),
          onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false,
          ),
        ),
      ],
    );
    Future timeIn(context, String firstName, String city, String lastName, bool timedIn) async {
      // set up POST request arguments
      final url =
      Uri.parse('https://www.zentrack.co.za/API/time_in_app.php');
      final headers = {"Content-type": "application/json"};
      var json = '{"FirstName": "'+ firstName +'","City": "'+ city +'","TimedIn": "'+ timedIn.toString() +'", "LastName": "'+ lastName +'"}';

      // make POST request
      final response = await post(url, headers: headers, body: json);
      print(response.body);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AdminDashboard(firstName: widget.firstName,lastName: widget.lastName,email: widget.email, mobileNumber: widget.mobileNumber, designation: widget.designation, department: widget.department, companyName: widget.companyName, photo: widget.photo,timedIn: true,)),
            (Route<dynamic> route) => false,
      );
    }
    Future timeOut(context, String firstName, String city, String lastName, bool timedOut) async {
      // set up POST request arguments
      final url =
      Uri.parse('https://www.zentrack.co.za/API/time_out_app.php');
      final headers = {"Content-type": "application/json"};
      var json = '{"FirstName": "'+ firstName +'","City": "'+ city +'","TimedOut": "'+ timedOut.toString() +'", "LastName": "'+ lastName +'"}';

      // make POST request
      final response = await post(url, headers: headers, body: json);
      print(response.body);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AdminDashboard(firstName: widget.firstName,lastName: widget.lastName,email: widget.email, mobileNumber: widget.mobileNumber, designation: widget.designation, department: widget.department, companyName: widget.companyName, photo: widget.photo,timedIn: false,)),
            (Route<dynamic> route) => false,
      );
    }
    final listReports = <Widget>[
      ListTile(
        leading: const Icon(
          Icons.calendar_today,
          size: 45,
        ),
        title: const Text('Daily Attendance'),
        subtitle: const Text('Get Daily Attendance'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DailyAttendance(
                firstName: widget.firstName,
                lastName: widget.lastName,
                email: widget.email,
                mobileNumber: widget.mobileNumber,
                companyName: widget.companyName,
                designation: widget.designation,
                department: widget.department,
                photo: widget.photo,
                date: DateFormat("yyyy-MM-dd")
                    .format(DateTime.now()),
              ),
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(
          Icons.alarm,
          size: 45,
        ),
        title: const Text('Late Comers'),
        subtitle: const Text('Get Late Comers List'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LateComer(
                firstName: widget.firstName,
                lastName: widget.lastName,
                email: widget.email,
                mobileNumber: widget.mobileNumber,
                companyName: widget.companyName,
                designation: widget.designation,
                department: widget.department,
                photo: widget.photo,
              ),
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(
          Icons.exit_to_app,
          size: 45,
        ),
        title: const Text('Early Leavers'),
        subtitle: const Text('Get Early Leavers List'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EarlyLeaver(
                firstName: widget.firstName,
                lastName: widget.lastName,
                email: widget.email,
                mobileNumber: widget.mobileNumber,
                companyName: widget.companyName,
                designation: widget.designation,
                department: widget.department,
                photo: widget.photo,
              ),
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(
          Icons.add_business,
          size: 45,
        ),
        title: const Text('By Department'),
        subtitle: const Text('Attendance By Department'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ByDepartment(),
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(
          Icons.airplanemode_active,
          size: 45,
        ),
        title: const Text('By Designation'),
        subtitle: const Text('Attendance By Designation'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ByDesignation(
                firstName: widget.firstName,
                lastName: widget.lastName,
                email: widget.email,
                mobileNumber: widget.mobileNumber,
                companyName: widget.companyName,
                designation: widget.designation,
                department: widget.department,
                photo: widget.photo,
              ),
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(
          Icons.person,
          size: 45,
        ),
        title: const Text('By Employee'),
        subtitle: const Text('Attendance By Employee'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
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
              ),
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(
          Icons.alarm_off,
          size: 45,
        ),
        title: const Text('Time Off'),
        subtitle: const Text('Get Employees Time Off List'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TimeOff(
                firstName: widget.firstName,
                lastName: widget.lastName,
                email: widget.email,
                mobileNumber: widget.mobileNumber,
                companyName: widget.companyName,
                designation: widget.designation,
                department: widget.department,
                photo: widget.photo,
              ),
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(
          Icons.card_travel,
          size: 45,
        ),
        title: const Text('Punched Visits'),
        subtitle: const Text('List Of Punched Visits'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PunchedVisits(
                firstName: widget.firstName,
                lastName: widget.lastName,
                email: widget.email,
                mobileNumber: widget.mobileNumber,
                companyName: widget.companyName,
                designation: widget.designation,
                department: widget.department,
                photo: widget.photo,
              ),
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(
          Icons.pin_drop,
          size: 45,
        ),
        title: const Text('Outside Geo Fence'),
        subtitle: const Text('Outside the Geo Fence'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OutsideGeofence(
                firstName: widget.firstName,
                lastName: widget.lastName,
                email: widget.email,
                mobileNumber: widget.mobileNumber,
                companyName: widget.companyName,
                designation: widget.designation,
                department: widget.department,
                photo: widget.photo,
              ),
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(
          Icons.calendar_today,
          size: 45,
        ),
        title: const Text('Periodic Attendance'),
        subtitle: const Text('Get Attendance Of Specific Days'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PeriodicAttendance(
                firstName: widget.firstName,
                lastName: widget.lastName,
                email: widget.email,
                mobileNumber: widget.mobileNumber,
                companyName: widget.companyName,
                designation: widget.designation,
                department: widget.department,
                photo: widget.photo,
              ),
            ),
          );
        },
      ),
    ];
    final listSettings = <Widget>[
      ListTile(
        leading: const Icon(
          Icons.person,
          size: 45,
        ),
        title: const Text('Employees'),
        subtitle: const Text('Manage Employees'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ManageEmployees(firstName: widget.firstName,
                lastName: widget.lastName,
                email: widget.email,
                mobileNumber: widget.mobileNumber,
                companyID: "1",
                designation: widget.designation,
                department: widget.department,
                photo: widget.photo,),
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(
          Icons.picture_as_pdf,
          size: 45,
        ),
        title: const Text('Shifts'),
        subtitle: const Text('Manage Shifts'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ManageShift(firstName: widget.firstName,
                lastName: widget.lastName,
                email: widget.email,
                mobileNumber: widget.mobileNumber,
                companyName: widget.companyName,
                designation: widget.designation,
                department: widget.department,
                photo: widget.photo,),
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(
          Icons.account_tree,
          size: 45,
        ),
        title: const Text('Departments'),
        subtitle: const Text('Manage Departments'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ManageDepartments(firstName: widget.firstName,
                lastName: widget.lastName,
                email: widget.email,
                mobileNumber: widget.mobileNumber,
                companyName: widget.companyName,
                designation: widget.designation,
                department: widget.department,
                photo: widget.photo,),
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(
          Icons.add_business,
          size: 45,
        ),
        title: const Text('Designations'),
        subtitle: const Text('Manage Designations'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ManageDesignations(firstName: widget.firstName,
                lastName: widget.lastName,
                email: widget.email,
                mobileNumber: widget.mobileNumber,
                companyName: widget.companyName,
                designation: widget.designation,
                department: widget.department,
                photo: widget.photo,),
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(
          Icons.airplanemode_active,
          size: 45,
        ),
        title: const Text('Holidays'),
        subtitle: const Text('Manage Holidays'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ManageHolidays(firstName: widget.firstName,
                lastName: widget.lastName,
                email: widget.email,
                mobileNumber: widget.mobileNumber,
                companyName: widget.companyName,
                designation: widget.designation,
                department: widget.department,
                photo: widget.photo,),
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(
          Icons.face,
          size: 45,
        ),
        title: const Text('Profile'),
        subtitle: const Text('Manage Your Profile'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(
                firstName: widget.firstName,
                lastName: widget.lastName,
                email: widget.email,
                mobileNumber: widget.mobileNumber,
                companyName: widget.companyName,
                designation: widget.designation,
                department: widget.department,
                photo: widget.photo,
              ),
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(
          Icons.lock,
          size: 45,
        ),
        title: const Text('Password'),
        subtitle: const Text('Change Your Password'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangePassword(firstName: widget.firstName,
                lastName: widget.lastName,
                email: widget.email,
                mobileNumber: widget.mobileNumber,
                companyName: widget.companyName,
                designation: widget.designation,
                department: widget.department,
                photo: widget.photo,),
            ),
          );
        },
      ),
    ];
    final _kTabPages = <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.infinity),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                      height: 100,
                      child: CircleAvatar(
                        radius: 50.0,
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
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 40, //height of button
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.lightBlue;
                                }
                                return Colors
                                    .blue; // Use the component's default.
                              },
                            ),
                          ),
                          // ignore: invalid_use_of_protected_member
                          onPressed: () {
                            widget.timedIn == false ? timeIn(context, widget.firstName, "city", widget.lastName, widget.timedIn) : timeOut(context, widget.firstName, "city", widget.lastName, widget.timedIn);
                          },
                          child: Text(widget.timedIn == false ? "Time In" : "Time Out",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20)),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      border: Border.all(
                        width: 1,
                      ),
                    ),
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Text(
                            "You are at: " +
                                _locationMessage +
                                "\n (Accurate up to " +
                                _accuracy.toString() +
                                "m)",
                            textAlign: TextAlign.center,
                            style:
                                const TextStyle(color: Colors.black, fontSize: 16)),
                        InkWell(
                          child: const Align(
                            alignment: Alignment.bottomCenter,
                            child: Text("Refresh Location",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 14)),
                          ),
                          onTap: () {
                            getCurrentLocation();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminDashboard(
                                        firstName: widget.firstName,
                                        lastName: widget.lastName,
                                        email: widget.email,
                                        mobileNumber: widget.mobileNumber,
                                        companyName: widget.companyName,
                                        designation: widget.designation,
                                        department: widget.department,
                                        photo: widget.photo,
                                      )),
                              (Route<dynamic> route) => false,
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: MaterialButton(
                            color: Colors.blue,
                            shape: const CircleBorder(),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddEmployee(
                                          firstName: widget.firstName,
                                          lastName: widget.lastName,
                                          email: widget.email,
                                          mobileNumber: widget.mobileNumber,
                                          companyID: "1",
                                          designation: widget.designation,
                                          department: widget.department,
                                          photo: widget.photo,
                                        )),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(15),
                              child: Icon(Icons.plus_one),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.blue),
                    left: BorderSide(color: Colors.blue),
                    bottom: BorderSide(color: Colors.blue),
                  ),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.45,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(Icons.group_add_rounded,
                          size: 40.0, color: Colors.blue),
                      InkWell(
                        child: const Text("Group"),
                        onTap:() {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GroupVisit(
                                  firstName: widget.firstName,
                                  lastName: widget.lastName,
                                  email: widget.email,
                                  mobileNumber: widget.mobileNumber,
                                  companyID: "1",
                                  designation: widget.designation,
                                  department: widget.department,
                                  photo: widget.photo,
                                )),
                                (Route<dynamic> route) => false,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.blue),
                    bottom: BorderSide(color: Colors.blue),
                  ),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.blue),
                    bottom: BorderSide(color: Colors.blue),
                    right: BorderSide(color: Colors.blue),
                  ),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.45,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(Icons.directions_walk_rounded,
                          size: 40.0, color: Colors.blue),
                      InkWell(
                        child: const Text("Visits"),
                        onTap:() {
                          Navigator.pushAndRemoveUntil(
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
                                )),
                                (Route<dynamic> route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              width: double.infinity,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Text("Reports",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                            fontSize: 24))
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.9,
              width: double.infinity,
              child: Align(
                alignment: Alignment.center,
                child: ListView(children: listReports),
              ),
            ),
          ),
        ],
      ),
      Center(
        child: TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              width: double.infinity,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Text("Settings",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                            fontSize: 24))
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.9,
              width: double.infinity,
              child: Align(
                alignment: Alignment.center,
                child: ListView(children: listSettings),
              ),
            ),
          ),
        ],
      ),
    ];
    final _kButtonNavBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.house), label: 'Home'),
      const BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Reports'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today), label: 'Log'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.settings), label: 'Settings'),
    ];
    assert(_kTabPages.length == _kButtonNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      items: _kButtonNavBarItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
    );
    return Scaffold(
        body: _kTabPages[_currentTabIndex],
        bottomNavigationBar: bottomNavBar,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(widget.companyName + "'s Admin Dashboard"),
        ),
        endDrawer: Drawer(
          child: drawerItems,
        ));
  }
}

String _locationMessage = "";
var _accuracy;
void getCurrentLocation() async {
  final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  final coordinates = Coordinates(position.latitude, position.longitude);
  var addresses =
      await Geocoder.local.findAddressesFromCoordinates(coordinates);
  _locationMessage = addresses.first.addressLine;
  _accuracy = position.accuracy.toInt();
}
