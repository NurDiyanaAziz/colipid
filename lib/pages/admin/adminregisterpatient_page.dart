import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/lipid_model.dart';
import 'package:colipid/pages/patientlist_model.dart';
import 'package:colipid/pages/user_model.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'adminhome_page.dart';
import 'adminmain.dart';
import 'adminpatientmenu_page.dart';

class AdminRegisterPatient extends StatefulWidget {
  //const AdminRegisterPatient({Key? key}) : super(key: key);
  var myObject;
  AdminRegisterPatient({this.myObject});
  @override
  _AdminRegisterPatientState createState() => _AdminRegisterPatientState();
}

class _AdminRegisterPatientState extends State<AdminRegisterPatient> {
  int index = 1;
  final name = TextEditingController();
  final phones = TextEditingController();
  final ics = TextEditingController();

  void initState() {
    super.initState();
    fetchUserData();
  }

  late String icc = "";
  void fetchUserData() {
    // do something
    String ic = widget.myObject.toString();
    setState(() {
      icc = ic;
      ics.text = ic;
    });
  }

  Widget buildBackBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      height: 70,
      width: 100,
      child: ElevatedButton(
        
        onPressed: () async {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AdminMainScreen()));
        },
     
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

  Widget buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Patient Name',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextFormField(
            controller: name,
            keyboardType: TextInputType.name,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 20),
                hintText: 'Insert Patient Name',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildIC() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Patient IC',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextFormField(
            maxLength: 12,
            controller: ics,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 34, left: 20),
                hintText: 'Insert Patient IC',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildPhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone Number',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextFormField(
            maxLength: 11,
            controller: phones,
            keyboardType: TextInputType.phone,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 34, left: 20),
                hintText: 'Insert Patient Phone Number',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildSubmitBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      height: 90,
      width: 130,
      child: ElevatedButton(
       
        onPressed: () async {
          final fullname = name.text;
          final phone = phones.text;
          final ic = ics.text;

          final user = UserModel(fullname: fullname, phone: phone, ic: ic);
          final existuser =
              PatientListModel(fullname: fullname, phone: phone, ic: ic);
          final lipid = LipidModel(ic: ic);
          regPatient(user);
          regLipid(lipid);
          regExistPatient(existuser);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AdminMainScreen()));
        },
      
        child: Text(
          'Submit',
          style: TextStyle(
              color: Colors.green[400],
              fontSize: 18,
              fontWeight: FontWeight.bold),
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
                  Color(0x66C4A195),
                  Color(0x99C4A195),
                  Color(0xccC4A195),
                  Color(0xffC4A195),
                ],
              )),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Register New Patient',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    buildBackBtn(),
                    SizedBox(height: 50),
                    buildName(),
                    SizedBox(height: 20),
                    buildIC(),
                    SizedBox(height: 20),
                    buildPhoneNumber(),
                    SizedBox(height: 20),
                    buildSubmitBtn(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future regPatient(UserModel user) async {
    //reference document
    final docPatient = FirebaseFirestore.instance.collection('users').doc();
    user.id = docPatient.id;
    user.usertype = 'patient';
    final json = user.toJson();
    await docPatient.set(json);
  }

  Future regExistPatient(PatientListModel user) async {
    //reference document
    final docPatient =
        FirebaseFirestore.instance.collection('listpatient').doc();
    var now = DateTime.now();
    var formatterDate = DateFormat('dd/MM/yy');
    var formatterTime = DateFormat('HH:mm');
    String actualDate = formatterDate.format(now);
    String actualTime = formatterTime.format(now);
    user.date = actualDate;
    user.time = actualTime;
    user.id = docPatient.id;
    final json = user.toJson();
    await docPatient.set(json);
  }

  Future regLipid(LipidModel lipid) async {
    //reference document
    final docPatient =
        FirebaseFirestore.instance.collection('lipidreport').doc();
    lipid.id = docPatient.id;
    final json = lipid.toJson();
    await docPatient.set(json);
  }
}
