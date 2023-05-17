import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FriendRequestService {
  static Future<void> sendFriendRequest(String userId, String friendId) async {
    await _firestore.collection('friendRequests').add({
      'senderId': userId,
      'recipientId': friendId,
      'status': 'pending',
    });
  }

  static Future<void> acceptFriendRequest(String requestId) async {
    final requestRef = _firestore.collection('friendRequests').doc(requestId);
    final request = await requestRef.get();

    if (request.exists && request['status'] == 'pending') {
      await requestRef.update({'status': 'accepted'});

      final senderId = request['senderId'];
      final recipientId = request['recipientId'];

      await _firestore.collection('users').doc(senderId).update({
        'friends': FieldValue.arrayUnion([recipientId])
      });

      await _firestore.collection('users').doc(recipientId).update({
        'friends': FieldValue.arrayUnion([senderId])
      });
    }
  }

  static Stream<QuerySnapshot> getFriendRequests(String userId) {
    return _firestore
        .collection('friendRequests')
        .where('recipientId', isEqualTo: userId)
        .where('status', isEqualTo: 'pending')
        .snapshots();
  }
}
