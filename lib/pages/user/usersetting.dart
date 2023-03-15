import 'package:colipid/pages/admin/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_page.dart';

class UserSetting extends StatefulWidget {
  const UserSetting({Key? key}) : super(key: key);

  @override
  _UserSettingState createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  int index = 1;

  late SharedPreferences logindata;
  late String username;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('ic').toString();
    });
  }

  Widget buttonLogout() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: MediaQuery.of(context).size.width/2,
      child: ElevatedButton(
        style: ButtonStyle(
          
          backgroundColor: MaterialStateProperty.all(Colors.red),
        ),
        onPressed: () async {
          final action = await Dialogs.yesAbortDialog(
              context, 'Confirm Logout?', 'Are you sure?');
          if (action == DialogAction.yes) {
            logindata.setBool('login', true);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPageScreen()));
          }
        },
        child: Text(
          'LOGOUT',
          style: TextStyle(
              color: Colors.white, fontSize: 18,fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

 Widget buttonUpdatePhoneNumber() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(
          
          backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 62, 151, 169)),
        ),
        onPressed: () async {
          final action = await Dialogs.yesAbortDialog(
              context, 'Confirm Logout?', 'Are you sure?');
          if (action == DialogAction.yes) {
            logindata.setBool('login', true);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPageScreen()));
          }
        },
        child: Text(
          'Update Phone Number',
          style: TextStyle(
              color: Colors.white, fontSize: 20,fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int index = 1;

    final items = <Widget>[
      Icon(Icons.file_open, size: 30),
      Icon(Icons.home, size: 30),
      Icon(Icons.person, size: 30),
    ];

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Align(
            alignment: Alignment.center,
            child: Image.asset(
                                      'images/ic_launcher.png',
                                      scale: 4,
                                      
                                    ),
          ),
          backgroundColor: Color.fromARGB(0, 46, 41, 41),
          elevation: 0,
        ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
             
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Settings',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: 20),
                     buttonUpdatePhoneNumber(),
                    SizedBox(height: 5),
                    buttonLogout(),
                   
                    SizedBox(height: 40),

                    SizedBox(height: 20),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
