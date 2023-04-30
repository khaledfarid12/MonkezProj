import 'package:flutter/material.dart';
import '../Constants/Dimensions.dart';
import '../Constants/DocumentButton.dart';
import '../Constants/guidanceData.dart';
import 'package:image/image.dart' as IMG;
import '../Constants/designConstants.dart';

class Guidance extends StatefulWidget {
  const Guidance({Key? key}) : super(key: key);

  @override
  State<Guidance> createState() => _GuidanceState();
}

class _GuidanceState extends State<Guidance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Image(
          image: AssetImage('Assets/images/menu.png'),
        ),
        actions: [
          Image(
            image: AssetImage('Assets/images/settings.png'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image(
                  image: AssetImage('Assets/images/back1.png'),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.cyan, width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: ResizeImage(
                            AssetImage('Assets/images/guidance.png'),
                            width: 50,
                            height: 70),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Guidance',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Which document do you want to inquire about ?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 1.2,
              endIndent: MyDim.paddingUnit * 3,
              indent: MyDim.paddingUnit * 3,
            ),
            DocumentButton(
                image: 'Assets/images/green-card.png',
                label: 'National ID',
                clickdoc: openDialogID),
            DocumentButton(
                image: 'Assets/images/certificate.png',
                label: 'High school certificate',
                clickdoc: openDialogHS),
            DocumentButton(
                image: 'Assets/images/driver-license.png',
                label: 'Driver’s license',
                clickdoc: openDialogDriver),
            DocumentButton(
                image: 'Assets/images/birthcertificate.png',
                label: 'Birth Certificate',
                clickdoc: openDialogBirth),
            DocumentButton(
                image: 'Assets/images/passport.png',
                label: 'Passport',
                clickdoc: openDialogPassport),
            SizedBox(
              height: MyDim.SizedBoxsmall,
            ),
          ],
        ),
      ),
    );
  }

  Future openDialogID() => showDialog(
      context: context,
      builder: (context) =>
          InstructionsPopUp(onpressed: Done, steps: NationalID()));

  Future openDialogHS() => showDialog(
      context: context,
      builder: (context) =>
          InstructionsPopUp(onpressed: Done, steps: HighSchool()));
  Future openDialogDriver() => showDialog(
      context: context,
      builder: (context) =>
          InstructionsPopUp(onpressed: Done, steps: DriverLisence()));
  Future openDialogBirth() => showDialog(
      context: context,
      builder: (context) =>
          InstructionsPopUp(onpressed: Done, steps: BirthCertificate()));
  Future openDialogPassport() => showDialog(
      context: context,
      builder: (context) =>
          InstructionsPopUp(onpressed: Done, steps: Passport()));

  void Done() {
    Navigator.of(context).pop();
  }
}
