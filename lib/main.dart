import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/Screens/SetupProfile3.dart';
import 'package:gradproj/Screens/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:gradproj/Screens/SplashScreen.dart';
import 'package:gradproj/Screens/ContactUs.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
  tz.initializeTimeZones();

  // Get the local time zone
  late final tz.Location _local;
  try {
    _local = tz.local;
  } catch (error) {
    print('Error getting local time zone: $error');
    return;
  }

  // Use the local time zone
  final now = tz.TZDateTime.now(_local);
  print('The current time is: $now');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SplashScreen(),
      theme: ThemeData(fontFamily: 'flu', primarySwatch: Colors.cyan),
    );
  }
}
