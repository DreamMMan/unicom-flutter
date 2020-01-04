/*
 * @Author: liangyt
 * @Date: 2020-01-04 15:59:01
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-04 18:16:02
 * @Description: 生命周期工单站点线详情
 * @FilePath: /unicom_flutter/lib/providers/lifeSiteDetailsProvide.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/http/httpUtil.dart';
import 'package:unicom_flutter/models/LifeSiteDetailsModel.dart';

class LifeSiteDetailsProvide with ChangeNotifier {
  int id;
  bool isLoad = false;
  String title;
  LifeSiteDetailsModel siteData;
  var deviceList = [];

  void setId(context, int myId, String name) async {
    id = myId;
    title = name;
    siteData = null;
    isLoad = false;
    var params = {"id": myId};
    await HttpUtil.request(context, 'appSiteDetail', data: params).then((data) {
      LifeSiteDetailsModel dataInfo = LifeSiteDetailsModel.fromJson(data);
      isLoad = true;
      siteData = dataInfo;
      changeDevice(dataInfo.deviceList);
    });
    notifyListeners();
  }

  // 修改设备列表
  void changeDevice(deviceList) {
    List<dynamic> list = [];
    // deviceList.forEach((item) {
    //   list..add({'name': item.deviceType, 'list': item});
    //   print(list.firstWhere((item=> item.));
    // });
    // print(list);
    // deviceList = list;
    // print(list);
    // notifyListeners();
  }
}
