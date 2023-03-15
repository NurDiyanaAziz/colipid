import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/user/chooseexercise.dart';
import 'package:colipid/pages/user/viewexercise.dart';
import 'package:colipid/pages/user/viewmealtaken.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
  late String whratiostat;

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
    whratiostat='';
    initial();
  }

  late String total = "";
  late String totalDur="";
  late String percents="";
  late double percentss=0.0;
  late String perc=""; //percent inside circle
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

    double cal = 0;
    double dur=0;
    int size = snaps.size;
    String temp = '';
    String tempDur='0.0';
    double tempCalcPercent=0.0;
    double tempCalcPer=0.0;
    double percents1 =0.0;
    String calPer='';
    double tempdurr=0.0;
    for (int i = 0; i < size; i++) {
      cal += snaps.docs[i]['cal'];
      temp = cal.toStringAsFixed(2);
      dur += snaps.docs[i]['duration'];
      tempDur = dur.toStringAsFixed(0);
    }

tempdurr=double.parse(tempDur);
     //check if user done their min 30 min exercise
    if(tempdurr <45.0){
      tempCalcPercent = double.parse(tempDur)/60;
      percents1 = double.parse(tempCalcPercent.toStringAsFixed(1));
      
      
      tempCalcPer = tempCalcPercent*100;
      calPer=tempCalcPer.toStringAsFixed(1);
      

    }else if(tempdurr>=45.0){
      percents1 = 1.0;
      calPer = '100.0';
    }


    //suggest food set based on bmi value
    
   

    

    setState(() {
      ic = logindata.getString('ic').toString();
      name = snap.docs[0]['fullname'].toString();
      weight = snap.docs[0]['weight'].toString();
      height = snap.docs[0]['height'].toString();
      bmi = bmi1.toString();
      bmistat = snap.docs[0]['bmistatus'].toString();
      total = temp;
      totalDur = tempDur;
      percents = percents1.toStringAsFixed(1);
      percentss = double.parse(percents);
      perc=calPer;
      whratiostat = snap.docs[0]['ratiostat'].toString();
     
      
    });
  }

  @override
  Widget build(BuildContext context) {
   
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

    return  Scaffold(
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
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
             
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    
                  
                  SizedBox(
                      height: 30,
                      child: Align(
                                  alignment: Alignment.topLeft,
                                      child: Text(
                                        'Hi ' + name + ',',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      ),
                                  )
     
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 135, 148, 151),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            height: 270,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Profile',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Weight(kg): '+weight,
                                    style: TextStyle(
                                      letterSpacing: 1.5,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                 Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Height(m): '+height,
                                    style: TextStyle(
                                      letterSpacing: 1.5,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                 Align(
                                  alignment: Alignment.topLeft,
                                  child:Text(
                                    'BMI: '+bmi,
                                    style: TextStyle(
                                      letterSpacing: 1.5,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                 Align(
                                  alignment: Alignment.topLeft,
                                  child:Text(
                                    'Status: '+bmistat,
                                    style: TextStyle(
                                      letterSpacing: 1.5,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child:Text(
                                    'Waist & Hip stat: '+whratiostat,
                                    style: TextStyle(
                                      letterSpacing: 1.5,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                InkWell(
                          child:  Align(
                                  alignment: Alignment.topRight,
                                  child:Text(
                                    '',
                                    style: TextStyle(
                                      letterSpacing: 1.5,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ),onTap: () {
                            //
                          },
                        ),
                                
                               
                                
                                
                              ],
                            ),
                          ),
                          onTap: () {
                            //
                          },
                        ),

                    SizedBox(height: 20),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xFFA1ADE9),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            height: 250,
                            width: 170,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Meal',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Stack(
                                  children: [
                                   
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child:
                                         Image.asset(
                                      'images/food.png',
                                      
                                    ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    'Set meals to choose',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                             openDialogMenu();
                          },
                        ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xFFFB8B8B),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            height: 250,
                            width: 170,
                            child: Column(
                              children: [
                               Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Exercise ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                               SizedBox(
                                  height: 20,
                                ),
                                Stack(
                                  alignment: AlignmentDirectional.topCenter,
                                  children: [
                                  Align(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                          'images/circle.png',scale: 0.8,),
                                    ),
                                    CircularPercentIndicator(
                                        startAngle: 0.4,
                radius: 60.0,
                lineWidth: 13.0,
                animation: true,
                percent:percentss,
                center:  Text(
                  perc+"%",
                  style:
                       TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.purple,
              ),
                                    
                                    
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                               Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Total calories: ' + total + ' cal',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                 Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Duration: ' + totalDur + ' min',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              
                              ],
                            ),
                          ),
                          onTap: () {
                            openDialogExercise();
                          },
                        ),
                      ],
                    ),
                     
                       
                      
                    
                   
                 
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
