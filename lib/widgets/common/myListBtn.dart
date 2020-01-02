/*
 * @Author: liangyt
 * @Date: 2020-01-02 16:45:06
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-02 16:50:38
 * @Description: 列表右边
 * @FilePath: /unicom_flutter/lib/widgets/common/myListBtn.dart
 */
import 'package:flutter/material.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';

class MyListBtn extends StatelessWidget {
  final String name;
  final TextStyle style;
  final Color bgColor;
  MyListBtn({@required this.name, this.bgColor, this.style});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MyScreen.setEdgeAll(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MyScreen.setWidth(5)),
        color: bgColor != null ? bgColor : MyStyles.f8f8f8,
      ),
      child: Text(
        name,
        style: style != null ? style : MyStyles.f26c99,
      ),
    );
  }
}
