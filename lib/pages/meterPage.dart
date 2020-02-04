/*
 * @Author: liangyt
 * @Date: 2020-01-17 14:20:17
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-02-04 10:21:47
 * @Description: 添加修改表
 * @FilePath: /unicom_flutter/lib/pages/meterPage.dart
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
import 'package:unicom_flutter/widgets/common/myInput.dart';
import 'package:unicom_flutter/widgets/common/mySubmitBtn.dart';
import 'package:unicom_flutter/widgets/common/showBottomSheet.dart';

class MeterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('设定表/传感器'),
      body: CupertinoScrollbar(
          child: SingleChildScrollView(
              child: Column(
        children: <Widget>[
          _nameBox(),
          _optionsBox(),
          _typeSnBox(context),
          _ptctBox(),
          _submitBox()
        ],
      ))),
    );
  }

  // 名称
  Widget _nameBox() {
    return Container(
      width: MyScreen.setWidth(750),
      height: MyScreen.setHeight(110),
      padding: MyScreen.setEdge(left: 30, right: 30),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: MyScreen.setWidth(100),
            child: Text(
              '名称',
              style: MyStyles.f30c33,
            ),
          ),
          Expanded(
              child: MyInput(
                  inintValue: '',
                  hintText: '请输入名称',
                  hintStyle: MyStyles.f26c99,
                  paddingHeight: 40,
                  fieldCallBack: (val) {}))
        ],
      ),
    );
  }

  // 名称常用选项
  Widget _optionsBox() {
    List<String> nameList = ['总入线', '主设备', '空调', '电池', '温湿度', '水浸', '门禁'];
    return Container(
      padding: MyScreen.setEdge(left: 30, top: 20, right: 30, bottom: 20),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: nameList.map((name) {
          return _optionsItem(name);
        }).toList(),
      ),
    );
  }

  // 名称常用选项item
  Widget _optionsItem(String name) {
    return Container(
      padding: MyScreen.setEdge(left: 20, top: 10, right: 20, bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: MyStyles.c999),
          borderRadius: BorderRadius.circular(100)),
      child: Text(name, style: MyStyles.f26c66),
    );
  }

  // 表类型和编号
  Widget _typeSnBox(context) {
    return Container(
      padding: MyScreen.setEdge(left: 30, right: 30),
      color: Colors.white,
      child: Column(
        children: <Widget>[_typeBox(context), _snBox()],
      ),
    );
  }

  // 表类型
  Widget _typeBox(context) {
    return InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              backgroundColor: MyStyles.d9DEE1,
              builder: (BuildContext context) {
                return ShowBottomSheet(
                  titleName: '请选择类型',
                  list: [
                    {'name': '三相四线表'},
                  ],
                  tap: (index) async {},
                );
              });
        },
        child: Container(
          height: MyScreen.setHeight(110),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                width: MyScreen.setWidth(100),
                child: Text(
                  '类型',
                  style: MyStyles.f30c33,
                ),
              ),
              Expanded(child: Text('请选择类型', style: MyStyles.f26c66)),
              Icon(
                Icons.keyboard_arrow_right,
                size: 26,
                color: MyStyles.c666,
              )
            ],
          ),
        ));
  }

  // 编号
  Widget _snBox() {
    return Container(
      height: MyScreen.setHeight(110),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: MyScreen.setWidth(100),
            child: Text(
              '编号',
              style: MyStyles.f30c33,
            ),
          ),
          Expanded(
              child: MyInput(
                  inintValue: '',
                  hintText: '请输入编号',
                  hintStyle: MyStyles.f26c99,
                  paddingHeight: 40,
                  fieldCallBack: (val) {}))
        ],
      ),
    );
  }

  // 电流电压变比
  Widget _ptctBox() {
    return Container(
      child: Column(
        children: <Widget>[_ptctInfo(), _ctBox(), _ptBox()],
      ),
    );
  }

  // 提示语
  Widget _ptctInfo() {
    return Container(
      padding: MyScreen.setEdge(left: 30, top: 20, right: 30, bottom: 20),
      child: Text(
        '可设置每路的变比，接电流互感器请填写电流变比，接电压互感器 请填电压变比',
        style: MyStyles.f24c99,
      ),
    );
  }

  // 电流变比
  Widget _ctBox() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _ctptTitle('电流变比CT'),
          Container(
            padding: MyScreen.setEdge(left: 30, right: 30),
            child: Column(
              children: <Widget>[
                _ctpyInput('A', 0),
                _ctpyInput('A', 0),
                _ctpyInput('A', 0),
                _ctpyInput('A', 0)
              ],
            ),
          )
        ],
      ),
    );
  }

  // 电压变比
  Widget _ptBox() {
    return Container(
      color: Colors.white,
      margin: MyScreen.setEdge(top: 20),
      child: Column(
        children: <Widget>[
          _ctptTitle('电压变比CT'),
          Container(
            padding: MyScreen.setEdge(left: 30, right: 30),
            child: Column(
              children: <Widget>[
                _ctpyInput('A', 0),
                _ctpyInput('A', 0),
                _ctpyInput('A', 0),
                _ctpyInput('A', 0)
              ],
            ),
          )
        ],
      ),
    );
  }

  // 名字
  Widget _ctptTitle(String title) {
    return Container(
      height: MyScreen.setHeight(88),
      padding: MyScreen.setEdge(left: 30, right: 30),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: MyStyles.borderBottom,
      ),
      child: Text(
        title,
        style: MyStyles.f30c33,
      ),
    );
  }

  // 变比输入值
  Widget _ctpyInput(String name, int index) {
    return Container(
      height: MyScreen.setHeight(100),
      decoration:
          BoxDecoration(color: Colors.white, border: MyStyles.borderBottom),
      child: Row(
        children: <Widget>[
          Container(
            width: MyScreen.setWidth(140),
            child: Text(
              name,
              style: MyStyles.f30c33,
            ),
          ),
          Expanded(
              child: MyInput(
                  inintValue: '',
                  hintText: '请输入变比',
                  hintStyle: MyStyles.f26c99,
                  paddingHeight: 30,
                  fieldCallBack: (val) {}))
        ],
      ),
    );
  }

  // 保存
  Widget _submitBox() {
    return Container(
      margin: MyScreen.setEdge(left: 30, top: 40, right: 30, bottom: 40),
      width: MyScreen.setWidth(690),
      height: MyScreen.setHeight(100),
      child: MySubmitBtn(
          txt: '保存',
          textSty: MyStyles.f36cff,
          submit: () {
            print('保存');
          }),
    );
  }
}
