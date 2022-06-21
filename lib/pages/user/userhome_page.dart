import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../admin/dialogs.dart';
import 'choosemeal_page.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int index = 2;

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
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Meal'),
                    ),
                    SizedBox(
                      width: 300.0,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () async {
                          String word = "1500kcal";
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => ChooseMeal(
                                        myObject: word,
                                      )));
                        },
                        child: Text(
                          "1500 Kcal",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: Colors.blue[400],
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 300.0,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () async {
                          String word = "1800kcal";
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => ChooseMeal(
                                        myObject: word,
                                      )));
                        },
                        child: Text(
                          "1800 Kcal",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: Colors.blue[400],
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 300.0,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () async {
                          String word = "2000kcal";
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => ChooseMeal(
                                        myObject: word,
                                      )));
                        },
                        child: Text(
                          "2000 Kcal",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: Colors.blue[400],
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Meal'),
                    ),
                    SizedBox(
                      width: 300.0,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () async {
                          String word = '1500kcal';
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChooseMeal(myObject: word)));
                        },
                        child: Text(
                          "1500 Kcal",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: Colors.blue[400],
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 300.0,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () async {
                          String word = "1800kcal";
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChooseMeal(myObject: word)));
                        },
                        child: Text(
                          "1800 Kcal",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: Colors.blue[400],
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 300.0,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () async {
                          final word = '2000kcal';
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChooseMeal(myObject: word)));
                        },
                        child: Text(
                          "2000 Kcal",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: Colors.blue[400],
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
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 200,
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50)),
                        color: Color(0xff3e97a9),
                      ),
                      child: Stack(children: [
                        Positioned(
                            top: 10,
                            left: 10,
                            right: 10,
                            child: Container(
                              height: 180,
                              width: 300,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 58, 178, 202),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50),
                                    bottomRight: Radius.circular(50),
                                    bottomLeft: Radius.circular(50),
                                  )),
                            )),
                        Positioned(
                            top: 30,
                            left: 40,
                            child: Text(
                              "Profile\n" + "Hello" + "\ntesting",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                      ]),
                    ),
                    SizedBox(height: 30),
                    Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text('Meal'),
                          subtitle: Text('Calories Needed:'),
                          trailing: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                openDialogMenu();
                              }),
                        )),
                    SizedBox(height: 15),
                    Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text('Exercise'),
                          subtitle: Text('Total Calories Burnt:'),
                          trailing: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                openDialogExercise();
                              }),
                        )),
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
