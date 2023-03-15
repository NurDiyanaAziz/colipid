import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/user/app_large_text.dart';
import 'package:colipid/pages/user/app_text.dart';
import 'package:colipid/pages/user/choosemeal_page.dart';
import 'package:colipid/pages/user/usermain.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../admin/dialogs.dart';
import '../mealtaken_model.dart';

class MenuDetail extends StatefulWidget {
  //const AdminViewReportPatient({Key? key}) : super(key: key);
  var myObject;
  MenuDetail({required this.plan, required this.plantype});
  final String plan;
  final String plantype;

  @override
  _MenuDetailState createState() => _MenuDetailState();
}

class _MenuDetailState extends State<MenuDetail> {
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
    String plantype1 = widget.plantype;

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
      plantypes = plantype1;
    });
  }

  late SharedPreferences logindata;
  late String plannames = "";
  late String plantypes = "";

  Widget buildBackChooseBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 1,
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            height: 70,
            width: 100,
            child: ElevatedButton(
              onPressed: () async {
                final index = 0;
                 Navigator.pop(context,true);

              
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
        Flexible(
          flex: 1,
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            height: 70,
            width: 200,
            child: ElevatedButton(
              onPressed: () async {
                final action = await Dialogs.yesAbortDialog(
                    context, 'Confirm?', 'Are you sure?');
                if (action == DialogAction.yes) {
                  var now = DateTime.now();
                  var formatterDate = DateFormat('dd/MM/yyyy');
                  var formatterTime = DateFormat('HH:mm');
                  String actualDate = formatterDate.format(now);
                  String actualTime = formatterTime.format(now);

                  final index = 1;
                  final ic;

                  logindata = await SharedPreferences.getInstance();

                  final mealprofile = MealTakenModel(
                    ic: logindata.getString('ic').toString(),
                    date: actualDate,
                    time: actualTime,
                    plan: plannames,
                    plantype: plantypes,
                  );
                  inputMeal(mealprofile);

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Meal succesful added into the list")));
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => UserMainScreen(myObject: index)));
                }
              },
              child: Text(
                'Choose This Meal',
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

  Widget buildSubmitBtn() {
    return Container(
    
      padding: EdgeInsets.symmetric(vertical: 5),
      width: 100,
      child: ElevatedButton(

        onPressed: () async {
          var now = DateTime.now();
          var formatterDate = DateFormat('dd/MM/yyyy');
          var formatterTime = DateFormat('HH:mm');
          String actualDate = formatterDate.format(now);
          String actualTime = formatterTime.format(now);

          final action = await Dialogs.yesAbortDialog(
              context, 'Confirm Submit?', 'Are you sure?');
          if (action == DialogAction.yes) {
            QuerySnapshot snap = await FirebaseFirestore.instance
                .collection("users")
                .where("ic", isEqualTo: logindata.getString('ic').toString())
                .get();

            String id = snap.docs[0]['id'].toString();

            final mealtaken = MealTakenModel(
              ic: logindata.getString('ic').toString(),
              date: actualDate,
              time: actualTime,
            );
            inputMeal(mealtaken);

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Exercise succesful added into the list")));

            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => UserMainScreen(
                      myObject: 1,
                    )));
          }
        },
       
        child: Text(
          'Submit',
          style: TextStyle(
              color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
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
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height-80,
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
                                      top: 150, left: 10, right: 10),
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

                    buildBackChooseBtn(),
                  ],
                ),
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
