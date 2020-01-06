/*
 * @Author: liangyt
 * @Date: 2019-12-18 14:09:16
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-06 20:51:28
 * @Description: 登录页
 * @FilePath: /unicom_flutter/lib/pages/loginPage.dart
 */

import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/constant/myConstant.dart';
import 'package:unicom_flutter/providers/loginProvide.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/myAsset.dart';
import 'package:unicom_flutter/widgets/common/myInput.dart';
import 'package:unicom_flutter/widgets/common/mySubmitBtn.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: MyAsset(
                name: MyConstant.loginBg,
                width: 750,
                height: 430,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: MyScreen.setHeight(170),
              left: 0,
              width: MyScreen.setWidth(750),
              child: _content(context),
            )
          ],
        ));
  }

  // 内容
  Widget _content(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_title(), _inputBox(), _loginBtn(context)],
      ),
    );
  }

  // 标题
  Widget _title() {
    return DefaultTextStyle(
      style: MyStyles.f36ce0B,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[Text('Hi，欢迎登录'), Text('联通智慧机房工单系统')],
      ),
    );
  }

  // 输入框box
  Widget _inputBox() {
    return Container(
      width: MyScreen.setWidth(610),
      margin: MyScreen.setEdge(top: 82),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MyScreen.setWidth(15)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: MyStyles.boxShadow,
                offset: Offset(2, 2),
                blurRadius: 25,
                spreadRadius: 5),
          ]),
      child: Column(
        children: <Widget>[_inputItem(true), _inputItem(false)],
      ),
    );
  }

  // 输入框
  Widget _inputItem(bool isPhone) {
    return Provide<LoginProvide>(
      builder: (BuildContext context, child, data) {
        return Container(
          width: MyScreen.setWidth(550),
          height: MyScreen.setHeight(140),
          alignment: Alignment.centerLeft,
          margin: MyScreen.setEdge(left: 30, right: 30),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: isPhone ? 1 : 0, color: MyStyles.borderColor))),
          child: MyInput(
            inintValue: isPhone ? data.username : '',
            iconName: isPhone ? MyConstant.phoneIcon : MyConstant.passwordIcon,
            hintText: isPhone ? '请输入手机号' : '请输入密码',
            keyboardType: isPhone ? 'number' : 'password',
            maxLength: isPhone ? 11 : 24,
            paddingHeight: 24,
            iconWidth: 30,
            blackEegExp: ' ',
            fieldCallBack: (val) {
              Provide.value<LoginProvide>(context).setValue(
                  isPhone ? val : data.username, isPhone ? data.password : val);
            },
          ),
        );
      },
    );
  }

  // 登录按钮
  Widget _loginBtn(BuildContext context) {
    return Container(
      width: MyScreen.setWidth(610),
      height: MyScreen.setHeight(100),
      margin: MyScreen.setEdge(top: 140),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: MySubmitBtn(
          textSty: MyStyles.f36cff,
          txt: '登录',
          submit: () {
            Provide.value<LoginProvide>(context).submit(context);
          }),
    );
  }
}
