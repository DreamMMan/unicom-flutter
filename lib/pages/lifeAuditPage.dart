/*
 * @Author: liangyt
 * @Date: 2020-01-06 19:42:20
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-15 16:01:09
 * @Description: 生命周期工单审核
 * @FilePath: /unicom-flutter/lib/pages/lifeAuditPage.dart
 */
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/constant/myConstant.dart';
import 'package:unicom_flutter/providers/lifeAuditProivde.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
import 'package:unicom_flutter/widgets/common/myAsset.dart';
import 'package:unicom_flutter/widgets/common/myDialogImage.dart';
import 'package:unicom_flutter/widgets/common/myInput.dart';
import 'package:unicom_flutter/widgets/common/mySubmitBtn.dart';

class LifeAuditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('确认'),
      resizeToAvoidBottomPadding: false,
      body: Provide<LifeAuditProvide>(
        builder: (context, child, data) {
          return Container(
            width: MyScreen.setWidth(750),
            color: MyStyles.pageBg,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _radioWiget(context, data),
                _textareaWidget(context, data),
                _unicomBox(context, data),
                _buttonWidget(context)
              ],
            ),
          );
        },
      ),
    );
  }

  // 单选
  Widget _radioWiget(context, LifeAuditProvide data) {
    return Container(
        constraints: BoxConstraints(minHeight: MyScreen.setHeight(120)),
        color: Colors.white,
        padding: MyScreen.setEdge(left: 30, right: 30),
        child: DefaultTextStyle(
          style: MyStyles.f36c33,
          child: Row(
            children: <Widget>[
              Text.rich(TextSpan(
                  text: '*',
                  style: TextStyle(color: MyStyles.e04545),
                  children: <TextSpan>[
                    TextSpan(
                        text: '确认结果:', style: TextStyle(color: MyStyles.c333))
                  ])),
              Flexible(
                  child: InkWell(
                onTap: () {
                  Provide.value<LifeAuditProvide>(context).setData(ado: true);
                },
                child: Row(
                  children: <Widget>[
                    Radio(
                      value: true,
                      groupValue: data.adopt,
                      onChanged: (value) {
                        Provide.value<LifeAuditProvide>(context)
                            .setData(ado: true);
                      },
                    ),
                    Text('通过'),
                  ],
                ),
              )),
              Flexible(
                  child: InkWell(
                onTap: () {
                  Provide.value<LifeAuditProvide>(context).setData(ado: false);
                },
                child: Row(
                  children: <Widget>[
                    Radio(
                      value: false,
                      groupValue: data.adopt,
                      onChanged: (value) {
                        Provide.value<LifeAuditProvide>(context)
                            .setData(ado: false);
                      },
                    ),
                    Text('退回'),
                  ],
                ),
              )),
            ],
          ),
        ));
  }

  // 文本框
  Widget _textareaWidget(context, LifeAuditProvide data) {
    return Container(
      width: MyScreen.setWidth(750),
      height: MyScreen.setHeight(280),
      color: Colors.white,
      margin: MyScreen.setEdge(top: 20),
      padding: MyScreen.setEdge(left: 30, top: 30, right: 30, bottom: 30),
      child: MyInput(
        inintValue: data.description,
        hintText: '请输入确认说明',
        hintStyle: MyStyles.f30c99,
        paddingHeight: 0,
        maxLines: 10,
        maxLength: 300,
        fieldCallBack: (val) {
          Provide.value<LifeAuditProvide>(context).setData(des: val);
        },
      ),
    );
  }

  // 联通仓库
  Widget _unicomBox(context, LifeAuditProvide data) {
    return Container(
      color: Colors.white,
      margin: MyScreen.setEdge(top: 20),
      padding: MyScreen.setEdge(left: 30, right: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _oddContent(context, data),
          _uploadBox(context, data)
        ],
      ),
    );
  }

  // 入库单号
  Widget _oddContent(context, LifeAuditProvide data) {
    return Container(
      height: MyScreen.setHeight(90),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: MyStyles.borderColor))),
      child: Row(
        children: <Widget>[
          Text.rich(TextSpan(children: <TextSpan>[
            TextSpan(
              text: '*',
              style: TextStyle(color: MyStyles.e04545),
            ),
            TextSpan(text: '入库单号：', style: MyStyles.f36c33)
          ])),
          Expanded(
              child: Container(
            child: MyInput(
              inintValue: data.odd,
              hintText: '请输入联通仓库入库单号',
              hintStyle: MyStyles.f30c99,
              paddingHeight: 25,
              maxLines: 1,
              maxLength: 30,
              fieldCallBack: (val) {
                Provide.value<LifeAuditProvide>(context).setData(od: val);
              },
            ),
          ))
        ],
      ),
    );
  }

  // 上传图片
  Widget _uploadBox(context, LifeAuditProvide data) {
    return Container(
      padding: MyScreen.setEdge(top: 30, bottom: 30),
      child: Provide.value<LifeAuditProvide>(context).oddImage != null
          ? InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext contetx) {
                      return MyDialogImage(
                        index: 0,
                        list: [
                          Provide.value<LifeAuditProvide>(context).oddImage
                        ],
                        isLook: false,
                        type: 0,
                        delete: (int index) {
                          Provide.value<LifeAuditProvide>(context)
                              .removeImage();
                          Navigator.pop(context);
                        },
                      );
                    });
              },
              child: Container(
                width: MyScreen.setWidth(130),
                height: MyScreen.setWidth(130),
                color: MyStyles.f1f1f1,
                child: Image.file(
                  Provide.value<LifeAuditProvide>(context).oddImage,
                  width: MyScreen.setWidth(130),
                  height: MyScreen.setWidth(130),
                ),
              ),
            )
          : InkWell(
              onTap: () async {
                File image =
                    await ImagePicker.pickImage(source: ImageSource.camera);
                Provide.value<LifeAuditProvide>(context)
                    .setData(oddIcon: image);
              },
              child: Container(
                width: MyScreen.setWidth(130),
                height: MyScreen.setWidth(130),
                color: MyStyles.f1f1f1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    MyAsset(name: MyConstant.upload, width: 60),
                    Text('入库照片', style: MyStyles.f22c99)
                  ],
                ),
              ),
            ),
    );
  }

  // 按钮
  Widget _buttonWidget(context) {
    return Container(
      width: MyScreen.setWidth(690),
      height: MyScreen.setHeight(100),
      margin: MyScreen.setEdge(top: 60),
      child: MySubmitBtn(
        txt: '确定',
        textSty: MyStyles.f36cff,
        submit: () {
          Provide.value<LifeAuditProvide>(context).submit(context);
        },
      ),
    );
  }
}
