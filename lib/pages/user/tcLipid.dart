import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


  class tcLipid extends StatefulWidget {
  //const AdminViewReportPatient({Key? key}) : super(key: key);
  var myObject;
  tcLipid({this.myObject});
  @override
  _tcLipidState createState() => _tcLipidState();
}
class _tcLipidState extends State<tcLipid> {
  int index = 1;

  late String tc;
  late String year;
   TooltipBehavior? _tooltip;
 


 @override
  void initState() {
    super.initState();
    initial();
  }

  late SharedPreferences logindata;

  
  final List<ChartData> chartData = [];
  final List<ChartData> chartData1 = [];




  void initial() async {
    logindata = await SharedPreferences.getInstance();

    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("lipidreport")
        .where("ic", isEqualTo: logindata.getString('ic').toString())
     
        .get();

    //double bmi1 = double.parse((snap.docs[0]['bmi']).toStringAsFixed(2));

    var now = DateTime.now();
    var formatterDate = DateFormat('dd/MM/yyyy');
    String actualDate = formatterDate.format(now);

  

    double cal = 0;
    double dur=0;
    int size = snap.size;
    int year;
    double tc;
    double temp = 0.0;
    String tempYear='';
    double tempCalcPercent=0.0;
    double tempCalcPer=0.0;
    double percents1 =0.0;
    String calPer='';
    for (int i = 0; i < size; i++) {
      temp = snap.docs[i]['tc'];
      tempYear = snap.docs[i]['date'];
      tc = temp;
      year = int.parse(tempYear.substring(6));


      chartData.add(ChartData(year,tc));
      
    }
     
    chartData.sort((a, b) => a.x.compareTo(b.x));
 
  
    
     _tooltip = TooltipBehavior(enable: true);

    setState(() {
  
      
    });
  }




@override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.3, 1],
          colors: [Color(0xffff4000),Color(0xffffcc66),]
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
                child: Container(
               
                    child:  SfCartesianChart(
                      
                      backgroundColor: Colors.white,
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 0, maximum: 10, interval: 0.5),
            tooltipBehavior: _tooltip,
            series: <ChartSeries<ChartData, int>>[
              ColumnSeries<ChartData, int>(
                
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  name: 'TC',
                  color: Color.fromRGBO(8, 142, 255, 1),
                  dataLabelSettings: DataLabelSettings(isVisible: true,textStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)))
            ])
                )
            ),
             SizedBox(height: 10),
          Text(
            "Total Cholesterol",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.bold
            )
          ),
           SizedBox(height: 10),
          Container(
          
            decoration:BoxDecoration(
                                      color: Color.fromARGB(255, 214, 214, 214),
                                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.all(15),
                    child:  Column(
                              children:  [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    '*Information*',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
              padding: EdgeInsets.all(1.0),
              child: Column(
                children: <Widget>[
                   Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Low Risk',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ),
                   LinearPercentIndicator(
                    width: 150.0,
                  
                    center: Text('< 5.2',style: TextStyle(fontSize: 15),),
                    lineHeight: 20.0,
                    percent: 0.2,
                    progressColor: Color.fromARGB(255, 54, 244, 86),
                  ),
                  SizedBox(
                                  height: 10,
                                ),
                                 Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Intermediate Risk',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ),
                 LinearPercentIndicator(
                  
                    center: Text('> 5.20 && <= 6.2',style: TextStyle(fontSize: 15),),
                   width: 150.0,
                    lineHeight: 20.0,
                    percent: 0.5,
                    progressColor: Colors.orange,
                  ),
                   SizedBox(
                                  height: 10,
                                ),
                                 Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'High Risk',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ),
                   LinearPercentIndicator(
                     center: Text('> 6.2',style: TextStyle(fontSize: 15),),
                    width: 150.0,
                    lineHeight: 20.0,
                    percent: 0.9,
                    progressColor: Color.fromARGB(255, 243, 33, 33),
                  )
                ],
              ),
            ),
                                ),
                                
                               
                               
                                
                              ],
                            ),
                )
          
        ],
      ),
    );
  }
}
 class ChartData {
        ChartData(this.x, this.y);
        final int x;
        final double y;
    }