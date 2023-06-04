import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'Dimensions.dart';
import 'package:flutter/material.dart';

class buildCard extends StatefulWidget {
  final String labelText;
  final String uid;
  const buildCard({Key? key, required this.labelText, required this.uid})
      : super(key: key);

  @override
  State<buildCard> createState() => _buildCardState();
}

class _buildCardState extends State<buildCard> {
  bool _showOverlay = false;
  void initState() {
    super.initState();
    getImageData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Expanded(
        child: Container(
          // width: double.infinity,
          // height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Color(0xFF00CDD0),
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                bottom: MyDim.paddingUnit * 1, left: MyDim.paddingUnit * 0.2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.labelText,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  child: FutureBuilder<Uint8List>(
                    future: getImageData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Image(
                          image: ResizeImage(MemoryImage(snapshot.data!),
                              width: 180, height: 300),
                        );
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
      ),
    );
  }

  Future<Uint8List> getImageData() async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('users').doc(widget.uid);

    String imagePath = await docRef
        .collection('documents')
        .doc(widget.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      return documentSnapshot.get(widget.labelText) as String;
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
