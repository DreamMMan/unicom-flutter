/*
 * @Author: liangyt
 * @Date: 2020-01-02 17:17:06
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-02 17:18:56
 * @Description: 圆
 * @FilePath: /unicom_flutter/lib/widgets/common/myClipOval.dart
 */
import 'package:flutter/material.dart';
import 'package:unicom_flutter/styles/myScreen.dart';

class MyClipOval extends StatelessWidget {
  final double size;
  final Color color;
  MyClipOval({this.size, this.color});
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: MyScreen.setWidth(size),
        height: MyScreen.setWidth(size),
        color: color,
      ),
    );
  }
}
