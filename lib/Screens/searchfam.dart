import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:gradproj/models/User.dart";
import 'dart:typed_data';
import 'package:flutter/src/widgets/image.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class searchfam extends StatefulWidget {
  final String uid;
  final User senderuser;
  const searchfam({
    Key? key,
    required this.uid,
    required this.senderuser,
  }) : super(key: key);
  @override
  _searchfamState createState() => _searchfamState();
}

class _searchfamState extends State<searchfam> {
  String _searchQuery = '';
  String text = "Join TheFamilly ";

  List<User> _searchResults = [];

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  Future<void> _onSearchSubmitted(String query) async {
    // Reset the search results list
    setState(() {
      _searchResults = [];
    });

    // Query the Firestore "users" collection for users whose name or email contains the search query

    CollectionReference subcollectionRef = FirebaseFirestore.instance
        .collection('parentCollection')
        .doc('parentDocument')
        .collection('subcollection');

    String parentDocumentId = subcollectionRef.parent!.id;
    //   setState(() {
    //  //   _searchResults.add(user);
    //   });
    // _firestore
    //     .collection('users')
    //     .where('username', isGreaterThanOrEqualTo: query)
    //     .where('username', isLessThanOrEqualTo: query + '\uf8ff')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((doc) {
    //     User user = User(
    //       username: doc['username'],
    //       email: doc['email'],
    //       imagePath: doc['imagePath'],
    //       location: doc['location'],
    //       firstName: doc['firstName'],
    //     );
    //   setState(() {
    //  //   _searchResults.add(user);
    //   });
    // });
    // });
  }

  void _sendFriendRequest(User user, String senderid) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: user.username.toString())
            .limit(1)
            .get();

    String userId = querySnapshot.docs.first.id;
    // Get the current user's ID
    final currentUserId = widget.uid;

    // Check if the current user has already sent a friend request to this user
    final friendRequestsRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('friendRequests')
        .doc(currentUserId);
    final friendRequestsSnapshot = await friendRequestsRef.get();
    if (friendRequestsSnapshot.exists) {
      final status = friendRequestsSnapshot['status'];
      final friendUserId = friendRequestsSnapshot['friendUserId'];
      if (status == 'pending' && friendUserId == currentUserId) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Friend request already sent.'),
          ),
        );
        return;
      }
    }

    // Add a new document to the "friendRequests" subcollection with the friend's user ID and a status of "pending"
    await friendRequestsRef.set({
      'friendUserId': currentUserId,
      'status': 'pending',
      'senderName': widget.senderuser.username,
      'senderEmail': widget.senderuser.email,
      'senderAvatar': widget.senderuser.imagePath,
    });

    // Show a snackbar to confirm the friend request was sent
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Friend request sent.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: TextField(
            onChanged: _onSearchChanged,
            onSubmitted: _onSearchSubmitted,
            decoration: InputDecoration(
              hintText: 'Search for users',
              border: InputBorder.none,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            children: _searchResults.map((user) {
              return SizedBox(
                height: 0.0,
                child: Card(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 45.0,
                        backgroundImage: NetworkImage(user.imagePath),
                      ),
                      SizedBox(
                        height: 0.0,
                      ),
                      Text(user.username),
                      SizedBox(height: 5.0),
                      Text(user.email),
                      SizedBox(height: 0.0),
                      ElevatedButton(
                        onPressed: () => _sendFriendRequest(user, widget.uid),
                        child: Text("Add Friend Request"),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ));
  }

  Future<String?> getUserIdFromUsername(String username) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: username)
            .limit(1)
            .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    } else {
      return null;
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
