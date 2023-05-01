import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradproj/Screens/login_screen.dart';
import '../Constants/Dimensions.dart';
import 'SetupProfile3.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Registration')),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                          height: MyDim.myHeight(context) * 0.25,
                          child: Image.asset(
                            'Assets/images/img_3.png',
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MyDim.paddingUnit * 11,
                            left: MyDim.paddingUnit * 2),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: MyDim.fontSizebetween,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: MyDim.paddingUnit * 1,
                            right: MyDim.paddingUnit * 3),
                        child: Container(
                          width: MyDim.myWidth(context) * 0.25,
                          height: MyDim.myHeight(context) * 0.10,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('Assets/images/img_1.png')),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Fill out this form',
                    style: TextStyle(
                        fontSize: MyDim.fontSizeMedium,
                        color: Colors.grey[600]),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                    endIndent: MyDim.paddingUnit * 3,
                    indent: MyDim.paddingUnit * 3,
                  ),
                  SizedBox(
                    height: MyDim.SizedBoxtiny * 0.1,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: MyDim.paddingUnit * 10),
                    child: Text(
                      'First name',
                      style: TextStyle(
                          fontSize: MyDim.fontSizeMedium,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: MyDim.SizedBoxsmall * 0.1,
                  ),
                  Container(
                    width: 300,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 25.0, top: 3, right: 10),
                      child: TextFormField(
                        controller: _firstNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                        autocorrect: false,
                        enableSuggestions: false,
                        autofocus: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: MyDim.paddingUnit * 10),
                    child: Text(
                      'Last name',
                      style: TextStyle(
                          fontSize: MyDim.fontSizeMedium,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: MyDim.SizedBoxsmall * 0.8,
                  ),
                  Container(
                    width: 300,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 25.0, top: 3, right: 10),
                      child: TextFormField(
                        controller: _lastNameController,
                        autocorrect: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                        enableSuggestions: false,
                        autofocus: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: MyDim.paddingUnit * 10),
                    child: Text(
                      'User name',
                      style: TextStyle(
                          fontSize: MyDim.fontSizeMedium,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: MyDim.SizedBoxsmall * 0.8,
                  ),
                  Container(
                    width: 300,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 25.0, top: 3, right: 10),
                      child: TextFormField(
                        controller: _usernameController,
                        autocorrect: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                        enableSuggestions: false,
                        autofocus: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: MyDim.paddingUnit * 13),
                    child: Text(
                      'Email',
                      style: TextStyle(
                          fontSize: MyDim.fontSizeMedium,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: MyDim.SizedBoxsmall * 0.8,
                  ),
                  Container(
                    width: 300,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 25.0, top: 3, right: 10),
                      child: TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value!)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        enableSuggestions: false,
                        autofocus: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.alternate_email_rounded,
                            color: Colors.black,
                          ),
                          hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: MyDim.paddingUnit * 10),
                    child: Text(
                      'National ID',
                      style: TextStyle(
                          fontSize: MyDim.fontSizeMedium,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: MyDim.SizedBoxsmall * 0.8,
                  ),
                  Container(
                    width: 300,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 25.0, top: 3, right: 10),
                      child: TextFormField(
                        controller: _nationalIdController,
                        autocorrect: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your national ID';
                          }
                          return null;
                        },
                        enableSuggestions: false,
                        autofocus: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: MyDim.paddingUnit * 10),
                    child: Text(
                      'Password',
                      style: TextStyle(
                          fontSize: MyDim.fontSizeMedium,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: MyDim.SizedBoxsmall * 0.8,
                  ),
                  Container(
                    width: 300,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 25.0, top: 3, right: 10),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                        autocorrect: false,
                        enableSuggestions: false,
                        autofocus: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.black,
                          ),
                          hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: MyDim.paddingUnit * 6),
                    child: Text(
                      'Confirm Password',
                      style: TextStyle(
                          fontSize: MyDim.fontSizeButtons,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: MyDim.SizedBoxsmall * 0.8,
                  ),
                  Container(
                    width: 300,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 25.0, top: 3, right: 10),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        autocorrect: false,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please confirm your password';
                          } else if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        enableSuggestions: false,
                        autofocus: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.black,
                          ),
                          hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MyDim.SizedBoxsmall * 0.8,
                  ),
                  if (_isLoading)
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  else
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.cyan[400]),
                      width: MyDim.myWidth(context) * 0.4,
                      child: TextButton(
                        onPressed: _register,
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MyDim.fontSizeButtons),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: MyDim.SizedBoxtiny * 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          'Login  ',
                          style: TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MyDim.SizedBoxtiny * 1,
                  ),
                  SizedBox(
                    height: 15,
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
                  if (_errorMessage != null) ...[
                    SizedBox(height: 20),
                    Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final firstName = _firstNameController.text.trim();
      final lastName = _lastNameController.text.trim();
      final username = _usernameController.text.trim();
      final email = _emailController.text.trim();
      final nationalId = _nationalIdController.text.trim();
      final password = _passwordController.text.trim();

      try {
        // Check if the username is already taken
        final usernameQuerySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: username)
            .get();
        if (usernameQuerySnapshot.docs.isNotEmpty) {
          throw 'Username is already taken';
        }

        // Check if the email is already registered
        final emailQuerySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .get();
        if (emailQuerySnapshot.docs.isNotEmpty) {
          throw 'Email is already registered';
        }

        // Check if the national ID is already registered
        final nationalIdQuerySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('nationalId', isEqualTo: nationalId)
            .get();
        if (nationalIdQuerySnapshot.docs.isNotEmpty) {
          throw 'National ID is already registered';
        }

        // Register the user
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
        // Save user data to Firestore and pass UID to the next page
        final uid = userCredential.user!.uid;

        // // After successful sign up, retrieve the user UID
        // final user = FirebaseAuth.instance.currentUser;
        // final uid = user?.uid;
        // Navigate to the next page and pass the UID as a parameter

        // Save additional user data to Firestore
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'firstName': firstName,
          'lastName': lastName,
          'username': username,
          'email': email,
          'nationalId': nationalId,
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SetupProfile3(uid: uid),
          ),
        );

        //Navigator.pop(context);
      } catch (error) {
        setState(() {
          _isLoading = false;
          _errorMessage = error.toString();
        });
      }
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => SetupProfile3()));
    }
  }
}
