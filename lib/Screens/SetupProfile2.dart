import 'dart:typed_data';
import 'package:full_screen_image/full_screen_image.dart';

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
import 'family_request.dart';
import 'profile.dart';
import 'welcome_page.dart';
import 'Guidance.dart';
import 'travelScan.dart';
import 'uploadDocument.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/rendering/box.dart';

class SetProfile2 extends StatefulWidget {
  final User user;
  final String uid;

  const SetProfile2({Key? key, required this.user, required this.uid})
      : super(key: key);

  @override
  State<SetProfile2> createState() => _SetProfile2State();
}

class _SetProfile2State extends State<SetProfile2> {
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
        title: Center(
          child: Text(
            'Personal Identification',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color(0xFF00CDD0),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FamilyRequestsScreen(userId: widget.uid, user: widget.user),
              ),
            );
          },
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
                'My Profile',
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
                              uid: widget.uid,
                              user: widget.user,
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
                        builder: (context) => ServiceNeeds(
                              user: widget.user,
                              uid: widget.uid,
                            )));
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
                        builder: (context) => TravelGuide(
                              uid: widget.uid,
                              user: widget.user,
                            )));
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
                        builder: (context) => ContactUS(
                              uid: widget.uid,
                              user: widget.user,
                            )));
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
                              user: widget.user,
                              uid: widget.uid,
                            )));
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
                        builder: (context) => Guidance(
                              uid: widget.uid,
                              user: widget.user,
                            )));
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
                    return AlertDialog(
                      title: Text("Logout"),
                      content: Text("Are you sure you want to logout?"),
                      actions: [
                        TextButton(
                          child: Text("no"),
                          onPressed: () {
                            // Close the dialog and do nothing
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text("yes"),
                          onPressed: () {
                            // Close the dialog and sign the user out
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WelcomePage()));
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
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
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 10.0,
                          children: <Widget>[
                            for (int i = 0; i < personalDocs.length; i += 2)
                              Row(
                                children: [
                                  Flexible(
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: FullScreenWidget(
                                        disposeLevel: DisposeLevel.Low,
                                        child: Hero(
                                          tag: "customTag$i",
                                          child: Container(
                                            margin: EdgeInsets.all(8),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Image.memory(
                                                personalDocs[i],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (i + 1 < personalDocs.length)
                                    Flexible(
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: FullScreenWidget(
                                          disposeLevel: DisposeLevel.Low,
                                          child: Hero(
                                            tag: "customTag${i + 1}",
                                            child: Container(
                                              margin: EdgeInsets.all(8),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: Image.memory(
                                                  personalDocs[i + 1],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(
                  top: MyDim.paddingUnit * 1.5, left: MyDim.paddingUnit * 0.5),
              child: Expanded(
                child: Row(
                  children: <Widget>[
                    //National ID
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
                              'Assets/images/id.png',
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
                                                user: widget.user,
                                                uid: widget.uid,
                                                docname: 'personaldocs',
                                                doctype: 'nationalid')));
                              },
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Colors.black,
                                size: 30.0,
                              ),
                            ),
                            Text(
                              'National ID',
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
                                                docname: 'personaldocs',
                                                doctype: 'Passport',
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
            ),

            //second row
            Padding(
              padding: const EdgeInsets.only(
                  top: MyDim.paddingUnit * 1.5, left: MyDim.paddingUnit * 0.5),
              child: Expanded(
                  child: Row(
                children: [
                  //Driving
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
                          'Assets/images/driving.png',
                          width: MyDim.myWidth(context) * 0.3,
                          height: MyDim.myHeight(context) * 0.2,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DocumentUploadScreen2(
                                        user: widget.user,
                                        uid: widget.uid,
                                        docname: 'personaldocs',
                                        doctype: 'driving')));
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: Colors.black,
                            size: 30.0,
                          ),
                        ),
                        Text(
                          'Driving License',
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

                  //BirthDate
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
                          'Assets/images/Birth.png',
                          width: MyDim.myWidth(context) * 0.3,
                          height: MyDim.myHeight(context) * 0.2,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DocumentUploadScreen2(
                                        user: widget.user,
                                        uid: widget.uid,
                                        docname: 'personaldocs',
                                        doctype: 'Birthdate')));
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: Colors.black,
                            size: 30.0,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            ' Birthdate \nCertificate',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
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
                                            uid: widget.uid,
                                            user: widget.user,
                                          )));
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

  //plus Button function
  void onClick() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: AlertDialog(
              backgroundColor: Colors.white,
              title: Container(
                width: 600,
                height: 170,
                child: Row(
                  children: [
                    //Upload
                    Column(
                      children: [
                        Image.asset(
                          'Assets/images/upload.png',
                          color: Colors.black,
                          width: 90.0,
                          height: 90.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xFF00CDD0)),
                          width: 100.0,
                          height: 50.0,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Upload',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          ),
                        )
                      ],
                    ),
                    //Camera
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: MyDim.paddingUnit * 1,
                          left: MyDim.paddingUnit * 3.5),
                      child: Expanded(
                          child: Column(
                        children: [
                          Image.asset(
                            'Assets/images/camera.png',
                            color: Colors.black,
                            width: 100.0,
                            height: 90.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xFF00CDD0)),
                            width: 100.0,
                            height: 50.0,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Camera',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ),
                          )
                        ],
                      )),
                    ),
                  ],
                ),
              ),
              content: Container(
                child: Stack(
                  children: [
                    //Expire Date text
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 2.0),
                      child: Text(
                        'Expire Date',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    //calender + date textfield
                    Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 10, bottom: 200.0),
                        child: TextField(
                          controller:
                              dateinput, //editing controller of this TextField
                          decoration: InputDecoration(
                            icon: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(Icons.calendar_today,
                                  color: Colors.cyan),
                            ), //icon of text field
                            labelText: "  Enter a date",
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 18.0),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime(2001),
                                firstDate: DateTime(
                                    1920), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2009));

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                dateinput.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                      ),
                    ),

                    //OK Button
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 50.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xFF00CDD0)),
                          width: 200.0,
                          height: 50.0,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CategoriesSetUp2(
                                              user: widget.user,
                                              uid: widget.uid,
                                            )));
                              });
                            },
                            child: Text(
                              'Done',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //Cancel Button
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 180.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xFF00CDD0)),
                          width: 200.0,
                          height: 50.0,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SetProfile2(
                                              uid: widget.uid,
                                              user: widget.user,
                                            )));
                              });
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<List<Uint8List>> getPersonalDocs() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference mySubcollectionRef =
        firestore.collection('users').doc(widget.uid).collection('documents');

    try {
      QuerySnapshot querySnapshot = await mySubcollectionRef
          .where('type', isEqualTo: 'personaldocs')
          .get();

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
        return documentSnapshot.get('personaldocs') as String;
      });

      return FirebaseStorage.instance.ref(imagePath).getData();
    } catch (e) {
      print('Error getting document data: $e');
      return null;
    }
  }
}
