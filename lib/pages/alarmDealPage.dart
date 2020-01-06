/*
 * @Author: liangyt
 * @Date: 2019-12-23 14:10:03
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-06 20:50:56
 * @Description: 告警处理
 * @FilePath: /unicom_flutter/lib/pages/alarmDealPage.dart
 */
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/providers/alarmDealProvide.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
import 'package:unicom_flutter/widgets/common/myInput.dart';
import 'package:unicom_flutter/widgets/common/mySubmitBtn.dart';

class AlarmDealPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar('告警处理'),
        resizeToAvoidBottomPadding: false,
        body: Provide<AlarmDealProvide>(
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
                  _buttonWidget(context)
                ],
              ),
            );
          },
        ));
  }

  // 单选
  Widget _radioWiget(context, data) {
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
                        text: '处理结果:', style: TextStyle(color: MyStyles.c333))
                  ])),
              Flexible(
                  child: InkWell(
                onTap: () {
                  Provide.value<AlarmDealProvide>(context).setCheck(true);
                },
                child: Row(
                  children: <Widget>[
                    Radio(
                      value: true,
                      groupValue: data.checked,
                      onChanged: (value) {
                        Provide.value<AlarmDealProvide>(context).setCheck(true);
                      },
                    ),
                    Text('已排除'),
                  ],
                ),
              )),
              Flexible(
                  child: InkWell(
                onTap: () {
                  Provide.value<AlarmDealProvide>(context).setCheck(false);
                },
                child: Row(
                  children: <Widget>[
                    Radio(
                      value: false,
                      groupValue: data.checked,
                      onChanged: (value) {
                        Provide.value<AlarmDealProvide>(context)
                            .setCheck(false);
                      },
                    ),
                    Text('不作处理'),
                  ],
                ),
              )),
            ],
          ),
        ));
  }

  // 文本框
  Widget _textareaWidget(context, data) {
    return Container(
      width: MyScreen.setWidth(750),
      height: MyScreen.setHeight(280),
      color: Colors.white,
      margin: MyScreen.setEdge(top: 20),
      padding: MyScreen.setEdge(left: 30, top: 30, right: 30, bottom: 30),
      child: MyInput(
        inintValue: data.description,
        hintText: '请输入处理说明',
        hintStyle: MyStyles.f30c99,
        paddingHeight: 0,
        maxLines: 10,
        maxLength: 300,
        fieldCallBack: (val) {
          Provide.value<AlarmDealProvide>(context).setTxt(val);
        },
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
          Provide.value<AlarmDealProvide>(context).submit(context);
        },
      ),
    );
  }
}
