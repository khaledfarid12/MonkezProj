import 'package:flutter/material.dart';
import '../Constants/designConstants.dart';
import 'Dimensions.dart';

class InstructionsPopUp extends StatelessWidget {
  const InstructionsPopUp({
    required this.onpressed,
    required this.steps,
    super.key,
  });
  final Text steps;
  final Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      title: Text("Here are the instructions: ",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
      content: SingleChildScrollView(child: steps),
      actions: [
        TextButton(
          child: Text("Done"),
          onPressed: onpressed,
        )
      ],
    );
  }
}

Text NationalID() {
  return Text(
    "In case you want to get your National ID:\n "
        "\n"
        "1st step: Fill out the data of the national ID form and approve it from the entity to which it belongs, whether the student or the employee.\n"
        "\n"
        "\n"
        "2nd step:Submit the application and the required documents indicating the data to the competent employee.\n"
        "\n"
        "\n"
        "3rd step:After stamping the form and photocopying, the service will be received within the time period.\n"
        "\n"
        "\n"
        "Documents required to obtain the ID card for the first time:\n "
        "\n"
        "1 - The documents required to obtain the ID card for the first time for the student first include purchasing the national ID form from the civil status offices, as well as submitting documents indicating proof of identity such as birth certificate, as well as place of residence, job, marital status, and the presence of a guarantor from the degree of kinship to the fourth degree.\n"
        "\n"
        "2 - In the case of obtaining the national ID card for the first time for the student, the national ID form must be stamped from the student affairs at the school before submitting it to the civil status offices to complete the procedures for issuing the card.\n"
        "\n" ,
    style: TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
  );
}

Text Passport() {
  return Text(
    "In case you want to get your Paasport:\n "
    "1st step: A copy of the national ID card in addition to the original for review\n"
        "\n"
        "\n"
        "2nd step: Submit 4 personal photos, with a white background, size 4 by 6, with a recent date.'.\n "
        "\n"
        "\n"
        "3th step: Submission of a military certificate, with the aim of proving the position of conscription of males.\n"
        "\n"
        "\n"
        "4th step: Provide a copy of the applicant's qualification certificate to obtain the passport, if it is not registered on the national ID card\n"
        "\n"
        "\n"
        "5th step:Provide proof of marital status for females.\n"
        "\n"
        "\n"
        "6th step:Presentation of previous passport.\n"
        "\n"
        "\n"
        "7th step:Bring mechanized birth certificates for children, and add the father's national number to the certificate.\n"
        "\n"
        "\n"
        "8th step:After that, you must go to the passport authority closest to the place of residence and obtain Form 29 passports, and complete all the required data in the form, then go to the office to review the papers and paste the photos\n"
        "\n"
        "\n"
    ,

    style: TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
  );
}

Text BirthCertificate() {
  return Text("The individual has either to extract it through the civil registry office or from the post office, and it can be extracted via the Internet\n"
      "\n"
      "\n"
    "1st step: National ID card in order to prove the identity of the competent employee\n"
        "\n"
        "\n"
        "2nd step:A copy of the birth certificate to be extracted\n "
        "\n"
        "\n"
        "3rd step: Submit an application Form 40 and it is purchased through the Commercial Registry Office\n"
        "\n"
        "\n"
      "4th step:These papers shall be submitted to the competent employee.\n "
      "\n"
      "\n"
        ,
    style: TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
  );
}

Text DriverLisence() {
  return Text(
    "1st step: Going to the traffic according to the place of residence recorded in the national ID card.\n"
        "\n"
        "\n"
        "2nd step: Bring Form 256 to the traffic to obtain the license.\n "
        "\n"
        "\n"
        "3rd step:  Submit a copy of the national ID card with access to the original\n"
        "\n"
        "\n"
        "4th step:A copy of the graduation certificate with access to the original.\n"
        "\n"
        "\n"
        "5th step: The license applicant extracts two medical certificates (internal and ophthalmic) stating medical fitness and now they are done at the traffic unit.\n"
        "\n"
        "\n"
        "6th step: Blood type and is performed in the traffic unit.\n"
        "\n"
        "\n"
        "7th step: Submit 4 personal photos 4 * 6 recent.\n"
        "\n"
        "\n"
        "8th step:The age of the applicant should not be less than 18 years. \n"
        "\n"
        "\n"
        "9th step: Submit a drug analysis from the approved authorities before handing over the driver's license.\n"
        "\n"
        "\n"
        "10th step: The applicant must pass the driving training course at the Muroor Education Center.\n"
        "\n"
        "\n"
        "11th step: The applicant must not have been convicted of a criminal judgment or a misdemeanor involving moral turpitude and dishonesty.\n"
        "\n"
        "\n"

       ,
    style: TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
  );
}