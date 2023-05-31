import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gradproj/Screens/profile.dart';
import 'UserService.dart';
import 'signup_form_widgets.dart';
import 'home_screen.dart';
import '../Constants/Dimensions.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                        height: MyDim.myHeight(context) * 0.26,
                        child: Image.asset(
                          'Assets/images/img_3.png',
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: MyDim.paddingUnit * 2,
                          right: MyDim.paddingUnit * 3),
                      child: Container(
                        width: MyDim.myWidth(context) * 0.30,
                        height: MyDim.myHeight(context) * 0.20,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('Assets/images/img_1.png')),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    'Login ',
                    style: TextStyle(
                        fontSize: MyDim.fontSizeLarge,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  indent: MyDim.myWidth(context) * 0.25,
                  endIndent: 100,
                  thickness: 5,
                  color: Colors.cyan,
                ),
                SizedBox(height: 40),
                Container(
                  height: 350,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.cyan.withOpacity(0.1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyan.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 20,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: 20,
                        left: 30,
                        child: Text(
                          'Email',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 10,
                        right: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 300,
                              height: 55,
                              margin: EdgeInsets.only(bottom: 30),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, top: 5, right: 10),
                                child: TextFormField(
                                  autocorrect: false,
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  enableSuggestions: false,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white70,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                textAlign: TextAlign.start,
                                'Password',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Container(
                              width: 300,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, top: 5, right: 10),
                                child: TextFormField(
                                  autocorrect: false,
                                  controller: _passwordController,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  enableSuggestions: false,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: Icon(Icons.remove_red_eye),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white70,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       bottom: 3, top: 10, left: 10),
                            //   child: GestureDetector(
                            //     child: Text(
                            //       'Forget password ?',
                            //       style: TextStyle(
                            //           fontSize: 14,
                            //           decoration: TextDecoration.underline,
                            //           color: Colors.black),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(
                                width: MyDim.myWidth(context) * 0.4,
                                decoration: BoxDecoration(
                                    color: Colors.cyan[400],
                                    borderRadius: BorderRadius.circular(30)),
                                child: TextButton(
                                  onPressed: _isLoading ? null : _login,
                                  child: _isLoading
                                      ? CircularProgressIndicator()
                                      : Text('Login',
                                          style: TextStyle(
                                              fontSize: MyDim.fontSizeMedium,
                                              color: Colors.white)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Don\'t have an account?  '),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ),
                Center(
                  child: Text(
                    'Copyright 2022 | All Rights Reserved | Powered by Monkez',
                    style: TextStyle(
                        fontSize: MyDim.fontSizeMedium, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Firebase.initializeApp();
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        final uid = userCredential.user!.uid;
        final user = await UserService.getUserData(uid);
        if (user == null) {
          print('Error retrieving user data');
          // Handle the error here, such as displaying a message to the user
          return;
        }
        print(userCredential);
        Future<Uint8List> getImageData() async {
          //await widget.uploadInfo();

          String imagePath = await FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            return documentSnapshot.get('imagePath') as String;
          });

          Uint8List? imageData =
              await FirebaseStorage.instance.ref(imagePath).getData();

          if (imageData != null) {
            return imageData;
          } else {
            throw Exception('Failed to load image');
          }
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => userprofile(
              uid: uid,
              user: user,
              getImageData: getImageData,
              //uploadInfo: uploadinfo,
            ),
          ),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
        });
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.white,
                content: Text(
                  'No user found for that email.',
                  style: TextStyle(color: Colors.red),
                )),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.white,
                content: Text(
                  'Wrong password provided for that user.',
                  style: TextStyle(color: Colors.red),
                )),
          );
        }
      }
    }
  }
}
