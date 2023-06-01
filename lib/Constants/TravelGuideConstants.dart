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
      title: Text("Instructions to be followed: ",
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

Text Albania() {
  return Text(
    "- Albania is one of the countries that doesn't require a visa for egyptians to travel, so there is no fee for entering Albania. Also you have the right to stay in Albania for up to 90 days.\n "
    "\n"
    "- Documents needed to enter Albania :"
    "\n"
    "\n"
    "1) A passport that is valid, and valid for at least 6 months.\n"
    "\n"
    "2) An invitation from the guarantor in Albania (the invitation should include: the name of the guarantor or the host, the address of the guarantor, and the contact number in Albania)..\n"
    "\n"
    "3) A confirmed return air ticket to the home country (for the traveler: the travel ticket must be from the traveler's country to Albania, and the return: from Albania to the country from which he traveled).\n"
    "\n"
    "4) Confirmed document proving the person's stay during the visit period (confirmed hotel reservation).\n "
    "\n",
    style: TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
  );
}

Text Lebanon() {
  return Text(
    "- Lebanon is one of the countries that require a visa for egyptians to travel\n "
    "\n"
    "- In order to get a Lebanon visa you should follow the following steps. \n"
    "\n"
    "- It's done by submitting an application to the Lebanese Embassy in Cairo or the Consulate General in Alexandria or from Beirut airport.\n "
    "\n"
    "\n"
    "1st step: Entry visa from the embassy.\n"
    "\n"
    "- The entry visa to Lebanon is valid for a period of 90 days, starting from the date of issue, for a period of 15 days, one month, three months, or six months, and the residence period is valid starting from the date of entry to Lebanon."
    "\n"
    "\n"
    "- Types of visas and their fees:\n"
    "\n"
    "Single entry visa: 615 EGP \n"
    "\n"
    "Double entry visa: 875 EGP \n"
    "\n"
    "Multiple entry visa: 1225 EGP \n"
    "\n"
    "\n"
    "- Required documents :"
    "\n"
    "\n"
    "1) Fill out the visa application."
    "\n"
    "\n"
    "2) Passport with a copy of it"
    "\n"
    "\n"
    "3) Non-simultaneous photo."
    "\n"
    "\n"
    "4) A letter from the company or sponsor stating the salary and job of the visa applicant (HR Letter). \n"
    "\n"
    "5) Bank statement in the commercial register and the tax card for businessmen and self-employed persons. "
    "\n"
    "\n"
    "6) A hotel reservation or an invitation from a Lebanese person with a copy of his passport and his full address in Lebanon. "
    "\n"
    "\n"
    "7) An invitation from the host (company, association, ministry, etc...) if the visit is for work or to attend a conference, seminar or training course."
    "\n"
    "\n"
    "8) In the event that the accompanying servant travels, the person concerned must sign an undertaking to enter and leave Lebanese territory with his servant, in addition to the condition that there is valid residence in Egypt on the servant’s passport for a period of at least one year."
    "\n"
    "\n"
    "9) The signature of the father, who is married to a Lebanese woman, on an affidavit allowing his children to travel to Lebanon \n"
    "Note: The Embassy reserves the right to accept or reject any visa application"
    "\n"
    "\n"
    "2nd step: An entry visa from Beirut airport.\n"
    "- An entry visa can be obtained for a period of one month, extendable up to three months, at Beirut Airport for Egyptians \n"
    "\n"
    "- Required documents : "
    "\n"
    "\n"
    "1) Round-trip airfare is non-refundable."
    "\n"
    "\n"
    "2) Reservation of a hotel or a complete and clear private address with a phone number in Lebanon."
    "\n"
    "\n"
    "3) An amount equivalent to two thousand US dollars in cash or a certified check of the same value from an identifying bank."
    "\n"
    "\n"
    "4) Visa fee: 20 dollars "
    "\n"
    "\n"
    "5) Fill out the visa application"
    "\n"
    "\n"
    "6) Passport and a copy of it."
    "\n"
    "\n"
    "7) Non-simultaneous photo.",
    style: TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
  );
}

Text Maldives() {
  return Text(
    "- Maldives is one of the countries that require a visa for egyptians only when they arrive there."
    "\n"
    "\n"
    "- Tourist visa is granted to all nationalities upon arrival in the Maldives. Therefore, if you want to travel to the Maldives, you will not worry about the procedures for obtaining a prior visa.\n "
    "\n"
    "- The traveler must fulfill some conditions to obtain the visa: \n"
    "\n"
    "1) A passport or travel document with a machine readable zone (MRZ) valid for at least one month.\n"
    "\n"
    "2) Prepaid hotel reservation/accommodation.\n"
    "\n"
    "3) Financial competence to cover the period of his stay.\n"
    "\n"
    "4) Confirmed one way/return tickets to home country or to country of residence (not applicable for holders of valid residence permits).\n"
    "\n"
    "5) Entry facilities to their subsequent destinations, for example, visa.\n"
    "\n"
    "6) The Traveler's Pass must be completed and submitted by all travelers to and from the Maldives within 72 hours of the flight time.\n",
    style: TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
  );
}

Text Malaysia() {
  return Text(
    "Malaysia is from the countries that doesn't require a visa when travelling for work or tourism.\n"
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
    "\n",
    style: TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
  );
}
