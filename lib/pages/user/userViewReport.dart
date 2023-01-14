import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/admin/dialogs.dart';
import 'package:colipid/pages/body_model.dart';
import 'package:colipid/pages/lipid_model.dart';
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

  Widget buildReportUsers(LipidModel e) => Card(
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
                  children: [
                    Column(
                      children: [
                        Container(
                          child: Text(
                            'TC: ' + e.tc.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ), //Textstyle
                          ),
                        ),
                        Text(
                          'HDL: ' + e.hdl.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          'LDL: ' + e.tc.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          'Trigly: ' + e.trigly.toString(),
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
                          e.tcstatus.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          e.hdlstatus.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          e.ldlstatus.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          e.triglystatus.toString(),
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
                SizedBox(
                  child: Text(
                    'Doctor comment: ' + e.comment.toString(),
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
                SizedBox(
                  height: 30,
                  child: Text(
                    'Doctor Name: ' + e.drname.toString(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ), //Textstyle
                  ),
                ), //SizedBox
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

/*  Widget buildLineChart() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        height: 70,
        width: 100,
        child: SfCartesianChart(
            primaryXAxis: DateTimeAxis(),
            series: <ChartSeries>[
              // Renders line chart
              LineSeries<SalesData, int>(
                  dataSource: chartData,
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales)
            ]));
  }*/

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
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Report',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    buildBackBtn(),
                    const SizedBox(
                      height: 30,
                      child: Text(
                        'Lipid Report',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 350,
                      child: StreamBuilder<List<LipidModel>>(
                          stream: readLipidReport(),
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
                    const SizedBox(
                      height: 30,
                      child: Text(
                        'Body Report',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 350,
                      child: StreamBuilder<List<BodyModel>>(
                          stream: readBodyReport(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(
                                  'Something went wrong!: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final users = snapshot.data!;

                              return ListView(
                                  children:
                                      users.map(buildBodyReportUsers).toList());
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
