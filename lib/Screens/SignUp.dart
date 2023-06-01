import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'SetUpProfile1.dart';
import 'SetupProfile3.dart';
import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Constants/Dimensions.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _passwordVisible = false;
  bool _isObscure = true;
  String? _errorMessage;
  @override
  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
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

  Widget build(BuildContext context) {
    return Scaffold(
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
                            'Assets/images/triangle.png',
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
                  SizedBox(
                    height: 10.0,
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
                    height: 30.0,
                  ),

                  //first name
                  SizedBox(
                    width: 370.0,
                    child: TextFormField(
                      controller: _firstNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 20.0),
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  //Last name
                  SizedBox(
                    width: 370.0,
                    child: TextFormField(
                      controller: _lastNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 20.0),
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  //Username
                  SizedBox(
                    width: 370.0,
                    child: TextFormField(
                      controller: _usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 20.0),
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  //Email
                  SizedBox(
                    width: 370.0,
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }

                        return null;
                      },
                      style: TextStyle(fontSize: 20.0),
                      decoration: InputDecoration(
                        suffixIcon: Opacity(
                          opacity: 0.5,
                          child: Icon(
                            Icons.alternate_email_rounded,
                            color: Colors.black,
                          ),
                        ),
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  //National ID
                  SizedBox(
                    width: 370.0,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your National ID';
                        }
                        if (value.length != 14) {
                          return 'National ID Must be 14 number';
                        }
                        return null;
                      },
                      maxLength: 14,
                      controller: _nationalIdController,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(fontSize: 20.0),
                      decoration: InputDecoration(
                        labelText: 'National ID',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  //Passwrord
                  SizedBox(
                    width: 370.0,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      controller: _passwordController,
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

                  SizedBox(
                    height: 30.0,
                  ),

                  //Confirm Password
                  SizedBox(
                    width: 370.0,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      controller: _confirmPasswordController,
                      obscureText: _isObscure,
                      // keyboardType: TextInputType.visiblePassword,
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

                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFF00CDD0),
                    ),
                    width: MyDim.myWidth(context) * 0.4,
                    child: TextButton(
                      onPressed: _isLoading ? null : _register,
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              'Sign up',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: MyDim.SizedBoxtiny * 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      GestureDetector(
                        child: Text(
                          'Login  ',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          });
                        },
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
