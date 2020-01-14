/*
 * @Author: liangyt
 * @Date: 2020-01-03 20:16:01
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-14 18:04:25
 * @Description: 空调清洗作业 蓄电池放电测试作业
 * @FilePath: /unicom-flutter/lib/pages/airBatPage.dart
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/providers/airBatProvide.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
import 'package:unicom_flutter/widgets/common/myEmpty.dart';
import 'package:unicom_flutter/widgets/common/myInput.dart';
import 'package:unicom_flutter/widgets/common/myLoading.dart';
import 'package:unicom_flutter/widgets/common/mySubmitBtn.dart';

class AirBatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('作业详情'),
      body: Provide<AirBatProvide>(
        builder: (BuildContext context, child, data) {
          if (data.isLoad && data.pageData == null) {
            return MyEmpty();
          }
          if (!data.isLoad && data.pageData == null) {
            return MyLoading();
          }
          return SingleChildScrollView(
            child: CupertinoScrollbar(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _topContent(data.lastData),
                  _uploadImage(),
                  _listContent(),
                  _submitBox(context)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 顶部内容
  Widget _topContent(List lastData) {
    return Container(
      width: MyScreen.setWidth(750),
      padding: MyScreen.setEdgeAll(30),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${lastData[0]}',
            style: MyStyles.f36c33,
          ),
          Padding(
            padding: MyScreen.setEdge(top: 20),
            child: Text(
              '${lastData[1]}',
              style: MyStyles.f26c66,
            ),
          ),
          lastData[2] == 4
              ? Container(
                  width: MyScreen.setWidth(690),
                  padding: MyScreen.setEdge(top: 30),
                  margin: MyScreen.setEdge(top: 30),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 1, color: MyStyles.borderColor))),
                  child: Text('审核驳回：${lastData[3]}', style: MyStyles.f26ce0),
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
        children: <Widget>[_listItemTitle(), _listItemContent()],
      ),
    );
  }

  // 品牌名和 设备号
  Widget _listItemTitle() {
    return Container(
      height: MyScreen.setHeight(80),
      padding: MyScreen.setEdge(left: 30),
      child: Row(
        children: <Widget>[
          Text(
            'KAS111',
            style: MyStyles.f30c33,
          ),
          Container(
            margin: MyScreen.setEdge(left: 20),
            padding: MyScreen.setEdgeAll(2),
            color: MyStyles.d6E2E8,
            child: Text('格里', style: MyStyles.f24c33),
          )
        ],
      ),
    );
  }

  Widget _listItemContent() {
    return Container(
      padding: MyScreen.setEdge(left: 30, right: 30),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _listItemContentItem('备注', false, 0),
          _listItemContentItem('运行状态', true, 1),
          _listItemContentItem('隐患类型', false, 2),
          _listItemContentItem('其他隐患', false, 3)
        ],
      ),
    );
  }

  Widget _listItemContentItem(String label, bool isRequired, int type) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(width: 1, color: MyStyles.borderColor))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MyScreen.setWidth(170),
            padding: MyScreen.setEdge(top: 35),
            alignment: Alignment.centerLeft,
            child: Text.rich(TextSpan(children: <TextSpan>[
              TextSpan(text: label, style: MyStyles.f30c33),
              TextSpan(text: isRequired ? '*' : '', style: MyStyles.f36ce0)
            ])),
          ),
          type == 0 || type == 3
              ? Container(
                  width: MyScreen.setWidth(520),
                  height: MyScreen.setHeight(100),
                  child: MyInput(
                    inintValue: '',
                    hintText: type == 0 ? '可用于备注设置位置，便于查找设备' : '如有其他隐患请输入',
                    hintStyle: MyStyles.f30c99,
                    paddingHeight: 35,
                    fieldCallBack: (val) {
                      print(val);
                    },
                  ),
                )
              : _listItemRight(type)
        ],
      ),
    );
  }

  Widget _listItemRight(int type) {
    List<Widget> _list = [];
    if (type == 1) {
      _list.add(_listItemRightBtn('良好', true));
      _list.add(_listItemRightBtn('已坏', false));
    }
    if (type == 2) {
      _list.add(_listItemRightBtn('空调孔洞未封堵或封堵不良', true));
      _list.add(_listItemRightBtn('空调孔洞未封堵或封堵不良', true));
      _list.add(_listItemRightBtn('空调孔洞未封堵或封堵不良', true));
      _list.add(_listItemRightBtn('空调孔洞未封堵或封堵不良', true));
    }
    return Container(
      width: MyScreen.setWidth(520),
      padding: MyScreen.setEdge(top: 25, bottom: 25),
      child: Wrap(
        runSpacing: MyScreen.setWidth(40),
        spacing: MyScreen.setWidth(30),
        children: _list,
      ),
    );
  }

  Widget _listItemRightBtn(String name, bool isCheck) {
    return Container(
      width: MyScreen.setWidth(name.length > 6 ? 520 : 245),
      height: MyScreen.setHeight(60),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isCheck ? MyStyles.e0454501 : Colors.white,
          border: Border.all(
              width: 1,
              color: isCheck ? MyStyles.e0454501 : MyStyles.borderColor),
          borderRadius: BorderRadius.circular(5)),
      child: Text(
        name,
        style: isCheck ? MyStyles.f26ce0 : MyStyles.f26c33,
      ),
    );
  }

  // 回单按钮
  Widget _submitBox(BuildContext context) {
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
