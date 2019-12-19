import 'package:flutter/material.dart';
import 'package:unicom_flutter/utils/screenUtil.dart';

class MyAsset extends StatelessWidget {
  final String name;
  final double width;
  MyAsset({@required this.name, @required this.width});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      name,
      width: setWidth(width),
      fit: BoxFit.contain,
    );
  }
}
