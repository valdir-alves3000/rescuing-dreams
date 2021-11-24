import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:rescuing_dreams/src/pages/login_page.dart';
import 'package:rescuing_dreams/src/pages/map_page.dart';
import 'package:rescuing_dreams/src/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterConfig.loadEnvVariables();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.indigo[300],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginPage.idPage,
      routes: {
        MapPage.idPage: (context) => MapPage(),
        LoginPage.idPage: (context) => LoginPage(),
        RegisterPage.idPage: (context) => RegisterPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
