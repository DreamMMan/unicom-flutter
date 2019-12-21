/*
 * @Author: liangyt
 * @Date: 2019-12-21 15:00:40
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-21 15:36:30
 * @Description: 告警通知列表
 * @FilePath: /unicom_flutter/lib/providers/alarmProvide.dart
 */
import 'package:flutter/material.dart';
import 'package:unicom_flutter/http/httpUtil.dart';
import 'package:unicom_flutter/models/alarmModel.dart';

class AlarmProvide with ChangeNotifier {
  bool isError = false;
  int size = 20;
  int page = 0;
  int total = 0;
  bool first = true;
  bool isOpen = false;
  List<int> idList = [];
  List<AlarmList> list = [];

  // 打开或关闭多选
  void setOpen() {
    isOpen = !isOpen;
    idList = [];
    notifyListeners();
  }

  // 是否勾选列表item
  void isSelect(int id) {
    if (idList.indexOf(id) == -1) {
      idList.add(id);
    } else {
      idList.removeAt(idList.indexOf(id));
    }
    notifyListeners();
  }

  // 下拉刷新
  onRefresh(context) async {
    isError = false;
    first = false;
    var params = {"page": 0, "size": size};
    await HttpUtil.request(context, 'alarmList', data: params).then((data) {
      AlarmModel dataInfo = AlarmModel.fromJson(data);
      page = 0;
      total = dataInfo.total;
      list = dataInfo.list;
      notifyListeners();
    }).catchError((onError) {
      isError = true;
      notifyListeners();
    });
  }

  // 上拉加载
  onLoad(context) async {
    isError = false;
    var params = {"page": page + 1, "size": size};
    await HttpUtil.request(context, 'alarmList', data: params).then((data) {
      AlarmModel dataInfo = AlarmModel.fromJson(data);
      page++;
      total = dataInfo.total;
      list..addAll(dataInfo.list);
      notifyListeners();
    }).catchError((onError) {
      isError = true;
      notifyListeners();
    });
  }
}
