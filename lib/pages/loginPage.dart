/*
 * @Author: liangyt
 * @Date: 2019-12-18 14:09:16
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 13:51:15
 * @Description: 登录页
 * @FilePath: /unicom_flutter/lib/pages/loginPage.dart
 */

import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/providers/loginProvide.dart';
import 'package:unicom_flutter/utils/constant.dart';
import 'package:unicom_flutter/utils/screenUtil.dart';
import 'package:unicom_flutter/utils/styles.dart';
import 'package:unicom_flutter/widgets/common/myInput.dart';
import 'package:unicom_flutter/widgets/common/mySubmitBtn.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                Constant.loginBg,
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              top: setHeight(170),
              left: 0,
              width: setWidth(750),
              child: content(context),
            )
          ],
        ));
  }

  // 内容
  Widget content(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[title(), inputBox(), loginBtn(context)],
      ),
    );
  }

  // 标题
  Widget title() {
    return DefaultTextStyle(
      style: Styles.f36ce0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[Text('Hi，欢迎登录'), Text('联通智慧机房工单系统')],
      ),
    );
  }

  // 输入框box
  Widget inputBox() {
    return Container(
      width: setWidth(610),
      margin: setEdge(top: 82),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Styles.boxShadow,
                offset: Offset(2, 2),
                blurRadius: 25,
                spreadRadius: 5),
          ]),
      child: Column(
        children: <Widget>[inputItem(true), inputItem(false)],
      ),
    );
  }

  // 输入框
  Widget inputItem(bool isPhone) {
    return Provide<LoginProvide>(
      builder: (BuildContext context, child, data) {
        return Container(
          width: setWidth(550),
          height: setHeight(140),
          alignment: Alignment.centerLeft,
          margin: setEdge(left: 30, right: 30),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: isPhone ? 1 : 0, color: Styles.borderColor))),
          child: MyInput(
            inintValue: isPhone ? data.username : '',
            iconName: isPhone ? Constant.phoneIcon : Constant.passwordIcon,
            hintText: isPhone ? '请输入手机号' : '请输入密码',
            keyboardType: isPhone ? 'text' : 'password',
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
  Widget loginBtn(BuildContext context) {
    return Container(
      width: setWidth(610),
      height: setHeight(100),
      margin: setEdge(top: 140),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: MySubmitBtn(
          textSty: Styles.f36cff,
          txt: '登录',
          submit: () {
            Provide.value<LoginProvide>(context).submit(context);
          }),
    );
  }
}
