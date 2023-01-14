import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/user/chooseexercise.dart';
import 'package:colipid/pages/user/viewexercise.dart';
import 'package:colipid/pages/user/viewmealtaken.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../admin/dialogs.dart';
import 'choosemeal_page.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int index = 2;
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
    name = '';
    weight = '';
    height = '';
    bmi = '';
    bmistat = '';
    initial();
  }

  late String total = "";
  void initial() async {
    logindata = await SharedPreferences.getInstance();

    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .where("ic", isEqualTo: logindata.getString('ic').toString())
        .get();

    double bmi1 = double.parse((snap.docs[0]['bmi']).toStringAsFixed(2));

    var now = DateTime.now();
    var formatterDate = DateFormat('dd/MM/yyyy');
    String actualDate = formatterDate.format(now);

    QuerySnapshot snaps = await FirebaseFirestore.instance
        .collection("exercisereport")
        .where("date", isEqualTo: actualDate)
        .get();

    double weights = 0;
    int size = snaps.size;
    String temp = '';
    for (int i = 0; i < size; i++) {
      weights += snaps.docs[i]['cal'];
      temp = weights.toStringAsFixed(2);
    }

    setState(() {
      ic = logindata.getString('ic').toString();
      name = snap.docs[0]['fullname'].toString();
      weight = snap.docs[0]['weight'].toString();
      height = snap.docs[0]['height'].toString();
      bmi = bmi1.toString();
      bmistat = snap.docs[0]['bmistatus'].toString();
      total = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.file_open, size: 30),
      Icon(Icons.search, size: 30),
      Icon(Icons.home, size: 30),
      Icon(Icons.settings, size: 30),
      Icon(Icons.person, size: 30),
    ];
    Future openDialogMenu() => showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 600,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Meal'),
                    ),
                    SizedBox(
                      width: 300.0,
                      height: 100,
                      child: TextButton.icon(
                          icon: Image.asset(
                            "images/1.png",
                            scale: 2,
                          ),
                          label: const Text(
                            "1500KCAL",
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                          onPressed: () {
                            // call method
                            String word = "1500kcal";
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => ChooseMeal(
                                          myObject: word,
                                        )));
                          }),
                    ),
                    SizedBox(
                      width: 300.0,
                      height: 100,
                      child: TextButton.icon(
                        icon: Image.asset(
                          "images/2.png",
                          scale: 2,
                        ),
                        label: const Text(
                          "1800KCAL",
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                        onPressed: () {
                          // call method
                          String word = "1800kcal";
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => ChooseMeal(
                                        myObject: word,
                                      )));
                        },
                      ),
                    ),
                    SizedBox(
                      width: 300.0,
                      height: 100,
                      child: TextButton.icon(
                        icon: Image.asset(
                          "images/3.png",
                          scale: 2,
                        ),
                        label: const Text(
                          "2000KCAL",
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                        onPressed: () {
                          // call method
                          String word = "2000kcal";
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => ChooseMeal(
                                        myObject: word,
                                      )));
                        },
                      ),
                    ),
                    SizedBox(
                      width: 300.0,
                      height: 100,
                      child: TextButton.icon(
                        icon: Image.asset(
                          "images/meal.png",
                          scale: 2,
                        ),
                        label: const Text(
                          "View Meal Taken",
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                        onPressed: () {
                          // call method
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => userViewMealTaken()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });

    Future openDialogExercise() => showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Exercise',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 200.0,
                      height: 100,
                      child: TextButton.icon(
                        icon: Image.asset(
                          "images/exercise.png",
                          scale: 2,
                        ),
                        label: const Text(
                          "Add Exercise",
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                        onPressed: () {
                          // call method
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => ChooseExercise()));
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 200.0,
                      height: 100,
                      child: TextButton.icon(
                        icon: Image.asset(
                          "images/report1.png",
                          scale: 2,
                        ),
                        label: const Text(
                          "View Exercise",
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                        onPressed: () {
                          // call method
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => userViewExercise()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
             
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 200,
                      width: 400,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50)),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Stack(children: [
                        Positioned(
                            top: 10,
                            left: 10,
                            right: 10,
                            child: Container(
                              height: 180,
                              width: 300,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(163, 47, 132, 150),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40),
                                    bottomLeft: Radius.circular(40),
                                  )),
                            )),
                        Positioned(
                            top: 20,
                            left: 30,
                            child: Text(
                              "Profile\n\n" +
                                  "Name:         " +
                                  name +
                                  "\nWeight:       " +
                                  weight +
                                  " kg" +
                                  "\nHeight:        " +
                                  height +
                                  " m" +
                                  "\nBMI:             " +
                                  bmi +
                                  "\nBMI status: " +
                                  bmistat,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                      ]),
                    ),
                    const SizedBox(height: 30),
                    Card(
                        elevation: 5,
                        child: ListTile(
                          title: const Text('Meal'),
                          trailing: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                openDialogMenu();
                              }),
                        )),
                    const SizedBox(height: 15),
                    Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text(
                            'Exercise',
                          ),
                          subtitle: Text(
                            'Total calories burned: ' + total,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                openDialogExercise();
                              }),
                        )),
                    const SizedBox(height: 40),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
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
