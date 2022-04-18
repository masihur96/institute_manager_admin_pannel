import 'package:flutter/material.dart';
import 'package:institute_manager_admin_pannel/pages/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:institute_manager_admin_pannel/pages/login_page.dart';

import 'package:institute_manager_admin_pannel/controller/firebase_provider.dart';
import 'package:institute_manager_admin_pannel/controller/public_provider.dart';
import 'package:institute_manager_admin_pannel/pages/sidebar_view/admission_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences pref = await SharedPreferences.getInstance();
  final String? adminPhone = pref.getString('phone') ?? '';

  runApp(MyApp(adminPhone: adminPhone!));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  String adminPhone;
  MyApp({required this.adminPhone});

  Map<int, Color> color = {
    //RGB Color Code (0, 194, 162)
    50: Color.fromRGBO(188, 158, 87, .1),
    100: Color.fromRGBO(188, 158, 87, .2),
    200: Color.fromRGBO(188, 158, 87, .3),
    300: Color.fromRGBO(188, 158, 87, .4),
    400: Color.fromRGBO(188, 158, 87, .5),
    500: Color.fromRGBO(188, 158, 87, .6),
    600: Color.fromRGBO(188, 158, 87, .7),
    700: Color.fromRGBO(188, 158, 87, .8),
    800: Color.fromRGBO(188, 158, 87, .9),
    900: Color.fromRGBO(188, 158, 87, 1),
  };
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PublicProvider()),
        ChangeNotifierProvider(create: (context) => FirebaseProvider()),
      ],
      child: MaterialApp(
        title: 'Institute Manager Admin Panel',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            backgroundColor: Colors.blueGrey.shade50,
            primarySwatch: MaterialColor(0xffBC9E57, color),
            canvasColor: Colors.transparent),
        // initialRoute: Admission.id,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          MainPage.id: (context) => MainPage(),
          Admission.id: (context) => Admission(),
        },
        home: adminPhone == '' ? LoginPage() : MainPage(),
      ),
    );
  }
}
