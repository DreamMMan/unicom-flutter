/*
 * @Author: liangyt
 * @Date: 2020-01-16 17:19:20
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-16 17:28:20
 * @Description: ios 弹窗
 * @FilePath: /unicom_flutter/lib/widgets/common/myCuperDialog.dart
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unicom_flutter/styles/myStyles.dart';

class MyCuperDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final bool isOnly;
  final Function submit;
  MyCuperDialog(
      {this.title, this.content, this.isOnly = false, @required this.submit});
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title, style: MyStyles.f30c33),
      content: content,
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text("取消"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: Text("确定"),
          onPressed: submit,
        ),
      ],
    );
  }
}
