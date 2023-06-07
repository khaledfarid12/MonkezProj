import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/Document.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;
late final Document document;

class DocumentService {
  static Future<Document?> getDocumentData(String userId) async {
    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('documents')
        .doc(userId);
    final userDoc = await docRef.get();

    if (userDoc.exists) {
      final userData = userDoc.data()!;
      final docPath = userData['${document.docType}Path'].toString();
      String? downloadUrl;

      if (docPath.isNotEmpty) {
        try {
          final ref = _storage.ref().child(docPath);
          downloadUrl = await ref.getDownloadURL();
        } catch (e) {
          print('Error getting download URL for document image: $e');
        }
      }

      document = Document(
          docPath: userData['${document.docType}Path'],
          docType: userData['docType']);
      return document;
    } else {
      return null;
    }
  }
}
