import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gradproj/Constants/designConstants.dart';
import 'package:gradproj/Constants/new_constrants2.dart';
import 'package:gradproj/Screens/ContactUs.dart';
import 'package:gradproj/Screens/EditProfile.dart';
import '../models/User.dart';
import 'ServiceNeeds.dart';
import 'SetupProfile3.dart';
import 'package:gradproj/Screens/profile.dart';
import 'welcome_page.dart';
import 'Guidance.dart';
import 'home.dart';
import 'travelScan.dart';
import '../Constants/Dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../Constants/new_constrants.dart';

class NearestBuilding extends StatefulWidget {
  final String uid;
  final User user;
  const NearestBuilding({Key? key, required this.uid, required this.user})
      : super(key: key);

  @override
  State<NearestBuilding> createState() => _NearestBuildingState();
}

class _NearestBuildingState extends State<NearestBuilding> {
  Future<Uint8List> getImageData() async {
    //await widget.uploadInfo();

    String imagePath = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
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

  late Object _value;

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
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image(
                image: ResizeImage(AssetImage('Assets/images/blackLogo.png'),
                    width: 1000, height: 800),
              ),
              // child: Text('Monkez',style: TextStyle(fontSize: MyDim.fontSizebetween, fontWeight: FontWeight.w700),),
              decoration: BoxDecoration(
                // image: 'Assets/images/logoblack.png',
                color: Colors.black,
              ),
            ),
            ListTile(
              title: Text(
                'Family Community',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => userprofile(
                              user: widget.user,
                              uid: widget.uid,
                              getImageData: getImageData,
                            )));
              },
            ),
            ListTile(
              title: Text(
                'Service Needs',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ServiceNeeds(user: widget.user, uid: widget.uid)));
              },
            ),
            ListTile(
              title: Text(
                'Travel Guide',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TravelGuide(user: widget.user, uid: widget.uid)));
              },
            ),
            ListTile(
              title: Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ContactUS(uid: widget.uid, user: widget.user)));
              },
            ),
            ListTile(
              title: Text(
                'Guidance',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Guidance(user: widget.user, uid: widget.uid)));
              },
            ),
            ListTile(
              title: Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfile(uid: widget.uid)));
              },
            ),
            ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return WillPopScope(
                        onWillPop: () async => false,
                        child: AlertDialog(
                          title: Text('Logout'),
                          content: Text('Are you sure you want to log out?'),
                          actions: [
                            TextButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Yes'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WelcomePage()));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                })
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MyDim.paddingUnit * 8,
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('Assets/images/info.png')),
                      ),
                    ),
                    SizedBox(
                      width: MyDim.SizedBoxtiny,
                    ),
                    Expanded(
                      child: Container(
                        // width:  MediaQuery.of(context).size.width,
                        // facingaproblemtoknowwhatisthen (0:4)
                        // constraints: BoxConstraints (
                        //   maxWidth:350,
                        // ),
                        child: Text(
                          'Facing a problem to know what is the nearest governmental building  for you?',
                          style: TextStyle(
                            fontSize: 21.5,
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                            color: Color(0xff454141),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MyDim.SizedBoxtiny,
            ),
            GestureDetector(
              child: RichText(
                  text: TextSpan(
                      text: 'Don’t worry,  ',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      children: <InlineSpan>[
                    TextSpan(
                      text: 'Monkez',
                      style: TextStyle(
                          color: Colors.cyan, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '  is here to guide you!',
                      style: TextStyle(color: Colors.black),
                    ),
                  ])),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.22,
              height: MediaQuery.of(context).size.height * 0.13,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('Assets/images/building.png'))),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text(
                "Kindly fill the following to help you out:",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                    fontSize: MyDim.fontSizeButtons * 0.9),
              ),
            ),
            SizedBox(
              height: MyDim.SizedBoxtiny,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(MyDim.radius)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: MyDim.paddingUnit * 4),
                  child: Text(
                    'Type of  governmental building ? ',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 130, top: 10),
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  width: 200,
                  child: DropdownButtonFormField<dynamic>(
                    menuMaxHeight: 350,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(width: 2, color: Colors.grey),
                      ),
                    ),
                    alignment: Alignment.center,
                    items: LocationList(),
                    onChanged: (value) {
                      setState(() {
                        _value = value!;
                      });
                    },
                    hint: Text("Traffic unit....", style: kHintTextStyle),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MyDim.SizedBoxtiny,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(MyDim.radius)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: MyDim.paddingUnit * 14),
                  child: Text(
                    'Governorate ',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 130, top: 10),
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  width: 200,
                  child: DropdownButtonFormField<dynamic>(
                    menuMaxHeight: 200,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(width: 2, color: Colors.grey),
                      ),
                    ),
                    alignment: Alignment.center,
                    items: GovernemtalList(),
                    onChanged: (value) {
                      setState(() {
                        _value = value!;
                      });
                    },
                    hint: Text("Alexandria....", style: kHintTextStyle),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
