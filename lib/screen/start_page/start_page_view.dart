import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_work/screen/adminHome.dart';
import 'package:provider/provider.dart';
import '../../controller/controller.dart';
import '../../helpers/colors.dart';
import '../../helpers/dimensions_screen .dart';
import '../../main.dart';
import '../auth/sign_in_page.dart';
import '../salesmanHome.dart';

class StartPageView extends StatefulWidget {
  const StartPageView({Key? key}) : super(key: key);

  @override
  _StartPageViewState createState() => _StartPageViewState();
}

class _StartPageViewState extends State<StartPageView> {
  @override
  Widget build(BuildContext context) {
    Screendimensions().init(context);
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.transparent, elevation: 0, actions: [
        Row(
          children: [
            Text(
              'تسجيل خروج ',
              style: TextStyle(
                  color: brandingColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (FirebaseAuth.instance.currentUser == null) {
                    Provider.of<MyNotifier>(context, listen: false).auth_user =
                        '';
                    Provider.of<MyNotifier>(context, listen: false)
                        .usersList
                        .clear();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => SignInPage(),
                      ),
                    );
                  }
                },
                icon: Icon(color: brandingColor, size: 35, Icons.exit_to_app)),
          ],
        )
      ]),
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: Screendimensions.screenHeight! / 2.732,

            /// 250.0
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/images/splash1.png'),
                    fit: BoxFit.fill)),
          ),
          Positioned(
            bottom: 75,
            left: 20,
            right: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0,
                      Screendimensions.screenHeight! / 68.3,

                      /// 10.0
                      0,
                      Screendimensions.screenHeight! / 11.38

                      /// 60.0
                      ),
                  child: Column(children: [
                    Center(
                        child: Container(
                      child: Text(
                        'مرحبا',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Screendimensions.screenHeight! / 22.77,
                            fontWeight: FontWeight.bold),
                      ),

                      /// 30
                      alignment: Alignment.center,
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        mybox!.get('key') == 0
                            ? 'Administrator'
                            : 'salesPerson',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),

                      /// 30
                      alignment: Alignment.center,
                    )),
                  ]),
                ),
                MaterialButton(
                  onPressed: () {
                    print(mybox!.get('key'));
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => mybox!.get('key') == 0
                            ? HomePage()
                            : SalesManHome(),
                      ),
                    );
                  },
                  height: 55,
                  shape: StadiumBorder(),
                  color: Theme.of(context).primaryColor,
                  child: Center(
                    child: Text(
                      "الدخول الى الواجهة الأساسية",
                      style: TextStyle(color: Colors.white, fontSize: 20),
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
