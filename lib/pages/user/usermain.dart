import 'package:colipid/pages/user/userhealthmenu.dart';
import 'package:colipid/pages/user/userhome_page.dart';
import 'package:colipid/pages/user/usersetting.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserMainScreen extends StatefulWidget {
  //const UserMainScreen({Key? key}) : super(key: key);
  var myObject = 0;
  UserMainScreen({required this.myObject});
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
  void initState() {
    index = 0;
    index = widget.myObject;
    super.initState();
  }

  @override
  int index = 1;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.file_copy, size: 30, color: index == 0? Color.fromRGBO(255, 255, 255, 1) : Color.fromARGB(255, 168, 168, 168),),
      Icon(Icons.home, size: 30, color: index == 1? Color.fromRGBO(255, 255, 255, 1) : Color.fromARGB(255, 168, 168, 168),),
      Icon(Icons.logout, size: 30, color: index == 2? Color.fromRGBO(255, 255, 255, 1) : Color.fromARGB(255, 168, 168, 168),),
    ];

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to go exit?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        
        color: Color.fromARGB(255, 62, 151, 169),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        height: 60,
        index: index,
        items: items,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) => setState(() => this.index = index),
      ),
    ));
  }
}
