import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/patientlist_model.dart';
import 'package:colipid/pages/user/userhealthmenu.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../admin/dialogs.dart';

class UserUpdateInfo extends StatefulWidget {
  //const AdminAddPatientInfo(String ic, {Key? key}) : super(key: key);

  @override
  _UserUpdateInfoState createState() => _UserUpdateInfoState();
}

enum SingingCharacter { No, Yes }
enum SingingCharacters { Male, Female }

class _UserUpdateInfoState extends State<UserUpdateInfo> {
  int index = 1;
  String _dropdownValue = "";
  List items = [
    'Choose',
  ];

  late String names;
  late String weights;
  late String heights;
  late String bmis;
  late String bmistats;

  late SharedPreferences logindata;
  late String ics;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    names = '';
    weights = '';
    heights = '';
    bmis = '';
    bmistats = '';
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();

    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .where("ic", isEqualTo: logindata.getString('ic').toString())
        .get();

    double bmi1 = double.parse((snap.docs[0]['bmi']).toStringAsFixed(2));

    setState(() {
      ics = logindata.getString('ic').toString();
      names = snap.docs[0]['fullname'].toString();
      weights = snap.docs[0]['weight'].toString();
      heights = snap.docs[0]['height'].toString();
      bmis = bmi1.toString();
      bmistats = snap.docs[0]['bmistatus'].toString();
    });
  }

  SingingCharacters? _characters = SingingCharacters.Male;
  SingingCharacter? _character = SingingCharacter.No;
  String dropdownValue = 'Sedentary';

  final name = TextEditingController();
  final phone = TextEditingController();
  final ic = TextEditingController();
  final height = TextEditingController();
  final dob = TextEditingController();
  final weight = TextEditingController();
  final waist = TextEditingController();
  final hip = TextEditingController();
  final age = TextEditingController();
  double? bmi = 0.0;
  String? bmistat = '';
  String? hipwaistratio = '';

  Widget buildBack() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            height: 70,
            width: 100,
            child: RaisedButton(
              elevation: 5,
              onPressed: () async {
                final action = await Dialogs.yesAbortDialog(
                    context, 'Confirm Discard?', 'Are you sure?');
                if (action == DialogAction.yes) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => UserHealthMenuScreen()));
                }
              },
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Colors.white,
              child: Text(
                'Back',
                style: TextStyle(
                    color: Colors.blue[400],
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )),
      ],
    );
  }

  /*void _sendDataBack(BuildContext context) {
    String textToSendBack = textFieldController.text;
    Navigator.pop(context, textToSendBack);
  }*/

  Widget buildID() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                padding: const EdgeInsets.all(15),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2))
                    ]),
                height: 60,
                child: Text(
                  ics,
                  style: TextStyle(fontSize: 20),
                )))
      ],
    );
  }

  Widget buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
              controller: name,
              keyboardType: TextInputType.name,
              style: TextStyle(color: Colors.black87, fontSize: 20),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.people, color: Color(0x663e97a9)),
                  hintText: 'Name',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
        )
      ],
    );
  }

  Widget buildPhone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
              controller: phone,
              keyboardType: TextInputType.name,
              style: TextStyle(color: Colors.black87, fontSize: 20),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon:
                      Icon(Icons.phone_android, color: Color(0x663e97a9)),
                  hintText: 'Phone',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
        )
      ],
    );
  }

  Widget buildDateBirth() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ]),
              height: 60,
              child: TextField(
                controller: dob,
                keyboardType: TextInputType.name,
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon:
                        Icon(Icons.calendar_month, color: Color(0x663e97a9)),
                    hintText: 'Date of Birth',
                    hintStyle: TextStyle(color: Colors.black38)),
              ),
            ))
      ],
    );
  }

  Widget buildAge() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ]),
              height: 60,
              child: TextField(
                controller: age,
                keyboardType: TextInputType.name,
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon:
                        Icon(Icons.calendar_month, color: Color(0x663e97a9)),
                    hintText: 'Age',
                    hintStyle: TextStyle(color: Colors.black38)),
              ),
            ))
      ],
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
            QuerySnapshot snap = await FirebaseFirestore.instance
                .collection("users")
                .where("ic", isEqualTo: ics)
                .get();

            String id = snap.docs[0]['id'].toString();
            String ages = age.text;
            double weights = double.parse(weight.text);
            double heights = double.parse(height.text);
            double waists = double.parse(waist.text);
            double hips = double.parse(hip.text);
            String active = dropdownValue.toString();
            String gend = _characters.toString().substring(18);
            String aller = _character.toString().substring(17);

            bmi = weights / (heights * heights);
            if (bmi! < 18.5) {
              bmistat = "underweight";
            } else if (bmi! >= 18.5 && bmi! <= 24.9) {
              bmistat = "healthy weight";
            } else if (bmi! >= 25.0 && bmi! <= 29.9) {
              bmistat = "overweight";
            } else if (bmi! >= 30) {
              bmistat = "obese";
            }

            double whratio = waists / hips;
            if (gend == "Male") {
              if (whratio <= 0.95) {
                hipwaistratio = "Health Risk Low";
              } else if (whratio > 0.95 && whratio <= 1.0) {
                hipwaistratio = "Health Risk Moderate";
              } else if (whratio > 1.0) {
                hipwaistratio = "Health Risk High";
              }
            } else if (gend == "Female") {
              if (whratio <= 0.80) {
                hipwaistratio = "Health Risk Low";
              } else if (whratio > 0.81 && whratio <= 0.85) {
                hipwaistratio = "Health Risk Moderate";
              } else if (whratio > 0.86) {
                hipwaistratio = "Health Risk High";
              }
            }

            final docUser =
                FirebaseFirestore.instance.collection('users').doc(id);

            docUser.update({
              'active': active,
              'dob': dob.text,
              'allergic': aller,
              'bmi': bmi,
              'gender': gend,
              'bmistatus': bmistat,
              'age': ages,
              'height': heights,
              'weight': weights,
              'waist': waists,
              'hip': hips,
              'ratio': whratio,
              'ratiostat': hipwaistratio,
            });

            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => UserHealthMenuScreen()));
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

  Widget buildWeightHeight() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Flexible(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            width: 180,
            child: TextField(
              controller: weight,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon:
                      Icon(Icons.monitor_weight, color: Color(0x663e97a9)),
                  hintText: 'Weight in kg',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
        )),
        new Flexible(
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 2))
                      ]),
                  height: 60,
                  width: 180,
                  child: TextField(
                    controller: height,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14),
                        prefixIcon:
                            Icon(Icons.height, color: Color(0x663e97a9)),
                        hintText: 'Height in meter',
                        hintStyle: TextStyle(color: Colors.black38)),
                  ),
                )))
      ],
    );
  }

  Widget buildWaistHip() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Flexible(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            width: 180,
            child: TextField(
              controller: waist,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14, left: 20),
                  hintText: 'Waist in cm',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
        )),
        new Flexible(
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 2))
                      ]),
                  height: 60,
                  width: 180,
                  child: TextField(
                    controller: hip,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 20),
                        hintText: 'Hip in cm',
                        hintStyle: TextStyle(color: Colors.black38)),
                  ),
                )))
      ],
    );
  }

  void onChangedAllergic(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  Widget buildGender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Gender',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ListTile(
          title: const Text('Male',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600)),
          leading: Radio<SingingCharacters>(
            value: SingingCharacters.Male,
            groupValue: _characters,
            onChanged: (SingingCharacters? value) {
              setState(() {
                _characters = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Female',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600)),
          leading: Radio<SingingCharacters>(
            value: SingingCharacters.Female,
            groupValue: _characters,
            onChanged: (SingingCharacters? value) {
              setState(() {
                _characters = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget buildAllergic() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Have allergic?',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ListTile(
          title: const Text(
            'No',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.No,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text(
            'Yes',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.Yes,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget buildActiveType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'How Active Are You',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
            padding: const EdgeInsets.all(15.0),
            width: 200,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 80,
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(
                  color: Color.fromARGB(255, 92, 57, 4), fontSize: 18),
              underline: Container(
                height: 2,
                color: Color.fromARGB(255, 128, 101, 14),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['Sedentary', 'Moderately Active', 'Active']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ))
      ],
    );
  }

  final screens = [];

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
                      'Patient Information',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    buildBack(),
                    SizedBox(height: 30),
                    buildID(),
                    buildName(),
                    buildPhone(),
                    buildDateBirth(),
                    buildAge(),
                    buildWeightHeight(),
                    buildWaistHip(),
                    SizedBox(height: 20),
                    buildGender(),
                    SizedBox(height: 20),
                    buildAllergic(),
                    SizedBox(height: 15),
                    buildActiveType(),
                    SizedBox(height: 15),
                    buildSubmitBtn()
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
