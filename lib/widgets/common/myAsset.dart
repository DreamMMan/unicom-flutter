import 'package:flutter/material.dart';
import 'package:unicom_flutter/styles/myScreen.dart';

class MyAsset extends StatelessWidget {
  final String name;
  final double width;
  MyAsset({@required this.name, @required this.width});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      name,
      width: MyScreen.setWidth(width),
      fit: BoxFit.contain,
    );
  }
}
