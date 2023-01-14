import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/admin/dialogs.dart';
import 'package:colipid/pages/body_model.dart';
import 'package:colipid/pages/lipid_model.dart';
import 'package:colipid/pages/user/usermain.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../exercisetaken_model.dart';

class userViewExercise extends StatefulWidget {
  //const AdminViewReportPatient({Key? key}) : super(key: key);
  var myObject;
  userViewExercise({this.myObject});
  @override
  _userViewExerciseState createState() => _userViewExerciseState();
}

class _userViewExerciseState extends State<userViewExercise> {
  int index = 1;

  @override
  void initState() {
    super.initState();
    fetchUser();
    fetchTotal();
  }

  late SharedPreferences logindata;
  final tot = TextEditingController();

  late String icc = "";
  late String total = "";
  String actualDate = "";
  Future<void> fetchUser() async {
    // do something
    logindata = await SharedPreferences.getInstance();
    String ic = logindata.getString('ic').toString();
    var now = DateTime.now();
    var formatterDate = DateFormat('dd/MM/yyyy');
    String date = formatterDate.format(now);
    setState(() {
      icc = ic;
      actualDate = date;
    });
  }

  Future<void> fetchTotal() async {
    // do something
    logindata = await SharedPreferences.getInstance();
    String ic = logindata.getString('ic').toString();

    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("exercisereport")
        .where("date", isEqualTo: actualDate)
        .get();

    double weight = 0;
    int size = snap.size;
    String temp = '';
    for (int i = 0; i < size; i++) {
      weight += snap.docs[i]['cal'];
      temp = weight.toStringAsFixed(2);
    }

    setState(() {
      total = temp;
    });
  }

  Widget buildReportUsers(ExerciseTakenModel e) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        shadowColor: Colors.black,
        color: Color.fromARGB(255, 255, 255, 255),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                //SizedBox
                Text(
                  e.date.toString(),

                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ), //Textstyle
                ), //Text
                SizedBox(
                  height: 10,
                ),
                Text(
                  '',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ), //Textstyle
                ), //Text
                //SizedBox
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          child: Text(
                            'Exercise Name: \n' + e.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ), //Textstyle
                          ),
                        ),
                        Text(
                          'Time Added: ' + e.time.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          'Calories Burned: ' + e.cal.toString() + ' cal',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  child: Text(
                    'Duration of Exercise: ' + e.durations.toString() + ' min',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 29, 9, 83),
                    ), //Textstyle
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                //SizedBox
              ],
            ), //Column
          ), //Padding
        ), //SizedBox
      );

  Widget buildBodyReportUsers(BodyModel e) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        shadowColor: Colors.black,
        color: Color.fromARGB(255, 255, 254, 254),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                //SizedBox
                Text(
                  e.date.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ), //Textstyle
                ), //Text
                SizedBox(
                  height: 10,
                ),
                Text(
                  '',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ), //Textstyle
                ), //Text
                //SizedBox
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          child: Text(
                            'WEIGHT: ' + e.weight.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ), //Textstyle
                          ),
                        ),
                        Text(
                          'HEIGHT: ' + e.height.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          'BMI: ' +
                              double.parse(e.bmi.toStringAsFixed(2)).toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          'WAIST: ' + e.waist.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          'HIP: ' + e.hip.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          'WS/HIP: ' +
                              double.parse(e.ratio.toStringAsFixed(2))
                                  .toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        Text(
                          ' ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          ' ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          e.bmiStatus,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          ' ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          e.ratiostat.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),
              ],
            ), //Column
          ), //Padding
        ), //SizedBox
      );

  Stream<List<ExerciseTakenModel>> readExerciseReport() =>
      FirebaseFirestore.instance
          .collection('exercisereport')
          .where("date", isEqualTo: actualDate)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ExerciseTakenModel.fromJson(doc.data()))
              .toList());

  Widget buildBackBtn() {
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
                    child: ElevatedButton(
                   
                      onPressed: () async {
                        final index = 1;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                UserMainScreen(myObject: index)));
                      },
                     
                      child: Text(
                        'Back',
                        style: TextStyle(
                            color: Colors.blue[400],
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    int index = 1;

    final items = <Widget>[
      const Icon(Icons.file_open, size: 30),
      const Icon(Icons.home, size: 30),
      const Icon(Icons.person, size: 30),
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
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    buildBackBtn(),
                    const SizedBox(
                      height: 50,
                      child: Text(
                        'Exercise Report',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Text(
                        'Total calories burned: ' + total + ' cal',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 500,
                      child: StreamBuilder<List<ExerciseTakenModel>>(
                          stream: readExerciseReport(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(
                                  'Something went wrong!: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final users = snapshot.data!;

                              return ListView(
                                  children:
                                      users.map(buildReportUsers).toList());
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    ),
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
