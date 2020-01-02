/*
 * @Author: liangyt
 * @Date: 2019-12-19 11:17:18
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-02 15:40:03
 * @Description: 提交按钮
 * @FilePath: /unicom_flutter/lib/widgets/submitBtn.dart
 */
import 'package:flutter/material.dart';

class MySubmitBtn extends StatelessWidget {
  final Color buttonColor;
  final TextStyle textSty;
  final String txt;
  final Function submit;
  MySubmitBtn(
      {this.buttonColor,
      this.textSty,
      @required this.txt,
      @required this.submit});

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
