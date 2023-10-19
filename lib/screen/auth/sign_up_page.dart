import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../helpers/colors.dart';
import '../../main.dart';
import '../start_page/start_page_view.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController user_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
bool circularrun =false;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          key: _key,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            automaticallyImplyLeading: false,
          ),
          body: Container(
            padding: EdgeInsets.all(16),
            child: Form(key: _formKey,
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 100,
                    child: Center(
                      child: Image.asset('asset/images/logo.png'),
                    ),
                  ),
                  buildSizedBox(25),

                  TextFormField(    validator: (val) {
                    if (val!.isEmpty) return 'هذا الحقل مطلوب';
                  },
                    controller: user_name,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Enter your first name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  buildSizedBox(15),
                  TextFormField(    validator: (val) {
                    if (val!.isEmpty) return 'هذا الحقل مطلوب';
                  },
                    controller: email,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "Enter your email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  buildSizedBox(15),
                  TextFormField(    validator: (val) {
                    if (val!.isEmpty) return 'هذا الحقل مطلوب';
                  },
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Enter a password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  buildSizedBox(25),
                  MaterialButton(
                    onPressed: () async {
    if (_formKey.currentState!.validate()) {
    setState(() {
      circularrun=true;
    });

    try {
                        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        ).then((value)  {
                        mybox!.put('key',0);
                            Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => StartPageView(),
                          ),
                        );
                        });
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      } circularrun=false;
                    }},
                    height: 55,
                    shape: StadiumBorder(),
                    color: brandingColor,
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  buildSizedBox(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("Already have an account ? "),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                          //  Navigator.pushNamed(context, signInRoute);
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Theme
                              .of(context)
                              .primaryColor),
                        ),
                      )
                    ],
                  ),circularrun==false?Text(''):Center(child: CircularProgressIndicator())
                ],
              ),
            ),
          )),
    );
  }

  SizedBox buildSizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }
}
