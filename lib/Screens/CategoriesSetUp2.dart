import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/Constants/Dimensions.dart';
import 'package:gradproj/Screens/EditProfile.dart';
import 'package:gradproj/Screens/myPersonalDocs.dart';
import '../models/User.dart';
import 'ContactUs.dart';
import 'Education.dart';
import 'MoneyRelated.dart';
import 'NearestBuilding.dart';
import 'PhotosCategories.dart';
import 'ServiceNeeds.dart';
import 'SetupProfile3.dart';
import 'SetupProfile2.dart';
import 'SignUp.dart';
import 'family_request.dart';
import 'profile.dart';
import 'VaccinesCategories.dart';
import 'welcome_page.dart';
import 'Guidance.dart';
import 'travelScan.dart';

class CategoryModel {
  final String title;
  final String photoUrl;

  CategoryModel({
    required this.title,
    required this.photoUrl,
  });
}

class CategoriesSetUp2 extends StatefulWidget {
  final String uid;
  final User user;

  const CategoriesSetUp2({super.key, required this.uid, required this.user});

  @override
  State<CategoriesSetUp2> createState() => _CategoriesSetUp2State();
}

class _CategoriesSetUp2State extends State<CategoriesSetUp2> {
  Future<Uint8List> getImageData() async {
    //await widget.uploadInfo();

    String imagePath = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
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

  List<CategoryModel> categories = [
    CategoryModel(
      title: 'Personal Identification',
      photoUrl: 'Assets/images/identification.jpg',
    ),
    CategoryModel(
      title: 'Money Related',
      photoUrl: 'Assets/images/money.jpg',
    ),
    CategoryModel(
      title: 'Education',
      photoUrl: 'Assets/images/certificate.webp',
    ),
    CategoryModel(
      title: 'Vaccines',
      photoUrl: 'Assets/images/vaccines.jpg',
    ),
    CategoryModel(
      title: 'Your Personal Photos',
      photoUrl: 'Assets/images/personal photos.png',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: new Drawer(),
        appBar: new AppBar(
          backgroundColor: Color(0xFF00CDD0),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FamilyRequestsScreen(
                      userId: widget.uid, user: widget.user),
                ),
              );
            },
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
              size: MyDim.fontSizebetween,
            ),
          ),
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Image(
                  image: ResizeImage(AssetImage('Assets/images/blackLogo.png'),
                      width: 1000, height: 800),
                ),
                // child: Text('Monkez',style: TextStyle(fontSize: MyDim.fontSizebetween, fontWeight: FontWeight.w700),),
                decoration: BoxDecoration(
                  // image: 'Assets/images/logoblack.png',
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: Text(
                  'My Profile',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => userprofile(
                            uid: widget.uid,
                            user: widget.user,
                            getImageData: getImageData,
                          )));
                },
              ),

              ListTile(
                title: Text(
                  'Service Needs',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ServiceNeeds(
                            user: widget.user,
                            uid: widget.uid,
                          )));
                },
              ),
              ListTile(
                title: Text(
                  'Travel Guide',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TravelGuide(
                            uid: widget.uid,
                            user: widget.user,
                          )));
                },
              ),
              ListTile(
                title: Text('Contact Us' , style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUS(
                    uid: widget.uid,
                    user: widget.user,
                  )));
                }, ),
              ListTile(
                title: Text(
                  'Nearest Building',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NearestBuilding(
                            user: widget.user,
                            uid: widget.uid,
                          )));
                },
              ),
              ListTile(
                title: Text(
                  'Guidance',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Guidance(
                            uid: widget.uid,
                            user: widget.user,
                          )));
                },
              ),
              ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Logout"),
                        content: Text("Are you sure you want to logout?"),
                        actions: [
                          TextButton(
                            child: Text("no"),
                            onPressed: () {
                              // Close the dialog and do nothing
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text("yes"),
                            onPressed: () {
                              // Close the dialog and sign the user out
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => WelcomePage()));

                            },
                          ),
                        ],
                      );
                    },
                  );
                },

              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Text(
                    ''
                    'Choose Your Category',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 2.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    buildCategory(categories[index]),
                separatorBuilder: (context, index) => SizedBox(
                  height: 20.0,
                ),
                itemCount: categories.length,
              )
            ],
          ),
        ));
  }

// build item
  Widget buildCategory(CategoryModel category) => GestureDetector(
        onTap: () {
          if (category.title == 'Personal Identification') {
            // Your code here
            print('Personal');
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SetProfile2(uid: widget.uid, user: widget.user)));
            });
          } else if (category.title == 'Money Related') {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MoneyRelated(user: widget.user, uid: widget.uid)));
            });
          } else if (category.title == 'Education') {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Education(user: widget.user, uid: widget.uid)));
            });
          } else if (category.title == 'Vaccines') {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Vaccines(user: widget.user, uid: widget.uid)));
            });
          } else if (category.title == 'Your Personal Photos') {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Photos(user: widget.user, uid: widget.uid)));
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFF00CDD0),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      '${category.photoUrl}',
                      height: 60.0,
                      width: 50.0,
                    ),
                  ),
                  Text(
                    "${category.title}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
