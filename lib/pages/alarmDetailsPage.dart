/*
 * @Author: liangyt
 * @Date: 2019-12-23 14:08:33
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 17:45:09
 * @Description: 处理详情页面
 * @FilePath: /unicom_flutter/lib/pages/AlarmDetailsPage.dart
 */
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/models/alarmDetailsModel.dart';
import 'package:unicom_flutter/providers/alarmDealProvide.dart';
import 'package:unicom_flutter/providers/alarmDetailsProvide.dart';
import 'package:unicom_flutter/routes/application.dart';
import 'package:unicom_flutter/utils/constant.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/utils/screenUtil.dart';
import 'package:unicom_flutter/utils/styles.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
import 'package:unicom_flutter/widgets/common/myAsset.dart';
import 'package:unicom_flutter/widgets/common/myEmpty.dart';
import 'package:unicom_flutter/widgets/common/myLoading.dart';
import 'package:unicom_flutter/widgets/common/mySubmitBtn.dart';

class AlarmDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('通知详情'),
      resizeToAvoidBottomPadding: false,
      body: Provide<AlarmDetailsProvide>(
        builder: (context, child, data) {
          if (data.isLoad && data.pageData == null) {
            return MyEmpty();
          }
          if (!data.isLoad && data.pageData == null) {
            return MyLoading();
          }
          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: setEdge(bottom: 100),
              child: Column(
                children: <Widget>[
                  topContent(data.pageData),
                  _alarmInfo1(data.pageData),
                  _alarmInfo2(data.pageData),
                  _goSiteDetails(context),
                  _handleAlarm(context, data.pageData)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 顶部信息
  Widget topContent(AlarmDetailsModel pageData) {
    return Container(
      width: setWidth(750),
      padding: setEdge(top: 30, bottom: 30),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[iconContent(pageData), _alarmTime(pageData)],
      ),
    );
  }

  // 告警图标
  Widget iconContent(AlarmDetailsModel pageData) {
    return Stack(
      children: <Widget>[
        MyAsset(
          name: pageData.removeTime == null
              ? Constant.alarmIcon1
              : Constant.alarmIcon2,
          width: 360,
        ),
        Positioned(
            top: setWidth(160),
            width: setWidth(360),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                pageData.removeTime == null
                    ? Text(
                        '告警中',
                        style: Styles.f36ce0,
                      )
                    : Text(
                        '已解除',
                        style: Styles.f36c03,
                      ),
                Padding(
                  padding: setEdge(top: 5),
                  child: Text(
                    '更新时间：${DateUtil.formatDateMs(pageData.updateTime, format: "MM-dd HH:mm:ss")}',
                    style: Styles.f24c99,
                  ),
                )
              ],
            ))
      ],
    );
  }

  // 告警时间栏
  Widget _alarmTime(AlarmDetailsModel pageData) {
    return Container(
      width: setWidth(750),
      margin: setEdge(top: 30),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _alarmTimeItem(
              '${DateUtil.formatDateMs(pageData.createTime, format: "MM-dd HH:mm:ss")}',
              '发生时间'),
          _alarmTimeItem(
              Utils.durationTime(pageData.createTime, pageData.removeTime),
              '持续时间'),
          _alarmTimeItem(pageData.handUserInfo == null ? '未处理' : '已处理', '处理情况'),
        ],
      ),
    );
  }

  // 告警时间栏item
  Widget _alarmTimeItem(time, name) {
    return Expanded(
        child: Container(
      constraints: BoxConstraints(minHeight: setHeight(60)),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Styles.f1f1f1))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            time,
            style: Styles.f26c33,
          ),
          Text(
            name,
            style: Styles.f24c99,
          )
        ],
      ),
    ));
  }

  // 告警信息
  Widget _alarmInfo1(AlarmDetailsModel pageData) {
    return Container(
      width: setWidth(750),
      margin: setEdge(top: 20),
      padding: setEdge(left: 30, top: 30, right: 30),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _alarmInfoItem('告警类型：', '${pageData.name}告警'),
          _alarmInfoItem('告警设备：',
              '${pageData.dtuId != null ? 'DTU' + pageData.dtuId.toString() : ''}${pageData.sn != null ? '-' + pageData.sn.toString() + '号表' : ''}${pageData.lineName != null ? '-' + pageData.lineName : ''}'),
          _alarmInfoItem('告警站点：', '${pageData.siteName}'),
          _alarmInfoItem('告警地址：', '${pageData.siteAddress}'),
        ],
      ),
    );
  }

  // 处理人信息
  Widget _alarmInfo2(AlarmDetailsModel pageData) {
    if (pageData.handUserInfo == null) {
      return Container();
    }
    return Container(
      width: setWidth(750),
      margin: setEdge(top: 20),
      padding: setEdge(left: 30, top: 30, right: 30),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _alarmInfoItem('处理人员：', pageData.handUserInfo ?? ''),
          _alarmInfoItem('处理结果：', pageData.remove != null ? '已排除' : '不做处理'),
          _alarmInfoItem('处理结果：', pageData.handDescription ?? ''),
        ],
      ),
    );
  }

  // 告警信息item
  Widget _alarmInfoItem(String name, String txt) {
    return Container(
      margin: setEdge(bottom: 30),
      child: DefaultTextStyle(
        style: Styles.f26c99,
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name),
                Expanded(
                  child: Text(
                    txt,
                    style: TextStyle(color: Styles.c666),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // 点击跳转到站点详情
  Widget _goSiteDetails(context) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, '/siteDetails');
      },
      child: Container(
        width: setWidth(750),
        height: setHeight(98),
        color: Colors.white,
        margin: setEdge(top: 30),
        padding: setEdge(left: 30, right: 30),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '查看站点数据采集关系',
              style: Styles.f26c66,
            ),
            Icon(Icons.keyboard_arrow_right, color: Styles.c7C7CC)
          ],
        ),
      ),
    );
  }

  // 告警处理
  Widget _handleAlarm(context, AlarmDetailsModel pageData) {
    if (pageData.handUserInfo != null) {
      return Container();
    }
    return Container(
      width: setWidth(690),
      height: setHeight(100),
      margin: setEdge(top: 60),
      child: MySubmitBtn(
        txt: '告警处理',
        textSty: Styles.f36cff,
        submit: () {
          Provide.value<AlarmDealProvide>(context).setId([pageData.id]);
          Application.router.navigateTo(context, '/alarmDeal');
        },
      ),
    );
  }
}
