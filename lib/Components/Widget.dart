import 'package:gradproj/Constants/Data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/Data.dart';

class MyWidget extends StatelessWidget {
  late Category category;
  MyWidget({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Category> _list = FakeData().categoriesList;
    return Scaffold();
  }
}

class BuildItemBox extends StatelessWidget {
  const BuildItemBox({
    Key? key,
    required this.context,
    required this.image,
    required this.name,
  }) : super(key: key);

  final BuildContext context;
  final String image;
  final String name;
  static const double strokeAlignOutside = 1.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFF00CDD0),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              image,
              fit: BoxFit.contain,
              height: 30,
            ),
          ),
          Text(
            name,
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
