import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/admin/dialogs.dart';
import 'package:colipid/pages/lipid_model.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'adminpatientmenu_page.dart';

class AdminViewReportPatient extends StatefulWidget {
  //const AdminViewReportPatient({Key? key}) : super(key: key);
  var myObject;
  AdminViewReportPatient({this.myObject});
  @override
  _AdminViewReportPatientState createState() => _AdminViewReportPatientState();
}

class _AdminViewReportPatientState extends State<AdminViewReportPatient> {
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

  late String icc = "";
  void fetchUser() {
    // do something
    String ic = widget.myObject.toString();
    setState(() {
      icc = ic;
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
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AdminUpdatePatient(myObject: icc)));
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
                  Color(0x66C4A195),
                  Color(0x99C4A195),
                  Color(0xccC4A195),
                  Color(0xffC4A195),
                ],
              )),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    const SizedBox(height: 5),
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
