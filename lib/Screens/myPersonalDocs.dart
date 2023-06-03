import 'dart:typed_data';

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
    _getImageUrl();
  }

  Future<void> _getImageUrl() async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('users').doc(widget.uid);
    DocumentSnapshot documentSnapshot =
        await docRef.collection('documents').doc(widget.uid).get();

    String imagePath = documentSnapshot.get('National ID');

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(imagePath);
    String downloadUrl = await ref.getDownloadURL();

    setState(() {
      _downloadUrl = downloadUrl;
    });
  }

  Future<Uint8List> getImageData() async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('users').doc(widget.uid);

    String imagePath = await docRef
        .collection('documents')
        .doc(widget.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      return documentSnapshot.get('National ID') as String;
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
            Padding(
              padding: const EdgeInsets.only(
                  top: MyDim.paddingUnit * 1.5, left: MyDim.paddingUnit * 0.5),
              child: Row(
                children: <Widget>[
                  //National ID
                  Container(
                    width: MyDim.myWidth(context) * 0.44,
                    height: MyDim.myHeight(context) * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Color(0xFF00CDD0),
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: MyDim.paddingUnit * 1,
                          left: MyDim.paddingUnit * 0.2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              labelText: 'National ID',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: FutureBuilder<Uint8List>(
                              future: getImageData(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Image.memory(snapshot.data!);
                                }
                                // else if (snapshot.hasData == false) {
                                // //   return Image.asset(
                                // //       'Assets/images/circleAvatar.png');
                                // }
                                // else if (snapshot.hasError) {
                                //   return Text('${snapshot.error}');
                                // }
                                else {
                                  return CircularProgressIndicator();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 30.0,
                  ),

                  //Passport
                  Container(
                    width: MyDim.myWidth(context) * 0.44,
                    height: MyDim.myHeight(context) * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Color(0xFF00CDD0),
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: MyDim.paddingUnit * 0.4,
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'Assets/images/Passport.png',
                            width: MyDim.myWidth(context) * 0.3,
                            height: MyDim.myHeight(context) * 0.2,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DocumentUploadScreen2(
                                              docname: 'Passport',
                                              user: widget.user,
                                              uid: widget.uid)));
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: Colors.black,
                              size: 30.0,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Passport',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
