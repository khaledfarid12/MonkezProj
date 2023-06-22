import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradproj/models/User.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FamilyRequestsScreen extends StatefulWidget {
  final String userId;
  final User user;

  const FamilyRequestsScreen(
      {Key? key, required this.userId, required this.user})
      : super(key: key);
  @override
  State<FamilyRequestsScreen> createState() => _FamilyRequestsScreenState();
}

class _FamilyRequestsScreenState extends State<FamilyRequestsScreen> {
  late Future<List<DocumentSnapshot>> _future;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00CDD0),
        title: Text('Family member requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('users')
            .doc(widget.userId)
            .collection('familyRequests')
            .where('status', isEqualTo: 'pending')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipOval(
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.transparent,
                                child: FutureBuilder<Uint8List>(
                                  future: getImageData(
                                      documents[index]['senderAvatar']),
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
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  documents[index]['senderName'],
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  documents[index]['senderEmail'],
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _acceptFriendRequest(
                                            documents[index]['friendUserId'],
                                            widget.userId,
                                            documents[index]['familyname'],
                                          );
                                        },
                                        child: Text('Accept'),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        _rejectFriendRequest(
                                            documents[index]['friendUserId']);
                                      },
                                      child: Text('Reject'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      new Column(
                        children: <Widget>[
                          new Container(
                            color: Color.fromARGB(255, 0, 205, 208),
                            margin: EdgeInsets.fromLTRB(12, 30, 12, 0),
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            alignment: Alignment.center,
                            child: Text(
                              documents[index]['familyname'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      new Container(
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
                              color: Color.fromARGB(255, 0, 205, 208)
                                  .withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: FutureBuilder<List<DocumentSnapshot>>(
                          future: getAlluserInfamily(
                            documents[index]['friendUserId'],
                            documents[index]['familyname'],
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                              List<Widget> memberWidgets = [];

                              // Process the data for each document
                              snapshot.data!.forEach((document) {
                                var data =
                                    document.data() as Map<String, dynamic>;

                                // Access the fields in the data map
                                String name = data['name'] ?? '';
                                String email = data['email'] ?? '';
                                String avatar = document.id ?? '';

                                // ...

                                // Create a widget for the family member
                                Widget memberWidget =
                                    familymember(name, email, avatar);

                                // Add the widget to the list of member widgets
                                memberWidgets.add(memberWidget);
                              });

                              // Return the row of member widgets
                              return CarouselSlider(
                                items: memberWidgets,
                                options: CarouselOptions(
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 0.8,
                                ),
                              );
                            } else {
                              return Text('No family members found.');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _acceptFriendRequest(
      String requestId, String userId, String familyname) {
    _firestore
        .collection('users')
        .doc(userId)
        .collection('familyRequests')
        .doc(requestId)
        .update({'status': 'accepted'});
    FirebaseFirestore.instance.collection('users').doc(userId).update({
      'familynames': FieldValue.arrayUnion([familyname])
    });
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('users').doc(requestId);
    docRef.collection(familyname).doc(userId).set({
      'name': widget.user.username,
      'email': widget.user.email,
      'avatar': widget.user.imagePath
    });
  }

  void _rejectFriendRequest(String requestId) {
    _firestore
        .collection('users')
        .doc(widget.userId)
        .collection('familyRequests')
        .doc(requestId)
        .update({'status': 'rejected'});
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

  Widget familymember(name, email, image) {
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
      onTap: () {
        // Navigator.of(context as BuildContext)
        //     .push(MaterialPageRoute(builder: (_) => fam(member)));
      },
    );
  }
}
