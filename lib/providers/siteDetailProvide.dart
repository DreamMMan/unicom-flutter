/*
 * @Author: liangyt
 * @Date: 2020-01-16 11:46:48
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-16 15:51:47
 * @Description: 数据采集建设站点详情
 * @FilePath: /unicom_flutter/lib/providers/siteDetailProvide.dart
 */
import 'package:flutter/material.dart';
import 'package:unicom_flutter/http/httpUtil.dart';
import 'package:unicom_flutter/models/siteDetailsModel.dart';

class SiteDetailProvide with ChangeNotifier {
  int id;
  bool disabled = false;
  bool isLoad = false;
  bool isError = false;
  bool callRefresh = false;
  bool isAlarm = false;
  SiteDetailsModel siteData;

  // 设置数据
  void setData(int myId, bool alarm) {
    id = myId;
    disabled = alarm;
    isAlarm = alarm;
    isLoad = false;
    siteData = null;
    isError = false;
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
      if(siteData.status == 1 || siteData.status == 2){
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
}
