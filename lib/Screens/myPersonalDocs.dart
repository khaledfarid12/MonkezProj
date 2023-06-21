import 'dart:typed_data';
import 'package:gradproj/Constants/buildCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/Screens/EditProfile.dart';
import 'package:intl/intl.dart';
import '../models/User.dart';
import 'CategoriesSetUp2.dart';
import 'package:gradproj/Constants/Dimensions.dart';
import 'ContactUs.dart';
import 'NearestBuilding.dart';
import 'ServiceNeeds.dart';
import 'SetupProfile3.dart';
import 'SignUp.dart';
import 'profile.dart';
import 'welcome_page.dart';
import 'Guidance.dart';
import 'travelScan.dart';
import 'uploadDocument.dart';

class MyPersonalDocs extends StatefulWidget {
  final String uid;
  final User user;
  const MyPersonalDocs({Key? key, required this.uid, required this.user})
      : super(key: key);

  @override
  State<MyPersonalDocs> createState() => _MyPersonalDocsState();
}

class _MyPersonalDocsState extends State<MyPersonalDocs> {
  String? _downloadUrl;

  @override
  void initState() {
    super.initState();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCard(labelText: 'National ID', uid: widget.uid),
                buildCard(labelText: 'Passport', uid: widget.uid),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.cyan[400]),
              width: 180,
              height: 65,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CategoriesSetUp2(uid: widget.uid, user: widget.user),
                    ),
                  );
                },
                child: Text(
                  'Upload more',
                  style: TextStyle(
                      color: Colors.white, fontSize: MyDim.fontSizeButtons),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
