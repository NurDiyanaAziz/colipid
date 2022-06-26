import 'package:colipid/pages/user/userhealthmenu.dart';
import 'package:colipid/pages/user/userhome_page.dart';
import 'package:colipid/pages/user/usersetting.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserMainScreen extends StatefulWidget {
  const UserMainScreen({Key? key}) : super(key: key);

  @override
  _UserMainScreenState createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {
  final screens = [
    UserHealthMenuScreen(),
    UserHomePage(),
    UserSetting(),
  ];

  @override
  /* void initState() {
    users = User.getUsers();
    super.initState();
  }*/

  @override
  int index = 1;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.file_copy, size: 30),
      Icon(Icons.home, size: 30),
      Icon(Icons.settings, size: 30),
    ];

    return Scaffold(
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color.fromARGB(255, 62, 151, 169),
        height: 60,
        index: index,
        items: items,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) => setState(() => this.index = index),
      ),
    );
  }
}
