import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/admin/adminmain.dart';
import 'package:colipid/pages/patientlist_model.dart';
import 'package:colipid/pages/user_model.dart';
import 'package:colipid/pages/user/userhome_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_similarity/string_similarity.dart';

import 'adminaddstaff_page.dart';
import 'adminprofile_page.dart';
import 'adminregisterpatient_page.dart';
import 'adminpatientmenu_page.dart';
import 'dialogs.dart';

class AdminHomePageScreen extends StatefulWidget {
  const AdminHomePageScreen({Key? key}) : super(key: key);

  @override
  _AdminHomePageScreenState createState() => _AdminHomePageScreenState();
}

class _AdminHomePageScreenState extends State<AdminHomePageScreen> {
  bool tappedYes = false;
  double testtext = 0;

  final checkic = TextEditingController();
  // DatabaseReference reference = FirebaseDatabase.instance.reference().child('listpatient');
  final screens = [
    AdminAddStaff(),
    AdminHomePageScreen(),
    AdminProfile(),
  ];

  late SharedPreferences logindata;
  late String ic;
  late String test;

  @override
  void initState() {
    test = "test";
    initial();
    super.initState();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      ic = logindata.getString('ic').toString();
      test = ic;
    });
  }

  final formKey = new GlobalKey<FormState>();
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      final ic = checkic.text;
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("users")
          .where("ic", isEqualTo: ic)
          .get();

      final usertype = snap.docs[0]['usertype'].toString();
      if (usertype == 'patient') {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => UserHomePage()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Only registered patient")));
      }

      //context.read<AuthService>().login(snap.docs[18]['phone']);
      //FirebaseUser user = await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  Future addListPatient(PatientListModel user) async {
    //reference document
    final docPatient =
        FirebaseFirestore.instance.collection('listpatient').doc();
    user.id = docPatient.id;
    final json = user.toJson();
    await docPatient.set(json);
  }

  Widget buildDataInfo() {
    return Table(
      children: [
        TableRow(children: [
          Container(
              height: 90,
              color: Colors.white,
              child: Center(
                  child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: testtext.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      )),
                  TextSpan(
                      text: '\n' + 'Unverified ' + '\n' + 'Patients ',
                      style: TextStyle(color: Colors.grey))
                ]),
              ))),
          TableCell(
            child: Container(
                height: 90,
                color: Colors.white,
                child: Center(
                    child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: '123',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        )),
                    TextSpan(
                        text: '\n' + 'Verified' + '\n' + 'Patients ',
                        style: TextStyle(color: Colors.grey))
                  ]),
                ))),
          ),
          TableCell(
            child: Container(
                height: 90,
                color: Colors.white,
                child: Center(
                    child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: '123',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        )),
                    TextSpan(
                        text: '\n' + 'Total' + '\n' + 'Patients ',
                        style: TextStyle(color: Colors.grey))
                  ]),
                ))),
          ),
        ])
      ],
    );
  }

  Widget buildRegBtn() {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          RegPatient();
        },
        child: Text(
          'REGISTER PATIENT',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'User ID',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: const TextField(
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.people, color: Color(0x663e97a9)),
                hintText: 'Insert User ID',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildLogInfo() {
    return Table(
      children: [
        TableRow(children: [
          Container(
              height: 90,
              color: Colors.white,
              child: Center(
                  child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: '123',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      )),
                  TextSpan(
                      text: '\n' + 'Log in Today ',
                      style: TextStyle(color: Colors.grey))
                ]),
              ))),
        ])
      ],
    );
  }

  DataTable buildListPatient(PatientListModel user) {
    return DataTable(columns: [
      DataColumn(
          label: Text("No.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.start),
          numeric: false,
          tooltip: "This is fullname"),
      DataColumn(
          label: Text("ID",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.end),
          numeric: false,
          tooltip: "This is age"),
      DataColumn(
        label: Text("",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.end),
        numeric: false,
        tooltip: "This is action",
      ),
    ], rows: [
      DataRow(cells: [
        DataCell(
          Text("1", style: TextStyle(fontSize: 20)),
          onTap: () {
            print('Selected 1');
          },
        ),
        DataCell(
          Text("980326116086", style: TextStyle(fontSize: 20)),
        ),
        DataCell(Container(
          child: ElevatedButton(
            child: Text('ACTION'),
            onPressed: () {
              openDialog(user);
            },
          ),
        )),
      ]),
    ]);
  }

  Future openDialog(PatientListModel e) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Manage Patient'),
                  ),
                  SizedBox(
                    width: 320.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                AdminUpdatePatient(myObject: e.ic)));
                      },
                      child: Text(
                        "Menu",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 320.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        final action = await Dialogs.yesAbortDialog(
                            context,
                            'Confirm Done Session for ' + e.fullname,
                            'Are you sure?');
                        if (action == DialogAction.yes) {
                          FirebaseFirestore.instance
                              .collection("listpatient")
                              .doc(e.id)
                              .delete()
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Patient succesful deleted from the list")));
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => AdminMainScreen()));
                          });
                        }
                      },
                      child: Text(
                        "Done Session",
                        style: TextStyle(color: Colors.white),
                      ),
                      //color: Colors.red[400],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });

  Future RegPatient() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'REGISTER PATIENT',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: 320.0,
                    child: new Form(
                        key: formKey,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 20),
                          decoration: InputDecoration(
                            prefix: Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(''),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14, left: 1),
                            hintText: 'Insert IC patient',
                            hintStyle: TextStyle(color: Colors.black38),
                          ),
                          maxLength: 12,
                          controller: checkic,
                          validator: (value) =>
                              value!.isEmpty ? 'Field cannot be empty' : null,
                        )),
                  ),
                  SizedBox(
                    width: 320.0,
                    child: RaisedButton(
                      onPressed: () async {
                        final checkIC = checkic.text;
                        //final user = UserModel(ic: checkIC);
                        //checkPatient(user);
                        QuerySnapshot snap = await FirebaseFirestore.instance
                            .collection("users")
                            .where("ic", isEqualTo: checkIC)
                            .get();

                        if (snap.size > 0) {
                          //exists
                          final fullname = snap.docs[0]['fullname'].toString();
                          final phone = snap.docs[0]['phone'].toString();
                          final ic = snap.docs[0]['ic'].toString();

                          final user = PatientListModel(
                              fullname: fullname, phone: phone, ic: ic);

                          regPatient(user);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Patient succesful added to the list")));
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => AdminMainScreen()));
                        } else {
                          //not exists
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Patient not registered yet")));
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AdminRegisterPatient(myObject: checkIC)));
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.red[400],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });

  /*Widget checkPat() {
    return Flexible(
        child: StreamBuilder(
      stream: Firestore.instance
          .collection('users')
          .where('ic', isGreaterThanOrEqualTo: filter.toLowerCase())
          .limit(1)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData){
          return new Column(
            children: <Widget>[
              new Card(
                elevation: 5.0,
                child: Text(''),
              )
            ],
          )
        }
      },
    ));
  }*/

  Stream<List<PatientListModel>> readUsers() => FirebaseFirestore.instance
      .collection('listpatient')
      .orderBy('time', descending: false)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => PatientListModel.fromJson(doc.data()))
          .toList());

  @override
  int index = 1;

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
                  Color(0x66C4A195),
                  Color(0x99C4A195),
                  Color(0xccC4A195),
                  Color(0xffC4A195),
                ],
              )),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Admin Homepage',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'List of Patient-In-Waiting',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    buildRegBtn(),
                    SizedBox(
                      height: 500,
                      child: StreamBuilder<List<PatientListModel>>(
                          stream: readUsers(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(
                                  'Something went wrong!: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final users = snapshot.data!;

                              return ListView(
                                  children: users.map(buildUser).toList());
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

  Widget buildUser(PatientListModel e) => Card(
      elevation: 5,
      child: ListTile(
        title: Text(e.ic),
        subtitle: Text(e.fullname),
        trailing: IconButton(
            icon: Icon(Icons.manage_accounts),
            onPressed: () {
              openDialog(e);
            }),
      ));

  Future checkPatient(UserModel user) async {
    final docPatient = FirebaseFirestore.instance.collection('users').doc();
    user.id = docPatient.id;
    final json = user.toJson();
    await docPatient.set(json);
  }

  Future regPatient(PatientListModel user) async {
    //reference document
    final docPatient =
        FirebaseFirestore.instance.collection('listpatient').doc();
    var now = DateTime.now();
    var formatterDate = DateFormat('dd/MM/yy');
    var formatterTime = DateFormat('hh:mm:ss');
    String actualDate = formatterDate.format(now);
    String actualTime = formatterTime.format(now);
    user.date = actualDate;
    user.time = actualTime;
    user.id = docPatient.id;
    final json = user.toJson();
    await docPatient.set(json);
  }
}
