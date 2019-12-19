import 'package:flutter/material.dart';
import 'package:unicom_flutter/utils/imagse.dart';
import 'package:unicom_flutter/utils/myColors.dart';
import 'package:unicom_flutter/utils/screenUtil.dart';
import 'package:unicom_flutter/utils/styles.dart';
import 'package:unicom_flutter/widgets/myInput.dart';
import 'package:unicom_flutter/widgets/submitBtn.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.topCenter,
          color: Colors.white,
          child: Image.asset(
            loginBg,
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned(
          top: setHeight(170),
          left: 0,
          width: setWidth(750),
          height: setHeight(1000),
          child: content(),
        )
      ],
    ));
  }

  // 内容
  Widget content() {
    return Container(
      child: Column(
        children: <Widget>[title(), inputBox(), loginBtn()],
      ),
    );
  }

  // 标题
  Widget title() {
    return DefaultTextStyle(
      style: f36ce0,
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
                color: boxShadow,
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
    return Container(
      width: setWidth(550),
      height: setHeight(140),
      alignment: Alignment.centerLeft,
      margin: setEdge(left: 30, right: 30),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: isPhone ? 1 : 0, color: borderColor))),
      child: MyInput(
        inintValue: isPhone ? '123' : '12312',
        iconName: isPhone ? phoneIcon : passwordIcon,
        hintText: isPhone ? '请输入手机号' : '请输入密码',
        keyboardType: isPhone ? 'text' : 'password',
        maxLength: isPhone ? 11 : 24,
        paddingHeight: 24,
        iconWidth: 30,
        fieldCallBack: (val) {
          print(val);
        },
      ),
    );
  }

  // 登录按钮
  Widget loginBtn() {
    return Container(
      width: setWidth(610),
      height: setHeight(100),
      margin: setEdge(top: 140),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: SubmitBtn(
          textSty: f36cff,
          submit: () {
            print('adasd');
          }),
    );
  }
}
