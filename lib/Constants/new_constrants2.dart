import 'package:flutter/material.dart';
import 'package:gradproj/Constants/designConstants.dart';

class governmenatl {
  late String governmental;
}

List<DropdownMenuItem> GovernemtalList() {
  List<DropdownMenuItem>? locationItems;
  locationItems = [
    const DropdownMenuItem(
      value: 1,
      child: Text("Alexandria", style: kMenuItemStyle),
    ),
    const DropdownMenuItem(
      value: 2,
      child: Text(
        "Aswan",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 3,
      child: Text(
        "Asyut",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 4,
      child: Text(
        "Beheira",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 5,
      child: Text(
        "Beni Suef",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 6,
      child: Text(
        "Cairo",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 7,
      child: Text(
        "Dakahlia",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 8,
      child: Text(
        "Damietta",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 9,
      child: Text(
        "Faiyum ",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 10,
      child: Text(
        "Gharbia",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 11,
      child: Text(
        "Giza",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 12,
      child: Text(
        "Ismailia",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 13,
      child: Text(
        "Kafr El Sheikh",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 14,
      child: Text(
        "Luxor",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 15,
      child: Text(
        "Matruh",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 16,
      child: Text(
        "Minya",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 17,
      child: Text(
        "Monufia",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 18,
      child: Text(
        "New Valley",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 19,
      child: Text(
        "North Sinai",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 20,
      child: Text(
        "Port Said",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 21,
      child: Text(
        "Qalyubia",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 22,
      child: Text(
        "Qena",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 23,
      child: Text(
        "Red Sea",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 24,
      child: Text(
        "Sharqia",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 25,
      child: Text(
        "Sohag",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 26,
      child: Text(
        "South Sinai",
        style: kMenuItemStyle,
      ),
    ),
    const DropdownMenuItem(
      value: 27,
      child: Text(
        "Suez",
        style: kMenuItemStyle,
      ),
    ),
  ];
  return locationItems;
}
