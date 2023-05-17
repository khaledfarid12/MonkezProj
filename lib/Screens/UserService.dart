import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/User.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;

class UserService {
  static Future<User?> getUserData(String userId) async {
    final userRef = _firestore.collection('users').doc(userId);
    final userDoc = await userRef.get();

    if (userDoc.exists) {
      final userData = userDoc.data()!;
      final imagePath = userData['imagePath'].toString();
      String? downloadUrl;

      if (imagePath.isNotEmpty) {
        try {
          final ref = _storage.ref().child(imagePath);
          downloadUrl = await ref.getDownloadURL();
        } catch (e) {
          print('Error getting download URL for profile image: $e');
        }
      }

      final user = User(
        username: userData['username'].toString(),
        email: userData['email'],
        imagePath: userData['imagePath'],
        location: userData['location'],
        firstName: userData['firstName'],
        // imageDownloadUrl: downloadUrl,
      );
      return user;
    } else {
      return null;
    }
  }
}
