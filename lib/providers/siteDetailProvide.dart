/*
 * @Author: liangyt
 * @Date: 2020-01-16 11:46:48
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-17 11:17:45
 * @Description: 数据采集建设站点详情
 * @FilePath: /unicom_flutter/lib/providers/siteDetailProvide.dart
 */
import 'package:flutter/material.dart';
import 'package:unicom_flutter/http/httpUtil.dart';
import 'package:unicom_flutter/models/siteDetailsModel.dart';
import 'package:unicom_flutter/utils/index.dart';

class SiteDetailProvide with ChangeNotifier {
  int id;
  bool disabled = false;
  bool isLoad = false;
  bool isError = false;
  bool callRefresh = false;
  bool isAlarm = false;
  String imei = '';
  SiteDetailsModel siteData;

  // 设置数据
  void setData(int myId, bool alarm) {
    id = myId;
    disabled = alarm;
    isAlarm = alarm;
    isLoad = false;
    siteData = null;
    isError = false;
    callRefresh = false;
    notifyListeners();
  }

  // 触发刷新数据
  void isCallRefresh() {
    callRefresh = true;
    notifyListeners();
  }

  // 下拉刷新
  onRefresh(context) async {
    var params = {"id": id};
    await HttpUtil.request(context, 'appSiteDetail', data: params).then((data) {
      SiteDetailsModel dataInfo = SiteDetailsModel.fromJson(data);
      siteData = dataInfo;
      if (siteData.status == 1 || siteData.status == 2) {
        disabled = true;
      }
      isLoad = true;
      notifyListeners();
    }).catchError((onError) {
      print(onError);
      isError = true;
      notifyListeners();
    });
  }

  // 设置imei
  void setImei(code) {
    imei = code;
    notifyListeners();
  }

  // 添加dtu
  void addDtu(context) async {
    if (imei.trim().isEmpty) {
      Utils.showToast('imei不能为空');
      return;
    }
    Utils.showLoading(context, title: '正在添加');
    var params = {'id': id, 'imei': imei};
    await HttpUtil.request(context, 'addDtu', data: params).then((data) {
      Navigator.pop(context);
      Navigator.pop(context);
      if (data != null) {
        Utils.showToast('添加DTU成功');
        isCallRefresh();
      }
    });
  }

  // 回单
  void submit(context) async {
    Utils.showLoading(context, title: '正在回单');
    var params = {'id': id};
    await HttpUtil.request(context, 'receipt', data: params).then((data) {
      Navigator.pop(context);
      if (data != null) {
        Utils.showToast('回单完成');
        isCallRefresh();
      }
    });
  }
}
