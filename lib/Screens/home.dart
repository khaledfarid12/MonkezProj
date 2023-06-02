import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/Components/Widget.dart';
import 'package:gradproj/Constants/Data.dart';
import 'package:gradproj/Screens/ContactUs.dart';
import '../models/User.dart';
import 'NearestBuilding.dart';
import 'ServiceNeeds.dart';
import 'SetUpProfile1.dart';
import 'profile.dart';
import 'Guidance.dart';
import 'travelScan.dart';
import '../Constants/Dimensions.dart';

class MainScreen extends StatefulWidget {
  final String uid;
  final User user;
  const MainScreen({Key? key, required this.uid, required this.user})
      : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00CDD0),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
            size: MyDim.fontSizebetween,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => userprofile(
                      user: widget.user,
                      uid: widget.uid,
                      getImageData: getImageData,
                    ),
                  ),
                );
              });
            },
            icon: Icon(
              Icons.person,
              color: Colors.white,
              size: MyDim.fontSizebetween,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MyDim.paddingUnit * 2,
            ),
            Center(
              child: Container(
                  width: MyDim.myWidth(context) * 0.50,
                  child: Image.asset('Assets/images/logo.png')),
            ),
            Divider(
              color: Colors.black,
              thickness: 0.8,
              endIndent: MyDim.paddingUnit * 3,
              indent: MyDim.paddingUnit * 3,
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => userprofile(
                                    user: widget.user,
                                    uid: widget.uid,
                                    getImageData: getImageData,
                                  ),
                                ),
                              );
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color(0xFF00CDD0),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image(
                                    image: ResizeImage(
                                        AssetImage('Assets/images/family.png'),
                                        width: 50,
                                        height: 50),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, left: 25),
                                  child: Text(
                                    '   Family Community',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Guidance(
                                          user: widget.user, uid: widget.uid)));
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color(0xFF00CDD0),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image(
                                    image: ResizeImage(
                                        AssetImage(
                                            'Assets/images/guidance.png'),
                                        width: 50,
                                        height: 60),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    'Guidance',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContactUS(
                                          uid: widget.uid, user: widget.user)));
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color(0xFF00CDD0),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Image(
                                    image: ResizeImage(
                                        AssetImage(
                                            'Assets/images/ContactUs.png'),
                                        width: 50,
                                        height: 50),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Contact us',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ServiceNeeds(
                                          user: widget.user, uid: widget.uid)));
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color(0xFF00CDD0),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image(
                                    image: ResizeImage(
                                        AssetImage(
                                            'Assets/images/ServiceNeeds.png'),
                                        width: 50,
                                        height: 50),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Center(
                                  child: Text(
                                    'Service Needs',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TravelGuide(
                                          user: widget.user, uid: widget.uid)));
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color(0xFF00CDD0),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image(
                                    image: ResizeImage(
                                        AssetImage(
                                            'Assets/images/TravelGuide.png'),
                                        width: 50,
                                        height: 50),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Center(
                                  child: Text(
                                    'Travel Guide',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NearestBuilding(
                                          user: widget.user, uid: widget.uid)));
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color(0xFF00CDD0),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image(
                                    image: ResizeImage(
                                        AssetImage(
                                            'Assets/images/NearestBuilding.png'),
                                        width: 50,
                                        height: 50),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Nearest \nBuilding',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
