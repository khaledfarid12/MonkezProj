import 'package:flutter/material.dart';
import 'package:gradproj/Screens/CategoriesSetUp2.dart';
import 'package:gradproj/Screens/EditProfile.dart';
import 'package:gradproj/Screens/UserService.dart';
import 'package:gradproj/Screens/addfamilymember.dart';
import 'package:gradproj/Screens/family_request.dart';
import 'package:gradproj/Screens/fammember.dart';
import 'package:gradproj/Screens/searchnew.dart';
import 'package:path/path.dart';
import '../models/members.dart';
import '../models/User.dart';
import '../Screens/SetupProfile3.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Screens/friend_requests.dart';
import 'SetUpProfile1.dart';
import 'package:carousel_slider/carousel_slider.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class userprofile extends StatefulWidget {
  final User user;
  final String uid;
  final Function() getImageData;

  const userprofile({
    Key? key,
    required this.user,
    required this.uid,
    required this.getImageData,
    //required this.uploadInfo,
  }) : super(key: key);

  @override
  State<userprofile> createState() => _userprofileState();
}

class _userprofileState extends State<userprofile> {
  @override
  Widget build(BuildContext context) {
    final storage = FirebaseStorage.instance;
    final ref = FirebaseStorage.instance.ref().child(widget.user.imagePath);
    final url = ref.getDownloadURL();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.menu),
              tooltip: 'Menu Icon',
              onPressed: () {},
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.settings),
                tooltip: 'Comment Icon',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FamilyRequestsScreen(
                          userId: widget.uid, user: widget.user),
                    ),
                  );
                },
              ),
            ],
            backgroundColor: Color.fromARGB(255, 0, 205, 208)),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_circle_left_rounded,
                    color: Color.fromARGB(255, 0, 205, 208),
                    size: 50,
                  ),
                  tooltip: 'back Icon',
                  onPressed: () {},
                  style: IconButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.transparent,
                      child: FutureBuilder<Uint8List>(
                        future: widget.getImageData(),
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
                  SizedBox(
                    width: 10,
                  ),
                  new Column(
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.user.username,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                      new Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        alignment: Alignment.topLeft,
                        child: Text(widget.user.location,
                            style: TextStyle(fontSize: 15)),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  side:
                                      BorderSide(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditProfile(uid: widget.uid),
                              ),
                            );
                          });
                        },
                        child: Text('Edit Profile',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ],
                  ),
                ],
              ),
              SingleChildScrollView(
                child: FutureBuilder<Column>(
                  future: getFamilyNames(widget.uid),
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
              new Column(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          side: BorderSide(color: Colors.black, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ) //<-- SEE HERE
                          ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SetUpProfile1(
                                uid: widget.uid, senderuser: widget.user),
                          ),
                        );
                      },
                      icon: Icon(
                        // <-- Icon
                        Icons.add_circle_outline,
                        color: Colors.black,
                        size: 26.0,
                      ),
                      label: Text('Add Family community',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black)), // <-- Text
                    ),
                  ),
                ],
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
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoriesSetUp2(
                            user: widget.user,
                            uid: widget.uid,
                          ),
                        ),
                      );
                    });
                  },
                  icon: Icon(
                    // <-- Icon
                    Icons.folder,
                    color: Color.fromARGB(255, 66, 65, 65),
                    size: 50.0,
                  ),
                  label: Text('MY Documents',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black)), // <-- Text
                ),
              ),
              new Container(
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
                  onPressed: () {},
                  child: Text('Logout',
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

  Widget familymember(Members member) {
    return InkWell(
      child: Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.fromLTRB(20, 30, 0, 0),
            child: Image.asset(
              member.urlphoto,
              height: 90.0,
              fit: BoxFit.cover,
            ),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
            // alignment: Alignment.center,
            child: Text(
              member.name,
              // textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
            //   alignment: Alignment.center,
            child: Text(member.pos,
                //     textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15)),
          ),
        ],
      ),
      onTap: () {
        // Navigator.of(context as BuildContext)
        //     .push(MaterialPageRoute(builder: (_) => fam(member)));
      },
    );
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
                new Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        side: BorderSide(color: Colors.black, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ) //<-- SEE HERE
                        ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddFamilyMember(
                                  uid: widget.uid,
                                  senderuser: widget.user,
                                  familyname: familyname)));
                    },
                    icon: Icon(
                      // <-- Icon
                      Icons.add_circle_outline,
                      color: Colors.black,
                      size: 26.0,
                    ),
                    label: Text('Add Family Member',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black)), // <-- Text
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

  Widget familymember1(name, email, image) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            this.context,
            MaterialPageRoute(
              builder: (context) => fam(
                uid: widget.uid,
                user: widget.user,
                member: image,
                membername: name,
                memberemail: email,
              ),
            ),
          );
        },
        child: InkWell(
          child: Column(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: ClipOval(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    child: FutureBuilder<Uint8List>(
                      future: getImageData(image),
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
          // onTap: () {
          //   if (context is BuildContext) {
          //     Navigator.push(
          //       context as BuildContext,
          //       MaterialPageRoute(
          //         builder: (_) => fam(
          //           uid: widget.uid,
          //           user: widget.user,
          //           member: image,
          //           membername: name,
          //           memberemail: email,
          //         ),
          //       ),
          //     );
          //   } else {
          //     // handle the error here
          //   }
          // },
        ));
  }

  Future<Uint8List> getImageData(String uid) async {
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
}
