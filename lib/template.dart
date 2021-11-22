import 'package:flutter/material.dart';
import 'package:time_and_attendance/admin/admin_dashboard.dart';
import 'package:time_and_attendance/admin/settings/change_password.dart';
import 'package:time_and_attendance/login_page.dart';

class TemplatePage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String companyName;
  final String designation;
  final String department;
  final String photo;
  const TemplatePage({Key key, this.firstName, this.lastName, this.email, this.mobileNumber, this.companyName, this.designation, this.department, this.photo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TemplatePageState();
}

class _TemplatePageState
    extends State<TemplatePage>{

  int _currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {

    var drawerHeader = UserAccountsDrawerHeader(
        accountName: Text(widget.firstName+ ' '+ widget.lastName),
        accountEmail: Text(widget.email),
        currentAccountPicture: CircleAvatar(
          radius: 80.0,
          backgroundImage:
          NetworkImage("https://www.zentrack.co.za/profileImages/"+ widget.photo),
          backgroundColor: Colors.white,
        )
    );
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          leading: Icon(Icons.house),
          title: const Text('Home'),
          onTap: () =>  Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AdminDashboard(firstName: widget.firstName,lastName: widget.lastName,email: widget.email, mobileNumber: widget.mobileNumber,companyName: widget.companyName, designation: widget.designation, department: widget.department,  photo: widget.photo,)),
                (Route<dynamic> route) => false,
          ),
        ),
        ListTile(
          leading: Icon(Icons.add),
          title: const Text('Extra Button'),
          onTap: () =>  Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AdminDashboard(firstName: widget.firstName,lastName: widget.lastName,email: widget.email, mobileNumber: widget.mobileNumber,companyName: widget.companyName, designation: widget.designation, department: widget.department,  photo: widget.photo,)),
                (Route<dynamic> route) => false,
          ),
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: const Text('Logout'),
          onTap: () =>  Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) => false,
          ),
        ),
      ],
    );

    final listReports = <Widget>[
      ListTile(
        leading: Icon(Icons.calendar_today, size: 45,),
        title: Text('Daily Attendance'),
        subtitle: Text('Get Daily Attendance'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => null,
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: Icon(Icons.alarm, size: 45,),
        title: Text('Late Comers'),
        subtitle: Text('Get Late Comers List'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => null,
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: Icon(Icons.exit_to_app, size: 45,),
        title: Text('Early Leavers'),
        subtitle: Text('Get Early Leavers List'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => null,
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: Icon(Icons.add_business, size: 45,),
        title: Text('By Department'),
        subtitle: Text('Attendance By Department'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => null,
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: Icon(Icons.airplanemode_active, size: 45,),
        title: Text('By Designation'),
        subtitle: Text('Attendance By Designation'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => null,
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: Icon(Icons.person, size: 45,),
        title: Text('By Employee'),
        subtitle: Text('Attendance By Employee'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => null,
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: Icon(Icons.alarm_off, size: 45,),
        title: Text('Time Off'),
        subtitle: Text('Get Employees Time Off List'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => null,
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: Icon(Icons.card_travel, size: 45,),
        title: Text('Punched Visits'),
        subtitle: Text('List Of Punched Visits'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => null,
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: Icon(Icons.pin_drop, size: 45,),
        title: Text('Outside Geo Fence'),
        subtitle: Text('Outside the Geo Fence'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => null,
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: Icon(Icons.calendar_today, size: 45,),
        title: Text('Periodic Attendance'),
        subtitle: Text('Get Attendance Of Specific Days'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => null,
            ),
          );
        },
      ),
    ];
    final listSettings = <Widget>[
      ListTile(
        leading: Icon(Icons.person, size: 45,),
        title: Text('Employees'),
        subtitle: Text('Manage Employees'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => null,
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: Icon(Icons.picture_as_pdf, size: 45,),
        title: Text('Shifts'),
        subtitle: Text('Manage Shifts'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => null,
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: Icon(Icons.account_tree, size: 45,),
        title: Text('Departments'),
        subtitle: Text('Manage Departments'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => null,
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: Icon(Icons.add_business, size: 45,),
        title: Text('Designations'),
        subtitle: Text('Manage Designations'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => null,
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: Icon(Icons.airplanemode_active, size: 45,),
        title: Text('Holidays'),
        subtitle: Text('Manage Holidays'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => null,
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: Icon(Icons.map, size: 45,),
        title: Text('Geo Fence'),
        subtitle: Text('Configure Geo Fence'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => null,
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: Icon(Icons.warning, size: 45,),
        title: Text('Notifications'),
        subtitle: Text('Manage Notifications'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => null,
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: Icon(Icons.face, size: 45,),
        title: Text('Profile'),
        subtitle: Text('Manage Your Profile'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TemplatePage(firstName: widget.firstName,lastName: widget.lastName,email: widget.email, mobileNumber: widget.mobileNumber,companyName: widget.companyName, designation: widget.designation, department: widget.department,  photo: widget.photo,),
            ),
          );
        },
      ),
      const Divider(),
      ListTile(
        leading: Icon(Icons.lock, size: 45,),
        title: Text('Password'),
        subtitle: Text('Change Your Password'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangePassword(),
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
                height: 35.0,
                width: double.infinity
            ),
          ),
          Expanded(
            child: Container(
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[

                  ],
                ),
              ),
            ),
          ),
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
                  children: <Widget>[
                    Text("Reports",style: TextStyle(decoration: TextDecoration.underline,color: Colors.blue,fontSize: 24))
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
      Container(
        child: Center(
          child: Text('Log'),
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
                  children: <Widget>[
                    Text("Settings",style: TextStyle(decoration: TextDecoration.underline,color: Colors.blue,fontSize: 24))
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
      const BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Log'),
      const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
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
          title: Text(widget.firstName+"'s Profile"),
        ),
        endDrawer: Drawer(
          child: drawerItems,
        ));

  }
}
