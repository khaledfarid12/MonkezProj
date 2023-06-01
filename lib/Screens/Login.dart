import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/Constants/Dimensions.dart';
import 'SignUp.dart';
import 'UserService.dart';
import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    height: MyDim.myHeight(context) * 0.26,
                    child: Image.asset(
                      'Assets/images/triangle.png',
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: MyDim.paddingUnit * 1,
                      right: MyDim.paddingUnit * 2),
                  child: Container(
                    width: MyDim.myWidth(context) * 0.25,
                    height: MyDim.myHeight(context) * 0.10,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('Assets/images/logo.png')),
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
                    fontSize: MyDim.fontSizeLarge, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              indent: MyDim.myWidth(context) * 0.25,
              endIndent: 100,
              thickness: 3,
              color: Color(0xFF00CDD0),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 350,
              width: 300,
              decoration: BoxDecoration(
                color: Color(0xFF00CDD0).withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF00CDD0).withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 20,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  //Username
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 25.0, right: 10.0, left: 10.0),
                    child: SizedBox(
                      height: 200.0,
                      width: 300.0,
                      child: TextFormField(
                        controller: _emailController,
                        style: TextStyle(fontSize: 20.0),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        top: 120.0, right: 10.0, left: 10.0),
                    child: SizedBox(
                      width: 300.0,
                      child: TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        obscureText: _isObscure,
                        style: TextStyle(fontSize: 20.0),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              }),
                          // suffixIcon: Icon(Icons.remove_red_eye,color: Colors.black,),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 210, left: 30),
                    child: GestureDetector(
                      child: Text(
                        'Forget password ?',
                        style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            color: Colors.black),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 195),
                    child: Center(
                      child: Container(
                        width: MyDim.myWidth(context) * 0.4,
                        decoration: BoxDecoration(
                            color: Color(0xFF00CDD0),
                            borderRadius: BorderRadius.circular(30)),
                        child: TextButton(
                          onPressed: _isLoading ? null : _login,
                          child: _isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 315),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Have no account ?/'),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()));
                              });
                            },
                            child: Text('Sign up',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                )))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
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
        print(userCredential);
        final uid = userCredential.user!.uid;
        // Retrieve the updated user data
        final user = await UserService.getUserData(uid);
        if (user == null) {
          print('Error retrieving user data');
          // Handle the error here, such as displaying a message to the user
          return;
        }

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => MainScreen(user: user, uid: uid)),
          (route) => false,
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
                  'Wrong email !',
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
