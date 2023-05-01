import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/Screens/login_screen.dart';
import 'package:gradproj/Screens/signup_form_widgets.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('Assets/images/img.png')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*  Align(
                  alignment: Alignment.bottomCenter,
                ),*/
                Container(
                    width: 260,
                    height: 250,
                    child: Image.asset('Assets/images/img_1.png')),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Text('your life savior for your governmental needs',
                      style: TextStyle(
                          fontSize: 28, fontWeight: FontWeight.normal)),
                ),
                SizedBox(
                  height: 70,
                ),
                Container(
                    width: 190,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Colors.cyan,
                          width: 2,
                          strokeAlign: BorderSide.strokeAlignOutside),
                    ),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ))),
                SizedBox(height: 40),
                Container(
                    clipBehavior: Clip.hardEdge,
                    width: 190,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Colors.cyan,
                          width: 2,
                          strokeAlign: BorderSide.strokeAlignOutside),
                    ),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        )))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
