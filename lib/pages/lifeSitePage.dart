/*
 * @Author: liangyt
 * @Date: 2020-01-03 20:10:50
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-04 15:40:03
 * @Description: 生命周期站点详情
 * @FilePath: /unicom-flutter/lib/pages/lifeSitePage.dart
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/MyExpansionPanel.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
import 'package:unicom_flutter/widgets/common/mySubmitBtn.dart';

class LifeSitePage extends StatefulWidget {
  @override
  _LifeSitePageState createState() => _LifeSitePageState();
}

class _LifeSitePageState extends State<LifeSitePage> {
  int _index = -1;
  List _list = [0, 1, 2, 3, 4];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('新增设备'),
      body: CupertinoScrollbar(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[_content(), _bottom()],
          ),
        ),
      ),
    );
  }

  // 非底部固定内容
  Widget _content() {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[_topContent(), _listTitle(), _equipment()],
          ),
        ),
      ),
    );
  }

  // 站点名称和地址
  Widget _topContent() {
    return Container(
      width: double.infinity,
      padding: MyScreen.setEdgeAll(30),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '富临',
            style: MyStyles.f36c33,
          ),
          Padding(
            padding: MyScreen.setEdge(top: 20),
            child: Text(
              '深圳市和平路1085号富临酒店',
              style: MyStyles.f26c66,
            ),
          )
        ],
      ),
    );
  }

  // 列表名称
  Widget _listTitle() {
    return Container(
      padding: MyScreen.setEdge(left: 30, top: 20, bottom: 24),
      child: Text(
        '新建设备',
        style: MyStyles.f30c33,
      ),
    );
  }

  // 设备列表
  Widget _equipment() {
    return Container(
        child: Column(
      children: _list.asMap().keys.map((index) {
        return Padding(
          padding: MyScreen.setEdge(bottom: 20),
          child: MyExpansionPanel(
              isExpanded: _index == index,
              expansionCallback: () {
                setState(() {
                  _index = index == _index ? -1 : index;
                });
              },
              title: _panelTitle(),
              body: _panelContent()),
        );
      }).toList(),
    ));
  }

  // 面板title
  Widget _panelTitle() {
    return Container(
      child: Text.rich(TextSpan(children: <TextSpan>[
        TextSpan(text: '空调', style: MyStyles.f30c33),
        TextSpan(text: '  (2)', style: MyStyles.f30c99)
      ])),
    );
  }

  // 面板内容
  Widget _panelContent() {
    List panelList = [0, 1, 2];
    return Container(
      child: Column(
        children: panelList.asMap().keys.map((index) {
          return _panelContentItem();
        }).toList(),
      ),
    );
  }

  // 面板内容Item
  Widget _panelContentItem() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text('adasd'),
              ),
              Expanded(
                child: Text('adasd'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text('adasd'),
              ),
              Expanded(
                child: Text('adasd'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text('adasd'),
              ),
              Expanded(
                child: Text('adasd'),
              ),
            ],
          )
        ],
      ),
    );
  }

  // 底部的固定内容
  Widget _bottom() {
    return Container(
      width: MyScreen.setWidth(750),
      height: MyScreen.setHeight(100),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(top: BorderSide(width: 1, color: MyStyles.borderColor))),
      child: Row(
        children: <Widget>[
          Container(
            width: MyScreen.setWidth(300),
            padding: MyScreen.setEdge(left: 40),
            child: Text.rich(TextSpan(children: <TextSpan>[
              TextSpan(text: '设备数量： ', style: MyStyles.f30c66),
              TextSpan(text: '7', style: MyStyles.f30ce2),
            ])),
          ),
          InkWell(
            child: Container(
              width: MyScreen.setWidth(450),
              height: MyScreen.setHeight(100),
              child: MySubmitBtn(
                txt: '审核',
                textSty: MyStyles.f32cff,
                submit: () {
                  print('审核');
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
