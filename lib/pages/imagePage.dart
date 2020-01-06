/*
 * @Author: liangyt
 * @Date: 2020-01-06 23:09:13
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-06 23:45:10
 * @Description: 浏览图片
 * @FilePath: /unicom-flutter/lib/pages/imagePage.dart
 */

import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/providers/imageProvide.dart';
import 'package:photo_view/photo_view.dart';
import 'package:unicom_flutter/providers/lifeAuditProivde.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/mySubmitBtn.dart';

class ImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<ImageProvide>(
      builder: (BuildContext context, child, data) {
        return Container(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              PhotoView(
                imageProvider: FileImage(data.file),
              ),
              Positioned(
                right: MyScreen.setWidth(30),
                top: MyScreen.statusBarHeight + MyScreen.setHeight(50),
                child: Container(
                  width: MyScreen.setWidth(130),
                  height: MyScreen.setHeight(50),
                  child: MySubmitBtn(
                    buttonColor: Colors.green,
                    txt: '删除',
                    textSty: MyStyles.f30cff,
                    submit: () {
                      Provide.value<LifeAuditProvide>(context).removeImage();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Positioned(
                left: MyScreen.setWidth(30),
                top: MyScreen.statusBarHeight + MyScreen.setHeight(50),
                child: Container(
                  width: MyScreen.setWidth(130),
                  height: MyScreen.setHeight(50),
                  child: MySubmitBtn(
                    buttonColor: Colors.white,
                    txt: '取消',
                    textSty: MyStyles.f30c33,
                    submit: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
