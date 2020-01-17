/*
 * @Author: liangyt
 * @Date: 2020-01-17 11:24:03
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-17 11:33:30
 * @Description: 添加DTU 更换DTU
 * @FilePath: /unicom_flutter/lib/widgets/common/myDtuDialog.dart
 */
import 'package:flutter/material.dart';
import 'package:unicom_flutter/constant/myConstant.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/myAsset.dart';
import 'package:unicom_flutter/widgets/common/myDialog.dart';
import 'package:unicom_flutter/widgets/common/myInput.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class MyDtuDialog extends StatelessWidget {
  final String name;
  final String imei;
  final Function fieldCallBack;
  final Function scan;
  final Function cancel;
  final Function submit;
  MyDtuDialog(
      {@required this.name,
      @required this.imei,
      @required this.fieldCallBack,
      @required this.scan,
      @required this.cancel,
      this.submit});
  @override
  Widget build(BuildContext context) {
    return MyDialog(
      title: name,
      content: Container(
        padding: MyScreen.setEdge(top: 80, bottom: 80),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MyScreen.setWidth(500),
              height: MyScreen.setHeight(100),
              padding: MyScreen.setEdge(left: 60, right: 30),
              child: MyInput(
                inintValue: imei,
                hintText: '请扫码或输入设备IMEI',
                hintStyle: MyStyles.f30c99,
                blackEegExp: ' ',
                paddingHeight: 25,
                fieldCallBack: (val) {
                  fieldCallBack(val);
                },
              ),
            ),
            InkWell(
              onTap: () async {
                String cameraScanResult = await scanner.scan();
                scan(cameraScanResult);
              },
              child: MyAsset(name: MyConstant.scan, width: 36),
            )
          ],
        ),
      ),
      cancel: cancel,
      submit: submit,
    );
  }
}
