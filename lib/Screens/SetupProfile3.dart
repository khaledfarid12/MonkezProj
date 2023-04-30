import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Constants/designConstants.dart';
import '../Constants/Dimensions.dart';
import '../Constants/setUp3Data.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import '../Constants/buildButton.dart';
import 'package:path/path.dart' as p;
import 'signup_form_widgets.dart';

class SetupProfile3 extends StatefulWidget {
  final String uid;
  const SetupProfile3({Key? key, required this.uid}) : super(key: key);

  @override
  State<SetupProfile3> createState() => _SetupProfile3State();
}

class _SetupProfile3State extends State<SetupProfile3> {
  String? selecteditem = 'Cairo';
  late int _locationvalue;
  late int _imagevalue;
  String dropdownvalue = ' ';

  bool? Nationalid = false;
  bool? driverLisence = false;
  bool? birthCirt = false;
  bool? HSCirt = false;
  bool? passport = false;
  bool? visa = false;
  bool? vaccine = false;
  bool? selected = false;
  File? image;

  String nid = "National ID";
  String dlis = "Driver's license";
  String birth = "Birth Certificate";
  String hs = "High School Graduation Certificate";
  String pass = "Passport";
  String acq = "Acquired Visas";
  String vacc = "Vaccines";
  List<String> publicDocs = [];

//text editing controller for text field
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      final tempImg = File(image.path);
      setState(() {
        this.image = tempImg;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future uploadinfo() async {
    if (image != null) {
      final path = 'userAvatars/${p.basename(image!.path)}';
      final ref = FirebaseStorage.instance.ref().child(path);
      ref.putFile(image!);

      FirebaseFirestore.instance.collection("users").doc(widget.uid).update({
        'location': dropdownvalue,
        'birthDate': dateinput.text,
        'imagePath': path,
        'publicDocs': publicDocs,
      });
    } else {
      FirebaseFirestore.instance.collection("users").doc(widget.uid).update({
        'location': dropdownvalue,
        'birthDate': dateinput.text,
        'imagePath': 'No avatar',
        'publicDocs': publicDocs,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Setup Profile 3',
          style: TextStyle(
            color: Colors.white,
            fontSize: MyDim.fontSizebetween,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: MyDim.fontSizeButtons,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Add an avatar text
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15),
              child: Text.rich(
                TextSpan(
                  text: 'Add an avatar',
                  style: const TextStyle(
                    color: Colors.transparent,
                    decorationColor: Colors.cyan,
                    shadows: [
                      Shadow(color: Colors.black, offset: Offset(0, -10))
                    ],
                    decoration: TextDecoration.underline,
                    decorationThickness: 3,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ), // default text style
                  children: <TextSpan>[
                    TextSpan(
                      text: '      (Optional) ',
                      style: TextStyle(
                        fontSize: 18,
                        shadows: [
                          Shadow(
                              color: Colors.black.withOpacity(0.6),
                              offset: const Offset(0, -10))
                        ],
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Circle avatar + choose image button
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: image != null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipOval(
                              child: CircleAvatar(
                                radius: 60,
                                child: Image.file(
                                  image!,
                                  width: 150,
                                  height: 170,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : const CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                AssetImage('Assets/images/circleAvatar.png'),
                          ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: DropdownButton(
                      alignment: AlignmentDirectional.topCenter,
                      hint: Text(
                        "Choose image",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      icon: Visibility(
                          visible: false, child: Icon(Icons.arrow_downward)),
                      items: [
                        DropdownMenuItem(
                            value: 1,
                            child: buildButton(
                                title: 'Choose from gallery',
                                icon: Icons.image_search,
                                onClicked: () =>
                                    pickImage(ImageSource.gallery))),
                        DropdownMenuItem(
                            value: 2,
                            child: buildButton(
                                title: 'Take a photo',
                                icon: Icons.camera_alt_outlined,
                                onClicked: () =>
                                    pickImage(ImageSource.camera))),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _imagevalue = value!;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),

            //Add your location text
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15),
              child: Text.rich(
                TextSpan(
                  text: 'Add your location',
                  style: const TextStyle(
                    color: Colors.transparent,
                    decorationColor: Colors.cyan,
                    shadows: [
                      Shadow(color: Colors.black, offset: Offset(0, -10))
                    ],
                    decoration: TextDecoration.underline,
                    decorationThickness: 3,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ), // default text style
                  children: <TextSpan>[
                    TextSpan(
                      text: '    (Optional) ',
                      style: TextStyle(
                        fontSize: 18,
                        shadows: [
                          Shadow(
                              color: Colors.black.withOpacity(0.6),
                              offset: const Offset(0, -10))
                        ],
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //drop down location
            Center(
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: DropdownButtonFormField(
                  menuMaxHeight: 250,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(width: 3, color: Colors.black),
                    ),
                  ),
                  alignment: Alignment.center,
                  items: LocationList(),
                  onChanged: (value) {
                    setState(() {
                      dropdownvalue = value;
                    });
                  },
                  hint: Text("   Choose your location", style: kHintTextStyle),
                ),
              ),
            ),

            //Birthdate text
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, bottom: 10),
              child: Text.rich(
                TextSpan(
                  text: 'Birthdate',
                  style: const TextStyle(
                    color: Colors.transparent,
                    decorationColor: Colors.cyan,
                    shadows: [
                      Shadow(color: Colors.black, offset: Offset(0, -10))
                    ],
                    decoration: TextDecoration.underline,
                    decorationThickness: 3,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ), // default text style
                  children: <TextSpan>[
                    TextSpan(
                      text: '    (Optional) ',
                      style: TextStyle(
                        fontSize: 18,
                        shadows: [
                          Shadow(
                              color: Colors.black.withOpacity(0.6),
                              offset: const Offset(0, -10))
                        ],
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //calender + date textfield
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: TextField(
                  controller: dateinput, //editing controller of this TextField
                  decoration: InputDecoration(
                    icon: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(Icons.calendar_today, color: Colors.cyan),
                    ), //icon of text field
                    labelText: "  Enter a date",
                    labelStyle: kHintTextStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(width: 3, color: Colors.black),
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2001),
                        firstDate: DateTime(
                            1920), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2009));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        dateinput.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
            ),

            //pick docs text
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Text.rich(
                TextSpan(
                  text: 'Pick the documents you want',
                  style: const TextStyle(
                      color: Colors.transparent,
                      decorationColor: Colors.cyan,
                      shadows: [
                        Shadow(color: Colors.black, offset: Offset(0, -10))
                      ],
                      decoration: TextDecoration.underline,
                      decorationThickness: 3,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      wordSpacing: 2,
                      height: 1.4),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "to be public",
                  style: TextStyle(
                      color: Colors.transparent,
                      decorationColor: Colors.cyan,
                      shadows: [
                        Shadow(color: Colors.black, offset: Offset(0, -10))
                      ],
                      decoration: TextDecoration.underline,
                      decorationThickness: 3,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      wordSpacing: 2,
                      height: 1.4),
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: MyDim.paddingUnit * 1.5),
                Padding(
                  padding: const EdgeInsets.only(right: 12, bottom: 9),
                  child: Text(
                    "(Optional)",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ),

            //checkboxes+ finish button
            Column(
              children: [
                CheckboxListTile(
                  value: Nationalid,
                  controlAffinity:
                      ListTileControlAffinity.leading, //checkbox at left
                  onChanged: (bool? value) {
                    setState(() {
                      Nationalid = value;
                      if (Nationalid == true) {
                        publicDocs.add(nid);
                      } else {
                        publicDocs.remove(nid);
                      }
                    });
                  },
                  title: Text(
                    nid,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                CheckboxListTile(
                  value: driverLisence,
                  controlAffinity:
                      ListTileControlAffinity.leading, //checkbox at left
                  onChanged: (bool? value) {
                    setState(() {
                      driverLisence = value;
                      if (driverLisence == true) {
                        publicDocs.add(dlis);
                      } else {
                        publicDocs.remove(dlis);
                      }
                    });
                  },
                  title: Text(
                    dlis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                CheckboxListTile(
                  value: birthCirt,
                  controlAffinity:
                      ListTileControlAffinity.leading, //checkbox at left
                  onChanged: (bool? value) {
                    setState(() {
                      birthCirt = value;
                      if (birthCirt == true) {
                        publicDocs.add(birth);
                      } else {
                        publicDocs.remove(birth);
                      }
                    });
                  },
                  title: Text(
                    birth,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                CheckboxListTile(
                  value: HSCirt,
                  controlAffinity:
                      ListTileControlAffinity.leading, //checkbox at left
                  onChanged: (bool? value) {
                    setState(() {
                      HSCirt = value;
                      if (HSCirt == true) {
                        publicDocs.add(hs);
                      } else {
                        publicDocs.remove(hs);
                      }
                    });
                  },
                  title: Text(
                    hs,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                CheckboxListTile(
                  value: passport,
                  controlAffinity:
                      ListTileControlAffinity.leading, //checkbox at left
                  onChanged: (bool? value) {
                    setState(() {
                      passport = value;
                      if (passport == true) {
                        publicDocs.add(pass);
                      } else {
                        publicDocs.remove(pass);
                      }
                    });
                  },
                  title: Text(
                    pass,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                CheckboxListTile(
                  value: visa,
                  controlAffinity:
                      ListTileControlAffinity.leading, //checkbox at left
                  onChanged: (bool? value) {
                    setState(() {
                      visa = value;
                      if (visa == true) {
                        publicDocs.add(acq);
                      } else {
                        publicDocs.remove(acq);
                      }
                    });
                  },
                  title: Text(
                    acq,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                CheckboxListTile(
                  value: vaccine,
                  controlAffinity:
                      ListTileControlAffinity.leading, //checkbox at left
                  onChanged: (bool? value) {
                    setState(() {
                      vaccine = value;
                      if (vaccine == true) {
                        publicDocs.add(vacc);
                      } else {
                        publicDocs.remove(vacc);
                      }
                    });
                  },
                  title: Text(
                    vacc,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: MyDim.paddingUnit * 4, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.cyan[400]),
                        width: 150,
                        height: 65,
                        child: TextButton(
                          onPressed: uploadinfo,
                          child: Text(
                            'Finish',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: MyDim.fontSizeButtons),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MyDim.paddingUnit * 2,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Skip',
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
