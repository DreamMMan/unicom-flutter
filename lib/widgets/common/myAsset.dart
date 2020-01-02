import 'package:flutter/material.dart';
import 'package:unicom_flutter/styles/myScreen.dart';

class MyAsset extends StatelessWidget {
  final String name;
  final double width;
  final double height;
  final BoxFit fit;
  MyAsset(
      {@required this.name,
      @required this.width,
      this.height,
      this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      name,
      width: MyScreen.setWidth(width),
      height: height != null ? MyScreen.setHeight(height) : null,
      fit: fit,
    );
  }
}
