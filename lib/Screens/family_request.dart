import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FamilyRequestsScreen extends StatelessWidget {
  final String userId;

  FamilyRequestsScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friend Requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('users')
            .doc(userId)
            .collection('friendRequests')
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage:
                            NetworkImage(documents[index]['senderAvatar']),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _acceptFriendRequest(
                                          documents[index].id, userId);
                                    },
                                    child: Text('Accept'),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _rejectFriendRequest(documents[index].id);
                                  },
                                  child: Text('Reject'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
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

  void _acceptFriendRequest(String requestId, String userId) {
    _firestore
        .collection('users')
        .doc(userId)
        .collection('friendRequests')
        .doc(requestId)
        .update({'status': 'accepted'});
  }

  void _rejectFriendRequest(String requestId) {
    _firestore
        .collection('users')
        .doc(userId)
        .collection('friendRequests')
        .doc(requestId)
        .update({'status': 'rejected'});
  }
}
