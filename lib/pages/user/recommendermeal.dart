import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/login_page.dart';
import 'package:colipid/pages/meal_model.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

late String prefs1 = '';
late String prefs2 = '';
late String prefs3 = '';
late String prefs4 = '';

class recommendMeal extends StatefulWidget {
  const recommendMeal(
      {Key? key,
      required title1,
      required title2,
      required title3,
      required title4})
      : super(key: key);
  final String title1 = '';
  final String title2 = '';
  final String title3 = '';
  final String title4 = '';
  // var myObject;
  // recommendMeal(@required String planname, String planname1, String planname2,
  // String planname3,
  // {this.myObject});

  @override
  _recommendMealState createState() => _recommendMealState();
}

class _recommendMealState extends State<recommendMeal> {
  int index = 1;
  String tag = '';
  List<MealModel> _users = [];

  @override
  void initState() {
    super.initState();
    fetchPlanData();
  }

  // var planname = [];

  void fetchPlanData() async {
    // do something

    prefs1 = '${widget.title1}';
    prefs2 = '${widget.title2}';
    prefs3 = '${widget.title3}';
    prefs4 = '${widget.title4}';
  }

  Widget buildUser(MealModel e) => Card(
      elevation: 5,
      child: ListTile(
        title: Text(e.plan),
        subtitle: Text(e.tag),
        trailing: IconButton(
            icon: Icon(Icons.folder),
            onPressed: () {
              //openDialog(e);
            }),
      ));

  Stream<List<MealModel>> readMeal(
          String pref1, String pref2, String pref3, String pref4) =>
      FirebaseFirestore.instance
          .collection('mealplan')
          .where('tag', isEqualTo: pref1)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => MealModel.fromJson(doc.data()))
              .toList());

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
                  Color(0x663e97a9),
                  Color(0x993e97a9),
                  Color(0xcc3e97a9),
                  Color(0xff3e97a9),
                ],
              )),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'HEllo',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                      child: Text('${widget.title1}'),
                    ),
                    SizedBox(
                        height: 5,
                        child: StreamBuilder<List<MealModel>>(
                            stream: readMeal(prefs1, prefs2, prefs3, prefs4),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    'Something went wrong!: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                final users = snapshot.data!;

                                return ListView(
                                    children: users.map(buildUser).toList());
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            })),
                    SizedBox(height: 40),
                    SizedBox(height: 20),
                    SizedBox(height: 20),
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
