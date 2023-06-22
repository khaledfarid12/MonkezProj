import 'dart:async';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:full_screen_image/full_screen_image.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradproj/models/User.dart';
import 'package:flutter/src/rendering/box.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class accessedDocs extends StatefulWidget {
  final String userId;
  final User user;
  final String fammember;

  const accessedDocs(
      {Key? key,
      required this.userId,
      required this.user,
      required this.fammember})
      : super(key: key);
  @override
  State<accessedDocs> createState() => _accessedDocsState();
}

class _accessedDocsState extends State<accessedDocs> {
  late Future<List<DocumentSnapshot>> _future;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Documents Access '),
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
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

  Future<List<Uint8List>> getPersonalDocs() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference mySubcollectionRef = firestore
        .collection('users')
        .doc(widget.userId)
        .collection('docAccess');

    QuerySnapshot querySnapshot = await mySubcollectionRef
        .where('docowner', isEqualTo: widget.fammember.toString())
        .where('status', isEqualTo: 'accepted')
        .get();
    List<Uint8List> AccessDocWidgets = [];
    // Loop through the documents returned by the query
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final QuerySnapshot<Map<String, dynamic>> docownerSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('username', isEqualTo: data['docowner'].toString())
              .limit(1)
              .get();

      //   QuerySnapshot docownerSnapshot = await docownerRef.get();
      DocumentSnapshot docownerDoc = docownerSnapshot.docs.first;
      String docownerId = docownerDoc.id;
      final CollectionReference myDocumentsRef =
          firestore.collection('users').doc(docownerId).collection('documents');
      QuerySnapshot documentsQuerySnapshot = await myDocumentsRef
          .where('doctype', isEqualTo: data['docname'])
          .get();

      for (QueryDocumentSnapshot documentsDoc in documentsQuerySnapshot.docs) {
        // Retrieve the data for each document
        Uint8List? imageData =
            await getdocumentData(docownerId, documentsDoc.id.toString());
        if (imageData != null) {
          // Add the widget to the list
          AccessDocWidgets.add(imageData);
        }
      }
    }

    return AccessDocWidgets;
  }

  Future<Uint8List?> getdocumentData(docownerId, docid) async {
    try {
      String imagePath = await FirebaseFirestore.instance
          .collection('users')
          .doc(docownerId)
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
