import 'dart:typed_data';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/Screens/EditProfile.dart';
import 'package:intl/intl.dart';
import 'CategoriesSetUp2.dart';
import 'package:gradproj/Constants/Dimensions.dart';
import 'ContactUs.dart';
import 'NearestBuilding.dart';
import 'ServiceNeeds.dart';
import 'SetupProfile3.dart';
import 'profile.dart';
import 'welcome_page.dart';
import 'Guidance.dart';
import 'travelScan.dart';
import 'uploadDocument.dart';
import 'package:full_screen_image/full_screen_image.dart';

import '../models/User.dart';

class MoneyRelated extends StatefulWidget {
  final String uid;
  final User user;
  const MoneyRelated({Key? key, required this.uid, required this.user})
      : super(key: key);

  @override
  State<MoneyRelated> createState() => _MoneyRelatedState();
}

class _MoneyRelatedState extends State<MoneyRelated> {
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

  TextEditingController dateinput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new Drawer(),
      appBar: new AppBar(
        backgroundColor: Color(0xFF00CDD0),
        title: Center(
          child: Text(
            'Money Related',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
                'Nearest Building',
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
                        builder: (context) => NearestBuilding(
                            user: widget.user, uid: widget.uid)));
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
                        onWillPop: () async => true,
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
          children: [
            new Column(
              children: <Widget>[
                FutureBuilder<List<Uint8List>>(
                  future: getPersonalDocs(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error loading personal documents');
                    } else if (snapshot.hasData) {
                      List<Uint8List> personalDocs = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            for (Uint8List docData in personalDocs)
                              FullScreenWidget(
                                disposeLevel: DisposeLevel.Low,
                                child: Hero(
                                  tag: "customTag",
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image(
                                        image: MemoryImage(docData),
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: MyDim.paddingUnit * 1.5, left: MyDim.paddingUnit * 0.5),
              child: Expanded(
                child: Row(
                  children: <Widget>[
                    //Visas
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
                            bottom: MyDim.paddingUnit * 1,
                            left: MyDim.paddingUnit * 0.2),
                        child: Column(
                          children: [
                            Image.asset(
                              'Assets/images/visatst.jpeg',
                              width: MyDim.myWidth(context) * 0.35,
                              height: MyDim.myHeight(context) * 0.2,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DocumentUploadScreen2(
                                                docname: 'Bill',
                                                doctype: 'Visa',
                                                user: widget.user,
                                                uid: widget.uid)));
                              },
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Colors.black,
                                size: 30.0,
                              ),
                            ),
                            Text(
                              'Visa',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 30.0,
                    ),

                    //Bank Certificates
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
                          left: MyDim.paddingUnit * 0.2,
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              'Assets/images/bank.jpeg',
                              width: MyDim.myWidth(context) * 0.35,
                              height: MyDim.myHeight(context) * 0.2,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DocumentUploadScreen2(
                                                docname: 'Bill',
                                                doctype: 'Bank',
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
                                '      Bank\nCertificates',
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
            ),

            //second row
            Padding(
              padding: const EdgeInsets.only(
                  top: MyDim.paddingUnit * 1.5, left: MyDim.paddingUnit * 0.5),
              child: Expanded(
                  child: Row(
                children: [
                  //Money Check
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
                    child: Column(
                      children: [
                        Image.asset(
                          'Assets/images/checks.jpeg',
                          width: MyDim.myWidth(context) * 0.4,
                          height: MyDim.myHeight(context) * 0.2,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DocumentUploadScreen2(
                                        docname: 'Bill',
                                        doctype: 'Money',
                                        user: widget.user,
                                        uid: widget.uid)));
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: Colors.black,
                            size: 30.0,
                          ),
                        ),
                        Text(
                          'Money Check',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: 30.0,
                  ),

                  //Bills
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
                    child: Column(
                      children: [
                        Image.asset(
                          'Assets/images/billtst.jpeg',
                          width: MyDim.myWidth(context) * 0.3,
                          height: MyDim.myHeight(context) * 0.2,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DocumentUploadScreen2(
                                        docname: 'Bill',
                                        doctype: 'Bills',
                                        user: widget.user,
                                        uid: widget.uid)));
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: Colors.black,
                            size: 30.0,
                          ),
                        ),
                        Text(
                          'Bills',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ),

            SizedBox(
              height: 28.0,
            ),

            Padding(
              padding: const EdgeInsets.only(left: MyDim.paddingUnit * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFF00CDD0),
                      ),
                      width: MyDim.myWidth(context) * 0.4,
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoriesSetUp2(
                                          user: widget.user, uid: widget.uid)));
                            });
                          },
                          child: Text(
                            'Done',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: MyDim.fontSizeButtons),
                          ))),
                  SizedBox(
                    width: MyDim.paddingUnit * 2,
                  ),
                  // GestureDetector(
                  //   onTap: (){
                  //     setState(() {
                  //       Navigator.push(context,MaterialPageRoute(builder:(context)=>CategoriesSetUp2()));
                  //     });
                  //   },
                  //   child:Text('Skip',style: TextStyle(color: Colors.grey,decoration:TextDecoration.underline,fontWeight: FontWeight.bold),),
                  // )
                ],
              ),
            ),
            SizedBox(
              height: MyDim.paddingUnit * 1.2,
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Uint8List>> getPersonalDocs() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference mySubcollectionRef =
        firestore.collection('users').doc(widget.uid).collection('documents');

    try {
      QuerySnapshot querySnapshot =
          await mySubcollectionRef.where('type', isEqualTo: 'Bill').get();

      List<Uint8List> personalDocWidgets = [];

      // Loop through the documents returned by the query
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        // Retrieve the data for each document
        Uint8List? imageData = await getdocumentData(doc.id);

        // Add the widget to the list
        personalDocWidgets.add(imageData!);
      }

      return personalDocWidgets;
    } catch (e) {
      print('Error getting personal docs: $e');
      return [];
    }
  }

  Future<Uint8List?> getdocumentData(docid) async {
    try {
      String imagePath = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .collection('documents')
          .doc(docid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        return documentSnapshot.get('Bill') as String;
      });

      return FirebaseStorage.instance.ref(imagePath).getData();
    } catch (e) {
      print('Error getting document data: $e');
      return null;
    }
  }
}
