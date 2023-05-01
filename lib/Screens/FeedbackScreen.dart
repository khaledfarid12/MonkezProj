import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Constants/Dimensions.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  RegExp _phoneRegex = RegExp(r'^\d{11}$');
  String? _errorMessage;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  double _initialRating = 0.0;

  void _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      // Show rating popup
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Rate us'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('How would you rate our app?'),
              SizedBox(height: 16),
              RatingBar.builder(
                initialRating: _initialRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  _initialRating = rating;
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                // Save feedback to Firestore
                await FirebaseFirestore.instance.collection('users').add({
                  'name': _nameController.text,
                  'email': _emailController.text,
                  'phone': _phoneController.text,
                  'message': _messageController.text,
                  'rating': _initialRating,
                });

                Navigator.pop(context); // Close rating popup
                // Close feedback screen
                _messageController.clear();
                _nameController.clear();
                _emailController.clear();
                _phoneController.clear();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MyDim.fontSizeButtons * 3,
                    width: MyDim.fontSizeButtons * 3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('Assets/images/img_16.png'))),
                  ),
                  Text(
                    "Get in Touch",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MyDim.fontSizeButtons),
                  )
                ],
              ),
              Center(
                child: Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: MyDim.SizedBoxtiny * 3,
              ),
              Padding(
                padding: const EdgeInsets.only(right: MyDim.paddingUnit * 11),
                child: Text(
                  'Full Name',
                  style: TextStyle(
                      fontSize: MyDim.fontSizeButtons,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: MyDim.SizedBoxsmall * 0.3,
              ),
              Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 3, right: 10),
                  child: TextFormField(
                    autocorrect: false,
                    enableSuggestions: false,
                    controller: _nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
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
                padding: const EdgeInsets.only(right: MyDim.paddingUnit * 13),
                child: Text(
                  'Email',
                  style: TextStyle(
                      fontSize: MyDim.fontSizeButtons,
                      fontWeight: FontWeight.bold),
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
                  padding: const EdgeInsets.only(left: 25.0, top: 3, right: 10),
                  child: TextFormField(
                    autocorrect: false,
                    controller: _emailController,
                    enableSuggestions: false,
                    autofocus: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.alternate_email_rounded,
                        color: Colors.black,
                      ),
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
                padding: const EdgeInsets.only(right: MyDim.paddingUnit * 10),
                child: Text(
                  'Phone Number',
                  style: TextStyle(
                      fontSize: MyDim.fontSizeButtons,
                      fontWeight: FontWeight.bold),
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
                  padding: const EdgeInsets.only(left: 25.0, top: 3, right: 10),
                  child: TextFormField(
                    autocorrect: false,
                    enableSuggestions: false,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    autofocus: false,
                    onChanged: (value) {
                      setState(() {
                        if (_phoneRegex.hasMatch(value)) {
                          _errorMessage = null;
                        } else {
                          _errorMessage =
                              'Please enter a valid 11-digit phone number.';
                        }
                      });
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                      errorText: _errorMessage,
                      hintStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: MyDim.paddingUnit * 13),
                child: Text(
                  'Leave Your Message',
                  style: TextStyle(
                      fontSize: MyDim.fontSizeButtons,
                      fontWeight: FontWeight.bold),
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
                  padding: const EdgeInsets.only(left: 25.0, top: 3, right: 10),
                  child: TextFormField(
                    autocorrect: false,
                    controller: _messageController,
                    enableSuggestions: false,
                    autofocus: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your message';
                      }
                      return null;
                    },
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

              // oldddd codeeeeeeee

              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitFeedback,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Center(
                  child: Text(
                'Copyright 2022 | All Rights Reserved | Powered by Monkez',
                style: TextStyle(
                    fontSize: MyDim.fontSizeMedium, color: Colors.grey),
                textAlign: TextAlign.center,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
