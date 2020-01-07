/*
 * @Author: liangyt
 * @Date: 2020-01-03 20:16:01
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-07 18:17:50
 * @Description: 空调清洗作业 蓄电池放电测试作业
 * @FilePath: /unicom-flutter/lib/pages/airBatPage.dart
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/models/rpisnModel.dart';
import 'package:unicom_flutter/providers/airBatProvide.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
import 'package:unicom_flutter/widgets/common/myEmpty.dart';
import 'package:unicom_flutter/widgets/common/myLoading.dart';
import 'package:unicom_flutter/widgets/common/mySubmitBtn.dart';

class AirBatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('作业详情'),
      body: SingleChildScrollView(
        child: CupertinoScrollbar(child: Provide<AirBatProvide>(
          builder: (BuildContext context, child, data) {
            if (data.isLoad && data.siteData == null) {
              return MyEmpty();
            }
            if (!data.isLoad && data.siteData == null) {
              return MyLoading();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _topContent(data.siteData),
                _uploadImage(),
                _listContent(),
                _submitBox(context, data.siteData)
              ],
            );
          },
        )),
      ),
    );
  }

  // 顶部内容
  Widget _topContent(RpinsModel siteData) {
    return Container(
      width: MyScreen.setWidth(750),
      padding: MyScreen.setEdgeAll(30),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${siteData.name}${siteData.serialNumber}',
            style: MyStyles.f36c33,
          ),
          Padding(
            padding: MyScreen.setEdge(top: 20),
            child: Text(
              '${siteData.address}',
              style: MyStyles.f26c66,
            ),
          ),
          siteData.status == 4
              ? Container(
                  width: MyScreen.setWidth(690),
                  padding: MyScreen.setEdge(top: 30),
                  margin: MyScreen.setEdge(top: 30),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 1, color: MyStyles.borderColor))),
                  child: Text('审核驳回：${siteData.description}',
                      style: MyStyles.f26ce0),
                )
              : Container()
        ],
      ),
    );
  }

// 上传图片
  Widget _uploadImage() {
    return Container(
      width: MyScreen.setWidth(750),
      padding: MyScreen.setEdgeAll(30),
      margin: MyScreen.setEdge(top: 20),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: MyScreen.setEdge(bottom: 20),
            child: Text('上传照片', style: MyStyles.f30c33),
          ),
          Wrap(
            spacing: MyScreen.setWidth(10),
            runSpacing: MyScreen.setWidth(10),
            children: <Widget>[
              _imageItem(),
              _imageItem(),
              _imageItem(),
              _imageItem(),
              _imageItem(),
            ],
          )
        ],
      ),
    );
  }

  Widget _imageItem() {
    return Container(
      width: MyScreen.setWidth(130),
      height: MyScreen.setWidth(130),
      color: Colors.grey,
    );
  }

  // 列表内容
  Widget _listContent() {
    List list = [0, 1, 2, 3, 4];
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list.asMap().keys.map((index) {
          return _listItem();
        }).toList(),
      ),
    );
  }

  // 列表
  Widget _listItem() {
    return Container(
      width: MyScreen.setWidth(750),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[],
      ),
    );
  }

  // 回单按钮
  Widget _submitBox(BuildContext context, RpinsModel siteData) {
    return Container(
      width: MyScreen.setWidth(750),
      height: MyScreen.setHeight(100),
      color: Colors.white,
      margin: MyScreen.setEdge(left: 30, top: 60, right: 60, bottom: 60),
      child: Container(
        child: MySubmitBtn(
          txt: '回单',
          textSty: MyStyles.f36cff,
          submit: () {
            Provide.value<AirBatProvide>(context).submit(context);
          },
        ),
      ),
    );
  }
}
