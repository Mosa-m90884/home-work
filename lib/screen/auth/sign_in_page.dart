import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_work/helpers/colors.dart';
import 'package:home_work/screen/start_page/start_page_view.dart';
import 'package:provider/provider.dart';
import '../../controller/controller.dart';
import '../../main.dart';
import '../salesmanHome.dart';
import 'sign_up_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _key = GlobalKey<FormState>();
  bool circularrun=false;
  TextEditingController emailAddress = TextEditingController(text: 'mosa.m90884@gmail.com');
  TextEditingController password = TextEditingController(text: '123456');
  int inter_type = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'تسجيل الدخول',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: freeDelivery,
                elevation: 0.0,
                automaticallyImplyLeading: false,
              ),
              body: Container(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _key,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(25),
                        height: 150,
                        child: Center(
                          child: Image.asset('asset/images/logo.png'),
                        ),
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) return 'هذا الحقل مطلوب';
                        },
                        controller: emailAddress,
                        decoration: InputDecoration(
                          errorText: 'mosa.m90884@gmail.com',
                          prefixIcon: Icon(Icons.email),
                          hintText: "أدخل بريدك الإلكتروني",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) return 'هذا الحقل مطلوب';
                        },
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                          errorText: '123456',
                          prefixIcon: Icon(Icons.lock),
                          hintText: "كلمة مرور حسابك",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                      Text(
                        'نوع الدخول',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("Administrator"),
                              Radio(
                                value: 0,
                                groupValue: inter_type,
                                onChanged: (value) {
                                  setState(() {
                                    inter_type = value!;
                                  });
                                },
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("SalesPerson"),
                              Radio(
                                value: 1,
                                groupValue: inter_type,
                                onChanged: (value) {
                                  setState(() {
                                    inter_type = value!;
                                  });
                                },
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                        ],
                      ),
                      buildSizedBox(25),
                      MaterialButton(
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            setState(() {
                              circularrun=true;
                            });
                            print(inter_type);
                            try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: emailAddress.text,
                                      password: password.text)
                                  .then((value) {
                                mybox!.put('key',inter_type);

                                Provider.of<MyNotifier>(context, listen: false)
                                    .setAth_user();
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => StartPageView(),
                                        ),
                                      );
                                circularrun=false;
                              });


                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                              }
                            }
                          }
                        },
                        height: 55,
                        shape: StadiumBorder(),
                        color: Theme.of(context).primaryColor,
                        child: Center(
                          child: Text(
                            "تسجيل الدخول",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      buildSizedBox(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(" ليس لديك حساب ? "),
                          MaterialButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ),
                              );
                              // Navigator.pushNamed(context, signUpRoute);
                            },
                            child: Text(
                              "أنشأ حساب جديد",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),circularrun==false?Text(''):Center(child: CircularProgressIndicator())
                    ],
                  ),
                ),
              ))),
    );
  }

  SizedBox buildSizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }
}
