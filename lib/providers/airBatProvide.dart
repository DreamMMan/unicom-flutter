/*
 * @Author: liangyt
 * @Date: 2020-01-07 17:47:50
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-15 15:06:24
 * @Description: 空调 蓄电池，常规动力设备详情
 * @FilePath: /unicom_flutter/lib/providers/airBatProvide.dart
 */

import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/http/httpUtil.dart';
import 'package:unicom_flutter/models/airBatModel.dart';
import 'package:unicom_flutter/providers/rpinsProvide.dart';
import 'package:unicom_flutter/utils/index.dart';

class AirBatProvide with ChangeNotifier {
  int id;
  bool isLoad = false;
  List<dynamic> lastData = [];
  AirBatModel pageData;
  List<DeviceList> deviceList;
  List<String> nameList;

  // 获取页面数据
  void getData(BuildContext context, int myId, List<dynamic> lastPage) async {
    id = myId;
    lastData = lastPage;
    isLoad = false;
    pageData = null;
    var params = {"id": myId};
    await HttpUtil.request(context, 'jobDetail', data: params).then((data) {
      AirBatModel dataInfo = AirBatModel.fromJson(data);
      isLoad = true;
      pageData = dataInfo;
      deviceList = dataInfo.deviceList;
      nameList = dataInfo.nameList;
    });
    notifyListeners();
  }

  // 设置输入
  void setDeviceList(list) {
    deviceList = list;
    notifyListeners();
  }

  // 设置图片
  void setnameList(list) {
    nameList = list;
    notifyListeners();
  }

  // 提交
  void submit(context) async {
    Utils.showLoading(context, title: '正在回单');
    var params = {
      'id': id,
      'deviceList': deviceList,
      'nameList': nameList,
      'updateHiddenDanger': true
    };
    await HttpUtil.request(context, 'submit', data: params).then((data) {
      if (data != null) {
        Provide.value<RpinsProvide>(context).callRefresh(context);
        Navigator.pop(context);
        Utils.showToast('提交成功');
      }
    });
  }
}
