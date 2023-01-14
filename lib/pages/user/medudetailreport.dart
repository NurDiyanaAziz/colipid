import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/user/app_large_text.dart';
import 'package:colipid/pages/user/app_text.dart';
import 'package:colipid/pages/user/choosemeal_page.dart';
import 'package:colipid/pages/user/usermain.dart';
import 'package:colipid/pages/user/viewmealtaken.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../admin/dialogs.dart';
import '../mealtaken_model.dart';

class MenuDetailReport extends StatefulWidget {
  //const AdminViewReportPatient({Key? key}) : super(key: key);
  var myObject;
  MenuDetailReport({required this.plan});
  final String plan;

  @override
  _MenuDetailReportState createState() => _MenuDetailReportState();
}

class _MenuDetailReportState extends State<MenuDetailReport> {
  int index = 1;

  List text1 = ["Breakfast", "Morning Tea", "Lunch", "Teatime", "Dinner"];

  List images = [
    "morning.png",
    "morning tea.png",
    "lunch.png",
    "teatime.png",
    "dinner.png",
  ];

  List<String> detailbreakfast = [];
  List<String> detailmorningtea = [];
  List<String> detaillunch = [];
  List<String> detailteatime = [];
  List<String> detaildinner = [];
  List<String> allDetail = [];

  @override
  void initState() {
    super.initState();
    fetchDetail();
  }

  PageController page = PageController(initialPage: 0);
  int pageIndex = 0;

  late String arrayBreakfast;
  late String arrayMorningtea;
  late String arrayLunch;
  late String arrayTeatime;
  late String arrayDinner;
  Future<void> fetchDetail() async {
    // do something
    String planname = widget.plan;

    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("mealplan")
        .where("plan", isEqualTo: planname)
        .get();

    arrayBreakfast = snap.docs[0]['breakfast'].toString();
    arrayMorningtea = snap.docs[0]['morningtea'].toString();
    arrayLunch = snap.docs[0]['lunch'].toString();
    arrayTeatime = snap.docs[0]['teatime'].toString();
    arrayDinner = snap.docs[0]['dinner'].toString();
    setState(() {
      detailbreakfast = arrayBreakfast.split('+');
      detailmorningtea = arrayMorningtea.split('+');
      detaillunch = arrayLunch.split('+');
      detailteatime = arrayTeatime.split('+');
      detaildinner = arrayDinner.split('+');
      plannames = planname;
    });
  }

  late SharedPreferences logindata;
  late String plannames = "";

  Widget buildBackSubmmimtBtn() {
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
                    builder: (context) => userViewMealTaken(myObject: index)));
              },
              child: Text(
                'Back',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )),
      ],
    );
  }

  Widget buildViewMeal() {
    return Container(child: Text(''));
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
                colors: [Colors.white, Colors.white],
              )),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 800,
                      child: PageView(
                        controller: page,
                        scrollDirection: Axis.horizontal,
                        pageSnapping: true,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('images/morning.png'),
                                      fit: BoxFit.cover)),
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 150, left: 20, right: 20),
                                  child: Row(children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppLargeText(text: text1[0]),
                                        const SizedBox(height: 15),
                                        for (var i in detailbreakfast)
                                          AppText(text: i.toString()),
                                      ],
                                    ),
                                  ]))),
                          Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('images/morning tea.png'),
                                      fit: BoxFit.cover)),
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 150, left: 20, right: 20),
                                  child: Row(children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppLargeText(text: text1[1]),
                                        const SizedBox(height: 15),
                                        for (var i in detailmorningtea)
                                          AppText(text: i.toString()),
                                      ],
                                    ),
                                  ]))),
                          Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('images/lunch.png'),
                                      fit: BoxFit.cover)),
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 150, left: 20, right: 20),
                                  child: Row(children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppLargeText(text: text1[2]),
                                        const SizedBox(height: 15),
                                        for (var i in detaillunch)
                                          AppText(text: i.toString()),
                                      ],
                                    ),
                                  ]))),
                          Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('images/teatime.png'),
                                      fit: BoxFit.cover)),
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 150, left: 20, right: 20),
                                  child: Row(children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppLargeText(text: text1[3]),
                                        const SizedBox(height: 15),
                                        for (var i in detailteatime)
                                          AppText(text: i.toString()),
                                      ],
                                    ),
                                  ]))),
                          Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('images/dinner.png'),
                                      fit: BoxFit.cover)),
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 150, left: 20, right: 20),
                                  child: Row(children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppLargeText(text: text1[4]),
                                        const SizedBox(height: 15),
                                        for (var i in detaildinner)
                                          AppText(text: i.toString()),
                                      ],
                                    ),
                                  ]))),
                        ],
                      ),
                    ),

                    // buildViewMeal(),

                    buildBackSubmmimtBtn(),
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

Future inputMeal(MealTakenModel meal) async {
  //reference document
  final mealc = FirebaseFirestore.instance.collection('mealtaken').doc();

  meal.id = mealc.id;
  final json = meal.toJson();
  await mealc.set(json);
}
