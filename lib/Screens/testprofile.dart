import 'package:flutter/material.dart';
import '../models/User.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          Image.network(user.imagePath, fit: BoxFit.cover),
          Text(user.username),
          Text(user.email),
        ],
      ),
    );
  }
}
