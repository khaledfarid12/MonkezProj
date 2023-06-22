import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/Screens/UserService.dart';
import 'package:gradproj/Screens/accessedDocs.dart';
import '../Constants/Dimensions.dart';
import '../models/User.dart';
import '../screens/ContactUS.dart';
import '../screens/NearestBuilding.dart';
import '../screens/ServiceNeeds.dart';
import '../screens/SetUpProfile3.dart';
import '../screens/profile.dart';
import '../screens/Welcome_Page.dart';
import '../screens/guidance.dart';
import '../models/members.dart';
import '../screens/travelScan.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class fam extends StatefulWidget {
  final User user;
  final String uid;
  final String member;
  final String membername;
  final String memberemail;
  const fam(
      {Key? key,
      required this.user,
      required this.uid,
      required this.member,
      required this.membername,
      required this.memberemail
      //required this.uploadInfo,
      })
      : super(key: key);
  @override
  State<fam> createState() => _famState();
}

class _famState extends State<fam> {
  bool? Nationalid = false;
  bool? driverLisence = false;
  bool? birthCirt = false;
  bool? HSCirt = false;
  bool? passport = false;
  bool? visa = false;
  bool? vaccine = false;

  @override
  Widget build(BuildContext context) {
    final memberdata = UserService.getUserData(widget.member);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                        ),
                      ));
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
                              uid: widget.uid, user: widget.user)));
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
                              TravelGuide(uid: widget.uid, user: widget.user)));
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
                              uid: widget.uid, user: widget.user)));
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
                              Guidance(uid: widget.uid, user: widget.user)));
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
                          builder: (context) =>
                              SetupProfile3(uid: widget.uid)));
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
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomePage()));
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 45.0,
              ),
              // new Container(
              //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              //   alignment: Alignment.topLeft,
              //   child: IconButton(
              //     icon: const Icon(
              //       Icons.arrow_circle_left_rounded,
              //       color: Color.fromARGB(255, 0, 205, 208),
              //       size: 50,
              //     ),
              //     tooltip: 'back Icon',
              //     onPressed: () {
              //       Navigator.of(context)
              //           .push(MaterialPageRoute(builder: (_) => userprofile()));
              //     },
              //
              //   ),
              // ),
              new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.transparent,
                      child: FutureBuilder<Uint8List>(
                        future: membergetImageData(widget.member),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return CircleAvatar(
                              backgroundImage: MemoryImage(snapshot.data!),
                              radius: 80,
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.membername,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                      new Container(
                        margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Text(widget.memberemail,
                            style: TextStyle(fontSize: 15)),
                      ),
                    ],
                  ),
                ],
              ),
              //family section
              SingleChildScrollView(
                child: FutureBuilder<Column>(
                  future: getFamilyNames(widget.member),
                  builder:
                      (BuildContext context, AsyncSnapshot<Column> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return snapshot.data!;
                      }
                    }
                  },
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                      shadowColor:
                          Color.fromARGB(255, 0, 205, 208).withOpacity(0.5),
                      padding: EdgeInsets.all(10),
                      side: BorderSide(
                          color: Color.fromARGB(255, 0, 205, 208), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ) //<-- SEE HERE
                      ),
                  onPressed: () {
                    Navigator.push(
                      this.context,
                      MaterialPageRoute(
                        builder: (context) => accessedDocs(
                          userId: widget.uid,
                          user: widget.user,
                          fammember: widget.membername,
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    // <-- Icon
                    Icons.folder,
                    color: Color.fromARGB(255, 66, 65, 65),
                    size: 50.0,
                  ),
                  label: Text('Documents',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black)), // <-- Text
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 205, 208),
                    primary: Colors.black87,
                    minimumSize: Size(88, 36),
                    padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                  ),
                  onPressed: () {
                    AwesomeDialog(
                      context: context,
                      body: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Column(children: [
                            CheckboxListTile(
                              value: Nationalid,
                              controlAffinity: ListTileControlAffinity
                                  .leading, //checkbox at left
                              onChanged: (bool? value) {
                                // print('Before update: Nationalid = ${Nationalid}');
                                setState(() {
                                  Nationalid = value!;
                                });
                                // print('After update: Nationalid = ${Nationalid}');
                              },
                              title: Text(
                                "National ID",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            CheckboxListTile(
                              value: driverLisence,
                              controlAffinity: ListTileControlAffinity
                                  .leading, //checkbox at left
                              onChanged: (bool? value) {
                                setState(() {
                                  driverLisence = value;
                                });
                              },
                              title: Text(
                                "Driver's lisence",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            CheckboxListTile(
                              value: birthCirt,
                              controlAffinity: ListTileControlAffinity
                                  .leading, //checkbox at left
                              onChanged: (bool? value) {
                                setState(() {
                                  birthCirt = value!;
                                });
                              },
                              title: Text(
                                "Birth Certificate",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            CheckboxListTile(
                              value: HSCirt,
                              controlAffinity: ListTileControlAffinity
                                  .leading, //checkbox at left
                              onChanged: (bool? value) {
                                setState(() {
                                  HSCirt = value!;
                                });
                              },
                              title: Text(
                                "High School Graduation Certificate",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            CheckboxListTile(
                              value: passport,
                              controlAffinity: ListTileControlAffinity
                                  .leading, //checkbox at left
                              onChanged: (bool? value) {
                                setState(() {
                                  passport = value!;
                                });
                              },
                              title: Text(
                                "Passport",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            CheckboxListTile(
                              value: visa,
                              controlAffinity: ListTileControlAffinity
                                  .leading, //checkbox at left
                              onChanged: (bool? value) {
                                setState(() {
                                  visa = value!;
                                });
                              },
                              title: Text(
                                "Acquired Visas",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            CheckboxListTile(
                              value: vaccine,
                              controlAffinity: ListTileControlAffinity
                                  .leading, //checkbox at left
                              onChanged: (bool? value) {
                                setState(() {
                                  vaccine = value!;
                                });
                              },
                              title: Text(
                                "Vaccines",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ]);
                        },
                      ),
                      animType: AnimType.topSlide,
                      showCloseIcon: true,
                      title: "Select documents ",
                      desc: 'Choose documents you want to access',
                      btnOkOnPress: () {
                        createDocumentAccessSubcollection(Nationalid, vaccine,
                            visa, passport, HSCirt, birthCirt, driverLisence);
                      },
                      btnCancelOnPress: () {},
                    ).show();
                  },
                  child: Text('Document Access',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  Future<Uint8List> membergetImageData(uid) async {
    //await widget.uploadInfo();

    String imagePath = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
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

  Widget familymember1(name, email, image) {
    return InkWell(
      child: Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.fromLTRB(20, 30, 0, 0),
            child: ClipOval(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.transparent,
                child: FutureBuilder<Uint8List>(
                  future: membergetImageData(image),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Image.memory(
                        snapshot.data!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
            // alignment: Alignment.center,
            child: Text(
              name,
              // textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
            //   alignment: Alignment.center,
            child: Text(email,
                //     textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15)),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context as BuildContext).push(MaterialPageRoute(
            builder: (_) => fam(
                  uid: widget.uid,
                  user: widget.user,
                  member: image,
                  membername: name,
                  memberemail: email,
                )));
      },
    );
  }

  Future<List<DocumentSnapshot>> getAlluserInfamily(
      String userId, String subcollectionName) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection(subcollectionName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List<DocumentSnapshot> documents = querySnapshot.docs;
        return documents;
      } else {
        // subcollection is empty
        return [];
      }
    } catch (e) {
      // handle any errors
      print('Error getting documents: $e');
      return [];
    }
  }

  Widget familsection(familyname, parentId) {
    return Column(children: <Widget>[
      Column(
        children: <Widget>[
          new Container(
            color: Color.fromARGB(255, 0, 205, 208),
            margin: EdgeInsets.fromLTRB(12, 30, 12, 0),
            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            alignment: Alignment.center,
            child: Text(
              familyname,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            ),
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(100),
              bottomRight: Radius.circular(100)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 0, 205, 208).withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: FutureBuilder<List<DocumentSnapshot>>(
          future: getAlluserInfamily(
            parentId,
            familyname,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<Widget> memberWidgets = [];

              // Process the data for each document
              snapshot.data!.forEach((document) {
                var data = document.data() as Map<String, dynamic>;

                // Access the fields in the data map
                String name = data['name'] ?? '';
                String email = data['email'] ?? '';
                String avatar = document.id ?? '';

                // ...

                // Create a widget for the family member
                Widget memberWidget = familymember1(name, email, avatar);

                // Add the widget to the list of member widgets
                memberWidgets.add(memberWidget);
              });

              // Return the row of member widgets
              return Column(children: <Widget>[
                CarouselSlider(
                  items: memberWidgets,
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                  ),
                ),
              ]);
            } else {
              return Text('No family members found.');
            }
          },
        ),
      )
    ]);
  }

  Future<Column> getFamilyNames(String userId) async {
    DocumentSnapshot document =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    List<dynamic> familyNames = document['familynames'];
    List<String> familyNamesStrings =
        familyNames.map((item) => item.toString()).toList();

    List<Widget> familyWidgets = [];

    for (String familyName in familyNamesStrings) {
      Set<String> processedIds = {};
      QuerySnapshot subcollectionSnapshot =
          await FirebaseFirestore.instance.collectionGroup(familyName).get();

      String parentId =
          subcollectionSnapshot.docs.first.reference.parent.parent!.id;

      Widget familyWidget = familsection(familyName, parentId);
      familyWidgets.add(familyWidget);
    }

    return Column(children: familyWidgets);
  }

  Future<void> createDocumentAccessSubcollection(Nationalid, vaccine, visa,
      passport, HSCirt, birthCirt, driverLisence) async {
    // Check if the username is already taken

    DocumentReference docRef =
        FirebaseFirestore.instance.collection('users').doc(widget.uid);

    if (Nationalid) {
      docRef.collection('docAccess').doc().set({
        'docname': 'nationalid',
        'docowner': widget.membername,
        'status': 'pending',
        'sender': widget.uid
      });
      _senddocumentRequest('nationalid');
    }
    if (vaccine) {
      docRef.collection('docAccess').doc().set({
        'docname': 'vaccine',
        'docowner': widget.membername,
        'status': 'pending',
        'sender': widget.uid
      });
      _senddocumentRequest('vaccine');
    }
    if (visa) {
      docRef.collection('docAccess').doc().set({
        'docname': 'visa',
        'docowner': widget.membername,
        'status': 'pending',
        'sender': widget.uid
      });
      _senddocumentRequest('visa');
    }
    if (passport) {
      docRef.collection('docAccess').doc().set({
        'docname': 'passport',
        'docowner': widget.membername,
        'status': 'pending',
        'sender': widget.uid
      });
      _senddocumentRequest('passport');
    }
    if (HSCirt) {
      docRef.collection('docAccess').doc().set({
        'docname': 'HSCirt',
        'docowner': widget.membername,
        'status': 'pending',
        'sender': widget.uid
      });
      _senddocumentRequest('HSCirt');
    }

    if (birthCirt) {
      docRef.collection('docAccess').doc().set({
        'docname': 'birthCirt',
        'docowner': widget.membername,
        'status': 'pending',
        'sender': widget.uid
      });
      _senddocumentRequest('birthCirt');
    }
    if (driverLisence) {
      docRef.collection('docAccess').doc().set({
        'docname': 'driverLisence',
        'docowner': widget.membername,
        'status': 'pending',
        'sender': widget.uid
      });
      _senddocumentRequest('driverLisence');
    }

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => AddFamilyMember(
    //             uid: widget.uid,
    //             senderuser: widget.senderuser,
    //             familyname: familyname)));
  }

  void _senddocumentRequest(docname) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: widget.membername.toString())
            .limit(1)
            .get();

    String userId = querySnapshot.docs.first.id;
    // Get the current user's ID
    final currentUserId = widget.uid;

    // Check if the current user has already sent a friend request to this user
    final documentRequestsRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('documentsRequests')
        .doc();
    final documentRequestsSnapshot = await documentRequestsRef.get();
    if (documentRequestsSnapshot.exists) {
      final status = documentRequestsSnapshot['status'];
      final friendUserId = documentRequestsSnapshot['sender'];
      if (status == 'pending' && friendUserId == currentUserId) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('document request already sent.'),
          ),
        );
        return;
      }
    }

    // Add a new document to the "friendRequests" subcollection with the friend's user ID and a status of "pending"
    await documentRequestsRef.set({
      'sender': currentUserId,
      'status': 'pending',
      'senderName': widget.user.username,
      'senderEmail': widget.user.email,
      'senderAvatar': widget.user.imagePath,
      'documentname': docname
    });

    // Show a snackbar to confirm the friend request was sent
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Document request sent.'),
      ),
    );
  }
}
