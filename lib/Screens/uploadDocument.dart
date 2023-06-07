import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../models/User.dart';
import 'MoneyRelated.dart';

class DocumentUploadScreen2 extends StatefulWidget {
  final String uid;
  final User user;
  final String docname;

  const DocumentUploadScreen2(
      {super.key,
      required this.uid,
      required this.user,
      required this.docname});
  @override
  _DocumentUploadScreenState createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen2> {
  final picker = ImagePicker();

  File? _selectedImage;
  DateTime? _expiryDate;
  bool _isUploading = false;

  FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _initFlutterLocalNotifications();
  }

  Future<void> _initFlutterLocalNotifications() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin!.initialize(initializationSettings);
  }

  Future<void> _showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_id', 'channel_name',
        importance: Importance.high, priority: Priority.high);

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin!
        .show(0, title, body, platformChannelSpecifics);
  }

  Future<void> _getImageFromCamera() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _getImageFromGallery() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _selectExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _expiryDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));

    if (picked != null && picked != _expiryDate) {
      setState(() {
        _expiryDate = picked;
      });
    }
  }

  Future<void> _uploadDocument() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select an image to upload.')));
      return;
    }
    if (_expiryDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select an expiry date.')));
      return;
    }
    setState(() {
      _isUploading = true;
    });
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final path = 'documents/${p.basename(_selectedImage!.path)}';
      final ref = FirebaseStorage.instance.ref().child(path);

      // Reference storageReference = FirebaseStorage.instance
      //     .ref()
      //     .child('documents/${p.basename(_selectedImage!.path)}');

      UploadTask uploadTask = ref.putFile(_selectedImage!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      if (downloadUrl != null) {
        DocumentReference docRef =
            FirebaseFirestore.instance.collection('users').doc(widget.uid);

        // Create the "documents" subcollection
        await docRef.collection('documents').doc(widget.uid).update({
          widget.docname: path,
          'expiryDateOf${widget.docname}': _expiryDate,
          'type': widget.docname
        }).then((value) => showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Success'),
                content: Text('Document uploaded successfully.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'))
                ],
              );
            }));

        int daysUntilExpiry = _expiryDate!.difference(DateTime.now()).inDays;
        if (daysUntilExpiry <= 10) {
          await _showNotification('Document Expiring Soon',
              'The document will expire in $daysUntilExpiry days. Please renew it before it expires to avoid late fine.');
        }
      }
    } catch (error) {
      print('Error uploading document: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'An error occurred while uploading the document. Please try again later.')));
    } finally {
      setState(() {
        _isUploading = false;
        _selectedImage = null;
        _expiryDate = null;
      });
    }
  }

  Future<void> _showExpiryDateChangeDialog() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _expiryDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));

    if (picked != null && picked != _expiryDate) {
      setState(() {
        _expiryDate = picked;
      });
    }
  }

  Future<void> _showExpiryDateErrorMessage() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Expired Document'),
            content: Text(
                'The documentyou selected has already expired. Please select another one or change the expiry date.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00CDD0),
        centerTitle: true,
        title: Text('Upload Document'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Container(
          width: 800,
          height: 600,
          margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
          padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(70),
                bottomRight: Radius.circular(70)),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 0, 205, 208).withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 32),
                  Center(
                    child: _selectedImage == null
                        ? Text('No image selected.')
                        : Image.file(_selectedImage!),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xFF00CDD0)),
                        width: 100,
                        height: 50.0,
                        child: TextButton(
                          onPressed: _getImageFromCamera,
                          child: Text('Take Photo',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                        ),
                      ),
                      SizedBox(width: 16),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xFF00CDD0)),
                        width: 160,
                        height: 50.0,
                        child: TextButton(
                          onPressed: _getImageFromGallery,
                          child: Text('Choose from Gallery',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('Expiry Date'),
                    subtitle: _expiryDate == null
                        ? Text('Please select an expiry date.')
                        : Text(DateFormat('yyyy-MM-dd').format(_expiryDate!)),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: _expiryDate == null
                          ? null
                          : () {
                              _showExpiryDateChangeDialog();
                            },
                    ),
                    onTap: () {
                      if (_expiryDate != null) {
                        if (_expiryDate!.isBefore(DateTime.now())) {
                          _showExpiryDateErrorMessage();
                        }
                      }
                      _selectExpiryDate(context);
                    },
                  ),
                  SizedBox(height: 32),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFF00CDD0)),
                    width: 200.0,
                    height: 50.0,
                    child: TextButton(
                      onPressed: _isUploading ? null : _uploadDocument,
                      child: _isUploading
                          ? CircularProgressIndicator()
                          : Text(
                              'Upload Document',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFF00CDD0)),
                    width: 200.0,
                    height: 50.0,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MoneyRelated(
                                      user: widget.user, uid: widget.uid)));
                        });
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
