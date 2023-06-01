import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/Screens/FeedbackScreen.dart';
import 'package:gradproj/Screens/SetupProfile3.dart';
import 'package:gradproj/Screens/login_screen.dart';
import 'package:gradproj/Screens/welcome_page.dart';
import 'screens/signup_form_widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:gradproj/Screens/ContactUs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: LoginScreen(),
      theme: ThemeData(fontFamily: 'flu', primarySwatch: Colors.cyan),
    );
  }
}
