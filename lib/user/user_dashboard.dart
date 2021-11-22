import 'package:flutter/material.dart';
import 'package:time_and_attendance/login_page.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserDashboardState();
}

class _UserDashboardState
    extends State<UserDashboard> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    const drawerHeader = UserAccountsDrawerHeader(
      accountName: Text('User Name'),
      accountEmail: Text('user.name@email.com'),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: FlutterLogo(size: 42.0),
      ),
    );
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          leading: Icon(Icons.house),
          title: const Text('Home'),
          onTap: () =>  Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => UserDashboard()),
                (Route<dynamic> route) => false,
          ),
        ),
        ListTile(
          leading: Icon(Icons.add),
          title: const Text('Extra Button'),
          onTap: () =>  Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => UserDashboard()),
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
    final _kTabPages = <Widget>[
      const Center(child: Icon(Icons.house, size: 64.0, color: Colors.teal)),
      const Center(child: Icon(Icons.person, size: 64.0, color: Colors.cyan)),
      const Center(child: Icon(Icons.calendar_today, size: 64.0, color: Colors.blue)),
      const Center(child: Icon(Icons.settings, size: 64.0, color: Colors.blueAccent)),
    ];
    final _kButtonNavBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.house), label: 'Home'),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
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
          title: const Text('User Dashboard'),
        ),
        drawer: Drawer(
          child: drawerItems,
        ));

  }
}
