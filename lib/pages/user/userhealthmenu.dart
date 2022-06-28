import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/admin/adminmain.dart';
import 'package:colipid/pages/admin/dialogs.dart';
import 'package:colipid/pages/user/userViewReport.dart';
import 'package:colipid/pages/user/user_updateprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHealthMenuScreen extends StatefulWidget {
  const UserHealthMenuScreen({Key? key}) : super(key: key);

  @override
  _UserHealthMenuScreenState createState() => _UserHealthMenuScreenState();
}

class _UserHealthMenuScreenState extends State<UserHealthMenuScreen> {
  late String name;
  late String weight;
  late String height;
  late String bmi;
  late String bmistat;

  late SharedPreferences logindata;
  late String ic;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();

    setState(() {
      ic = logindata.getString('ic').toString();
    });
  }

  Widget buildBackBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      height: 70,
      width: 100,
      child: RaisedButton(
        elevation: 5,
        onPressed: () async {
          //String ic = widget.myObject.toString();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AdminMainScreen()));
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Text(
          'Back',
          style: TextStyle(
              color: Colors.blue[400],
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildViewReportBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: 300,
      child: RaisedButton(
        elevation: 5,
        onPressed: () async {
          //String ic = widget.myObject.toString();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => userViewReport()));
        },
        padding: EdgeInsets.all(55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        color: Colors.white,
        child: Text(
          'View Report',
          style: TextStyle(
              color: Color(0xff3e97a9),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildUpdateLipidBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () async {
          //String ic = widget.myObject.toString();
          //Navigator.of(context).pushReplacement(MaterialPageRoute(
          // builder: (context) => AdminUpdateLipidProfile(myObject: ic)));
        },
        padding: EdgeInsets.all(55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Text(
          'Update Patient Lipid Profile',
          style: TextStyle(
              color: Color(0xff3e97a9),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildInputPatientInfoBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 85),
      width: 300,
      child: RaisedButton(
        elevation: 5,
        onPressed: () async {
          // String ic = widget.myObject.toString();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => UserUpdateInfo()));
        },
        padding: EdgeInsets.all(55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        color: Colors.white,
        child: Text(
          'Update Patient Profile',
          style: TextStyle(
              color: Color(0xff3e97a9),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildInputMedPatientBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () async {
          // String ic = widget.myObject.toString();
          //Navigator.of(context).pushReplacement(MaterialPageRoute(
          // builder: (context) => AdminPatientMedicine(myObject: ic)));
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Text(
          'Update Patient Medicine',
          style: TextStyle(
              color: Color(0xff3e97a9),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildSubmitBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      width: 100,
      child: RaisedButton(
        elevation: 5,
        onPressed: () async {
          final action = await Dialogs.yesAbortDialog(
              context, 'Confirm Submit?', 'Are you sure?');
          if (action == DialogAction.yes) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AdminMainScreen()));
          }
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Text(
          'Submit',
          style: TextStyle(
              color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  int index = 1;

  @override
  Widget build(BuildContext context) {
    int index = 1;

    final items = <Widget>[
      Icon(Icons.file_open, size: 30),
      Icon(Icons.home, size: 30),
      Icon(Icons.person, size: 30),
    ];

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0x663e97a9),
                  Color(0x993e97a9),
                  Color(0xcc3e97a9),
                  Color(0xff3e97a9),
                ],
              )),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Patient Info Menu',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    buildInputPatientInfoBtn(),
                    SizedBox(height: 5),
                    buildViewReportBtn(),
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
