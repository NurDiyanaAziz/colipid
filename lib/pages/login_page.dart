import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/user/usermain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_session/flutter_session.dart';

import '../homepage_screen.dart';
import 'admin/adminhome_page.dart';
import 'admin/adminmain.dart';
import 'otp_screen.dart';
import 'user/userhome_page.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({Key? key}) : super(key: key);

  @override
  _LoginPageScreenState createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  bool isRememberMe = false;
  final phone = TextEditingController();
  String dialCodeDigit = "+60";
  late SharedPreferences logindata;
  late bool newuser;
  late String usernow;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    usernow = logindata.getString('type').toString();
    print(newuser);
    final index = 1;
    if (newuser == false) {
      if (usernow == 'patient') {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => UserMainScreen(
                  myObject: index,
                )));
      } else if (usernow == 'admin') {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AdminMainScreen()));
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phone.dispose();

    super.dispose();
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
      final phoneno = phone.text;
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("users")
          .where("phone", isEqualTo: phoneno)
          .get();

      if (snap.size > 0) {
        final user = snap.docs[0]['usertype'].toString();
        final ic = snap.docs[0]['ic'].toString();
        logindata.setBool('login', false);
        logindata.setString('ic', ic);
        logindata.setString('type', user);
        final index = 1;
        if (user == 'patient') {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => UserMainScreen(
                    myObject: index,
                  )));
        } else if (user == 'admin') {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AdminMainScreen()));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("User Not Exist!")));
      }

      //context.read<AuthService>().login(snap.docs[18]['phone']);
      //FirebaseUser user = await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  Widget buildPhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone Number',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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
          child: new Form(
              key: formKey,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black87, fontSize: 20),
                decoration: InputDecoration(
                  prefix: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(''),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14, left: 1),
                  hintText: 'Insert Phone Number',
                  hintStyle: TextStyle(color: Colors.black38),
                ),
                maxLength: 11,
                controller: phone,
                validator: (value) =>
                    value!.isEmpty ? 'Field cannot be empty' : null,
              )),
        )
      ],
    );
  }

  Widget buildRememberMe() {
    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  isRememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: validateAndSubmit,
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
              color: Color(0xff3e97a9),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildAdminBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () async {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AdminMainScreen()));
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Text(
          'TESTING ADMIN',
          style: TextStyle(
              color: Color(0xff3e97a9),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildUserBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () async {
          final index = 1;
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => UserMainScreen(
                    myObject: index,
                  )));
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Text(
          'TESTING USER',
          style: TextStyle(
              color: Color(0xff3e97a9),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 220),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 50),
                  buildPhoneNumber(),
                  SizedBox(height: 20),
                  buildLoginBtn(),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
