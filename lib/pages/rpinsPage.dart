/*
 * @Author: liangyt
 * @Date: 2020-01-03 20:14:10
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-17 16:12:26
 * @Description: 常规动力巡检作业
 * @FilePath: /unicom-flutter/lib/pages/rpinsPage.dart
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/models/rpisnModel.dart';
import 'package:unicom_flutter/providers/airBatProvide.dart';
import 'package:unicom_flutter/providers/rpinsProvide.dart';
import 'package:unicom_flutter/routes/application.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
import 'package:unicom_flutter/widgets/common/myEmpty.dart';
import 'package:unicom_flutter/widgets/common/myLoading.dart';
import 'package:unicom_flutter/widgets/common/mySubmitBtn.dart';

class RpInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('作业详情'),
      body: Provide<RpinsProvide>(
        builder: (BuildContext context, child, data) {
          if (data.isLoad && data.siteData == null) {
            return MyEmpty();
          }
          if (!data.isLoad && data.siteData == null) {
            return MyLoading();
          }
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _topContent(data.siteData),
                _listContent(context, data.siteData),
                _submitBox(context, data.siteData)
              ],
            ),
          );
        },
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
                  decoration: BoxDecoration(border: MyStyles.borderTop),
                  child: Text('审核驳回：${siteData.description}',
                      style: MyStyles.f26ce0),
                )
              : Container()
        ],
      ),
    );
  }

  // 列表内容
  Widget _listContent(BuildContext context, RpinsModel siteData) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: MyScreen.setHeight(80),
            alignment: Alignment.centerLeft,
            padding: MyScreen.setEdge(left: 30),
            child: Text(
              '回单列表',
              style: MyStyles.f36c33,
            ),
          ),
          Expanded(
            child: CupertinoScrollbar(
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: siteData.jobList.asMap().keys.map((index) {
                      return InkWell(
                        onTap: () {
                          List _list = [
                            siteData.name,
                            siteData.address,
                            siteData.status,
                            siteData.description
                          ];
                          Provide.value<AirBatProvide>(context).getData(
                              context, siteData.jobList[index].id, _list);
                          Application.router.navigateTo(context, '/airBat');
                        },
                        child: _listItem(siteData.jobList[index]),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // 列表
  Widget _listItem(JobList item) {
    return Container(
      margin: MyScreen.setEdge(left: 30, right: 30),
      height: MyScreen.setHeight(120),
      decoration: BoxDecoration(border: MyStyles.borderBottom),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              '${item.name}',
              style: item.submit ? MyStyles.f36c99 : MyStyles.f36c33,
            ),
          ),
          Container(
            width: MyScreen.setWidth(140),
            height: MyScreen.setHeight(48),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MyScreen.setWidth(10)),
                color: item.submit ? MyStyles.c03A4EE01 : MyStyles.e0454501),
            child: Text(item.submit ? '已提交' : '未提交',
                style: item.submit ? MyStyles.f26c3a : MyStyles.f26ce0),
          )
        ],
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
            Provide.value<RpinsProvide>(context).submit(context);
          },
        ),
      ),
    );
  }
}
