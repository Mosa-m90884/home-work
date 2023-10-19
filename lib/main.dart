import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:home_work/screen/auth/sign_in_page.dart';
import 'package:home_work/screen/start_page/start_page_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'controller/controller.dart';
import 'firebase_options.dart';
import 'helpers/colors.dart';

Box? mybox;

void main() async {
  Future<Box> openHiveBox(String boxname) async {
    if (!Hive.isBoxOpen(boxname))
      Hive.init((await getApplicationDocumentsDirectory()).path);
    return Hive.openBox(boxname);
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Provider.debugCheckInvalidValueType = null;
  mybox = await openHiveBox('key');
  if (mybox!.get('key') == null) mybox!.put('key', 2);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: MyNotifier()),
      ],
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Dosis',
            primarySwatch: brandingColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: false,
          ),
          home: FirebaseAuth.instance.currentUser == null
              ? SignInPage()
              : StartPageView(),
        ),
      ),
    );
  }

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null)
        print('==========user Sign out');
      else {
        print('==========user Sign in');
      }
    });
  }
}
