import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:gradproj/models/User.dart";
import 'package:image/image.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class UserSearchScreen extends StatefulWidget {
  final String uid;
  final User senderuser;
  const UserSearchScreen({
    Key? key,
    required this.uid,
    required this.senderuser,
  }) : super(key: key);
  @override
  _UserSearchScreenState createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  String _searchQuery = '';
  String text = "Add Friend Request";

  List<User> _searchResults = [];

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _onSearchSubmitted(String query) {
    // Reset the search results list
    setState(() {
      _searchResults = [];
    });

    // Query the Firestore "users" collection for users whose name or email contains the search query

    _firestore
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: query)
        .where('username', isLessThanOrEqualTo: query + '\uf8ff')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        User user = User(
          username: doc['username'],
          email: doc['email'],
          imagePath: doc['imagePath'],
          location: doc['location'],
          firstName: doc['firstName'],
        );
        setState(() {
          _searchResults.add(user);
        });
      });
    });
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
          backgroundColor: Colors.cyanAccent,
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
}
