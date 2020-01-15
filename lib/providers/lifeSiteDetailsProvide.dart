/*
 * @Author: liangyt
 * @Date: 2020-01-04 15:59:01
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-15 16:09:06
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
  List deviceList = [];

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

  // 刷新数据
  void callRefresh(BuildContext context) async {
    var params = {"id": id};
    await HttpUtil.request(context, 'appSiteDetail', data: params).then((data) {
      LifeSiteDetailsModel dataInfo = LifeSiteDetailsModel.fromJson(data);
      isLoad = true;
      siteData = dataInfo;
      changeDevice(dataInfo.deviceList);
    });
    notifyListeners();
  }

  // 修改设备列表
  void changeDevice(list) {
    List myDeviceList = [
      {'name': '空调', 'code': 'air-conditioner', 'list': []},
      {'name': '开关电源', 'code': 'switch-power', 'list': []},
      {'name': '蓄电池', 'code': 'battery', 'list': []},
      {'name': '动环监控', 'code': 'ring-monitoring', 'list': []},
      {'name': '交流配电箱', 'code': 'distribution-box', 'list': []},
      {'name': '油机转换箱', 'code': 'cross-box', 'list': []}
    ];
    list.forEach((item) {
      switch (item.deviceType) {
        case '空调':
          myDeviceList[0]['list']..add(item);
          break;
        case '开关电源':
          myDeviceList[1]['list']..add(item);
          break;
        case '蓄电池':
          myDeviceList[2]['list']..add(item);
          break;
        case '动环监控':
          myDeviceList[3]['list']..add(item);
          break;
        case '交流配电箱':
          myDeviceList[4]['list']..add(item);
          break;
        case '油机转换箱':
          myDeviceList[5]['list']..add(item);
          break;
        default:
      }
    });
    deviceList = myDeviceList;
    notifyListeners();
  }
}
