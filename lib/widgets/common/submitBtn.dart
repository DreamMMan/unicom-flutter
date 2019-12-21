/*
 * @Author: liangyt
 * @Date: 2019-12-19 11:17:18
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-19 11:17:24
 * @Description: 提交按钮
 * @FilePath: /unicom_flutter/lib/widgets/submitBtn.dart
 */
import 'package:flutter/material.dart';

class SubmitBtn extends StatelessWidget {
  final Color buttonColor;
  final TextStyle textSty;
  final String txt;
  final Function submit;
  SubmitBtn({this.buttonColor, this.textSty, @required this.txt, this.submit});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: buttonColor,
      onPressed: submit,
      onLongPress: submit,
      child: Text(
        txt,
        style: textSty,
      ),
    );
  }
}
