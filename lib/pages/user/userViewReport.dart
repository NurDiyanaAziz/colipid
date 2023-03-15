import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/admin/dialogs.dart';
import 'package:colipid/pages/body_model.dart';
import 'package:colipid/pages/lipid_model.dart';
import 'package:colipid/pages/user/hdlLipid.dart';
import 'package:colipid/pages/user/ldlLipid.dart';
import 'package:colipid/pages/user/tcLipid.dart';
import 'package:colipid/pages/user/triglyLipid.dart';
import 'package:colipid/pages/user/usermain.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userViewReport extends StatefulWidget {
  //const AdminViewReportPatient({Key? key}) : super(key: key);
  var myObject;
  userViewReport({this.myObject});
  @override
  _userViewReportState createState() => _userViewReportState();
}

class _userViewReportState extends State<userViewReport> {
  int index = 1;

  /* late List<charts.Series<LipidModel, String>> _seriesBarData;
  late List<LipidModel> myData;
  _generateData(myData) {
    _seriesBarData.add(charts.Series(
        domainFn: (LipidModel lipid, _) => lipid.date.toString(),
        measureFn: (LipidModel lipid, _) => lipid.tc,
        id: 'LipidModel',
        data: myData,
        labelAccessorFn: (LipidModel row, _) => "${row.date}"));
  }*/

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  late SharedPreferences logindata;

  late String icc = "";
  Future<void> fetchUser() async {
    // do something
    logindata = await SharedPreferences.getInstance();
    String ic = logindata.getString('ic').toString();
    setState(() {
      icc = ic;
    });
  }

  int _currentIndex=0;
List cardList=[
    tcLipid(),
    hdlLipid(),
    ldlLipid(),
    triglyLipid()
  ];
List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }


  Widget buildReportUsers() => CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height-160,
                autoPlay: false,
                autoPlayInterval: Duration(seconds: 7),
                autoPlayAnimationDuration: Duration(milliseconds: 2000),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: cardList.map((card){
                return Builder(
                  builder:(BuildContext context){
                    return Container(
                      height: MediaQuery.of(context).size.height*0.30,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Colors.blueAccent,
                        child: card,
                      ),
                    );
                  }
                );
              }).toList(),
            );

  Widget buildBodyReportUsers(BodyModel e) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        shadowColor: Colors.black,
        color: Color.fromARGB(255, 228, 228, 228),
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

  Stream<List<LipidModel>> readLipidReport() => FirebaseFirestore.instance
      .collection('lipidreport')
      .where('ic', isEqualTo: icc)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => LipidModel.fromJson(doc.data())).toList());

  Stream<List<BodyModel>> readBodyReport() => FirebaseFirestore.instance
      .collection('bodyreport')
      .where('ic', isEqualTo: icc)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => BodyModel.fromJson(doc.data())).toList());

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
                        final index = 0;
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

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to go back?'),
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
      child:  Scaffold(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                     const Align(
                                  alignment: Alignment.topLeft,
                                      child: Text(
                      'Report',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                                  ),
                   
                    const SizedBox(height: 20),
                     const Align(
                                  alignment: Alignment.topLeft,
                                      child: Text(
                        'Lipid Report',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                                  ),
                        const SizedBox(height: 20),    
                        buildReportUsers()      
            
                    
                   
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
