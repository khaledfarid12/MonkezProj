// import 'package:flutter/material.dart';
// import 'package:gradproj/Constants/Dimensions.dart';
// import '../Screens/ContactUs.dart';
// import '../Screens/Login.dart';
// import '../Screens/ServiceNeeds.dart';
// import '../Screens/SetupProfile3.dart';
// import '../Screens/profile.dart';
// import '../Screens/welcome_page.dart';
// import '../Screens/Guidance.dart';
// import '../Screens/travelScan.dart';
//
//
// class admin extends StatefulWidget {
//   const admin({Key? key}) : super(key: key);
//
//   @override
//   State<admin> createState() => _adminState();
// }
//
// class _adminState extends State<admin> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         drawer: new Drawer(),
//         appBar: new AppBar(
//           backgroundColor: Color(0xFF00CDD0),
//           leading: IconButton(
//             onPressed: () {},
//             icon: Icon(
//               Icons.settings,
//               color: Colors.white,
//               size: MyDim.fontSizebetween,
//             ),
//           ),
//         ),
//         endDrawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: <Widget>[
//               DrawerHeader(
//                 child: Image(
//                   image: ResizeImage(AssetImage('Assets/images/blackLogo.png'),
//                       width: 1000, height: 800),
//                 ),
//                 // child: Text('Monkez',style: TextStyle(fontSize: MyDim.fontSizebetween, fontWeight: FontWeight.w700),),
//                 decoration: BoxDecoration(
//                   // image: 'Assets/images/logoblack.png',
//                   color: Colors.black,
//                 ),
//               ),
//               ListTile(
//                 title: Text(
//                   'Family Community',
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context); // Close the drawer
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => userprofile()));
//                 },
//               ),
//               ListTile(
//                 title: Text(
//                   'Service Needs',
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context); // Close the drawer
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => ServiceNeeds()));
//                 },
//               ),
//               ListTile(
//                 title: Text(
//                   'Travel Guide',
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context); // Close the drawer
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => TravelGuide()));
//                 },
//               ),
//               ListTile(
//                 title: Text(
//                   'Contact Us',
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context); // Close the drawer
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => ContactUS(
//                                 uid: '',
//                               )));
//                 },
//               ),
//               ListTile(
//                 title: Text(
//                   'Nearest Building',
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context); // Close the drawer
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => NearestBuilding()));
//                 },
//               ),
//               ListTile(
//                 title: Text(
//                   'Guidance',
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context); // Close the drawer
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => Guidance()));
//                 },
//               ),
//               ListTile(
//                 title: Text(
//                   'Edit Profile',
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context); // Close the drawer
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => SetupProfile3()));
//                 },
//               ),
//               ListTile(
//                 title: Text(
//                   'Logout',
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context); // Close the drawer
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => WelcomePage()));
//                 },
//               ),
//             ],
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Stack(
//             children: [
//               Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Container(
//                           height: MyDim.myHeight(context) * 0.25,
//                           child: Image.asset(
//                             'Assets/images/triangle.png',
//                           )),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: MyDim.paddingUnit * 9,
//                             right: MyDim.paddingUnit * 5.2),
//                         child: Text(
//                           'Admin Dashboard',
//                           style: TextStyle(
//                               fontSize: MyDim.fontSizebetween,
//                               fontWeight: FontWeight.w700),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5.0,
//                   ),
//
//                   Divider(
//                     thickness: 1,
//                     color: Colors.black,
//                     endIndent: MyDim.paddingUnit * 3,
//                     indent: MyDim.paddingUnit * 3,
//                   ),
//                   SizedBox(
//                     height: 30.0,
//                   ),
//
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       right: MyDim.paddingUnit * 7.3,
//                     ),
//                     child: GestureDetector(
//                       child: Text(
//                         'Adding/Deleting users',
//                         style: TextStyle(
//                           fontSize: 25.0,
//                         ),
//                       ),
//                       onTap: () {
//                         setState(() {});
//                       },
//                     ),
//                   ),
//
//                   SizedBox(
//                     height: 39.0,
//                   ),
//
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(left: MyDim.paddingUnit * 0.7),
//                     child: SizedBox(
//                       width: 370.0,
//                       child: Text(
//                         'Collecting and responding to feedbacks',
//                         style: TextStyle(
//                           fontSize: 24.0,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(
//                     height: 37.0,
//                   ),
//
//                   //Username
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(right: MyDim.paddingUnit * 7.5),
//                     child: GestureDetector(
//                       child: Text(
//                         'Resetting passwords  ',
//                         style: TextStyle(
//                           fontSize: 25.0,
//                         ),
//                       ),
//                       onTap: () {
//                         setState(() {});
//                       },
//                     ),
//                   ),
//
//                   SizedBox(
//                     height: 37.0,
//                   ),
//
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       right: MyDim.paddingUnit * 5,
//                       left: MyDim.paddingUnit * 1.8,
//                     ),
//                     child: GestureDetector(
//                       child: Text(
//                         'Assigning user roles and permissions',
//                         style: TextStyle(
//                           fontSize: 25.0,
//                         ),
//                       ),
//                       onTap: () {
//                         setState(() {});
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     height: 37.0,
//                   ),
//                   Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                         color: Color(0xFF00CDD0),
//                       ),
//                       width: MyDim.myWidth(context) * 0.4,
//                       child: TextButton(
//                           onPressed: () {
//                             setState(() {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => LoginScreen()));
//                             });
//                           },
//                           child: Text(
//                             'Logout',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: MyDim.fontSizeButtons),
//                           ))),
//                 ],
//               )
//             ],
//           ),
//         ));
//   }
// }
