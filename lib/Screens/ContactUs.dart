import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:monkez/NearestBuilding.dart';
// import 'package:monkez/ServiceNeeds.dart';
// import 'package:monkez/SetUpProfile3.dart';
// import 'package:monkez/UserProfile.dart';
// import 'package:monkez/WelcomePage.dart';
// import 'package:monkez/guidance.dart';
// import 'package:monkez/home.dart';
// import 'package:monkez/travelScan.dart';
import '../Constants/Dimensions.dart';

class ContactUS extends StatefulWidget {
  final String uid;
  const ContactUS({Key? key, required this.uid}) : super(key: key);

  @override
  State<ContactUS> createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
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
          title: Text('Thank you for submitting!'),
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
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.uid)
                    .update({
                  //'fullNameOfFeedback': _nameController.text,
                  //'emailOfFeedback': _emailController.text,
                  'phoneOfFeedback': _phoneController.text,
                  'Feedbacks': FieldValue.arrayUnion([_messageController.text]),
                  'rating': _initialRating,
                });

                Navigator.of(context).pop(); // Close rating popup
                // Close feedback screen
                _messageController.clear();
              },
              child: Center(
                child: Text('Done'),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new Drawer(),
      appBar: new AppBar(
        backgroundColor: Color(0xFF00CDD0),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
            size: MyDim.fontSizebetween,
          ),
        ),
      ),
      // endDrawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       DrawerHeader(
      //         child:Image(
      //           image: ResizeImage(
      //               AssetImage('Assets/images/blackLogo.png'),
      //               width: 1000,
      //               height: 800),),
      //         // child: Text('Monkez',style: TextStyle(fontSize: MyDim.fontSizebetween, fontWeight: FontWeight.w700),),
      //         decoration: BoxDecoration(
      //           // image: 'Assets/images/logoblack.png',
      //           color: Colors.black,
      //         ),
      //       ),
      //       ListTile(
      //         title: Text('Family Community', style: TextStyle(
      //           fontSize: 18.0,
      //           fontWeight: FontWeight.bold,
      //         ),),
      //         onTap: () {
      //           Navigator.pop(context); // Close the drawer
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => userprofile()));
      //         },
      //       ),
      //       ListTile(
      //         title: Text('Service Needs' , style: TextStyle(
      //           fontSize: 18.0,
      //           fontWeight: FontWeight.bold,
      //         ),),
      //         onTap: () {
      //           Navigator.pop(context); // Close the drawer
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceNeeds()));
      //         },
      //       ),
      //       ListTile(
      //         title: Text('Travel Guide' , style: TextStyle(
      //           fontSize: 18.0,
      //           fontWeight: FontWeight.bold,
      //         ),),
      //         onTap: () {
      //           Navigator.pop(context); // Close the drawer
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => TravelGuide()));
      //         },
      //       ),
      //
      //       ListTile(
      //         title: Text('Nearest Building' , style: TextStyle(
      //           fontSize: 18.0,
      //           fontWeight: FontWeight.bold,
      //         ),),
      //         onTap: () {
      //           Navigator.pop(context); // Close the drawer
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => NearestBuilding()));
      //         }, ),
      //       ListTile(
      //         title: Text('Guidance' , style: TextStyle(
      //           fontSize: 18.0,
      //           fontWeight: FontWeight.bold,
      //         ),),
      //         onTap: () {
      //           Navigator.pop(context); // Close the drawer
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => Guidance()));
      //         }, ),
      //       ListTile(
      //         title: Text('Edit Profile' , style: TextStyle(
      //           fontSize: 18.0,
      //           fontWeight: FontWeight.bold,
      //         ),),
      //         onTap: () {
      //           Navigator.pop(context); // Close the drawer
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => SetupProfile3()));
      //         }, ),
      //       ListTile(
      //         title: Text('Logout' , style: TextStyle(
      //           fontSize: 18.0,
      //           fontWeight: FontWeight.bold,
      //         ),),
      //         onTap: () {
      //           Navigator.pop(context); // Close the drawer
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage()));
      //         }, ),
      //     ],
      //   ),
      // ),

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: MyDim.fontSizebetween),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MyDim.SizedBoxtiny * 8,
                    ),
                    Container(
                      height: MyDim.fontSizeButtons * 3,
                      width: MyDim.fontSizeButtons * 3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('Assets/images/img_16.png'),
                      )),
                    ),
                    Text('\u{00A0}'),
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
                SizedBox(
                  height: MyDim.SizedBoxsmall * 3.0,
                ),
                SizedBox(
                  height: MyDim.SizedBoxsmall * 3.0,
                ),
                SizedBox(
                  width: 370.0,
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
                    style: TextStyle(fontSize: 20.0),
                    decoration: InputDecoration(
                      errorText: _errorMessage,
                      suffixIcon: Icon(
                        Icons.call,
                        color: Colors.black,
                      ),
                      labelText: 'Phone',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MyDim.SizedBoxsmall * 3.0,
                ),
                SizedBox(
                  width: 370.0,
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
                    maxLines: 3,
                    style: TextStyle(fontSize: 20.0),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(16.0, 40, 16.0, 8.0),
                      labelText: '   Leave Your Message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MyDim.SizedBoxsmall * 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFF00CDD0)),
                  width: 180.0,
                  height: 70.0,
                  child: TextButton(
                    onPressed: _submitFeedback,
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
