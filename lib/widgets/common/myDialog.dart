/*
 * @Author: liangyt
 * @Date: 2020-01-16 17:19:20
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-17 10:20:15
 * @Description: ios 弹窗
 * @FilePath: /unicom_flutter/lib/widgets/common/myCuperDialog.dart
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';

class MyDialog extends Dialog {
  final String title;
  final Widget content;
  final bool isOnly;
  final bool hasHead;
  final Function submit;
  final Function cancel;
  MyDialog(
      {this.title,
      this.content,
      this.isOnly = false,
      this.hasHead = true,
      this.cancel,
      @required this.submit});
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MyScreen.setWidth(600),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _title(),
                  content != null ? content : Container(),
                  _actions(context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // 标题
  Widget _title() {
    if (!hasHead) {
      return Container();
    }
    return Container(
      height: MyScreen.setHeight(78),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: MyStyles.borderColor))),
      child: Text(title, style: MyStyles.f30c33),
    );
  }

  // 按钮
  Widget _actions(context) {
    List<Widget> _list = [
      MaterialButton(
        onPressed: submit,
        child: Text('确定', style: MyStyles.f36c03),
      )
    ];
    if (!isOnly) {
      _list
        ..insert(
            0,
            MaterialButton(
              onPressed: () {
                if (cancel == null) {
                  Navigator.pop(context);
                } else {
                  cancel();
                }
              },
              child: Text(
                '取消',
                style: MyStyles.f36c66,
              ),
            ));
    }
    return Container(
      height: MyScreen.setHeight(100),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 1, color: MyStyles.borderColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _list,
      ),
    );
  }
}
