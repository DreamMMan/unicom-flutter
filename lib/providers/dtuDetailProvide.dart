/*
 * @Author: liangyt
 * @Date: 2020-01-17 14:27:21
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-02-03 14:46:51
 * @Description: DTU详情
 * @FilePath: /unicom_flutter/lib/providers/dtuDetailProvide.dart
 */
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/http/httpUtil.dart';
import 'package:unicom_flutter/models/dtuDetailModel.dart';
import 'package:unicom_flutter/providers/siteDetailProvide.dart';
import 'package:unicom_flutter/utils/index.dart';

class DtuDetailProvide with ChangeNotifier {
  int id;
  bool disabled = false;
  bool isLoad = false;
  bool isError = false;
  bool callRefresh = false;
  String imei = '';
  DtuDetailModel dtuData;

  // 设置数据
  void setData(int myId, bool isDisabled) {
    id = myId;
    disabled = isDisabled;
    isLoad = false;
    dtuData = null;
    isError = false;
    callRefresh = false;
    imei = '';
    notifyListeners();
  }

  // 设置imei
  void setImei(code) {
    imei = code;
    notifyListeners();
  }

  // 更换dtu
  void addDtu(context) async {
    if (imei.trim().isEmpty) {
      Utils.showToast('imei不能为空');
      return;
    }
    Utils.showLoading(context, title: '正在更换');
    var params = {'id': id, 'imei': imei};
    await HttpUtil.request(context, 'replaceDtu', data: params).then((data) {
      Navigator.pop(context);
      Navigator.pop(context);
      imei = '';
      if (data != null) {
        Utils.showToast('更换DTU成功');
        isCallRefresh();
      }
      notifyListeners();
    });
  }

  // 停用dtu
  void stopDtu(context) async {
    Utils.showLoading(context, title: '正在停用');
    var params = {'id': dtuData.id};
    await HttpUtil.request(context, 'removeDtu', data: params).then((data) {
      Navigator.pop(context);
      if (data != null) {
        Navigator.pop(context);
        Utils.showToast('停用DTU成功');
        Provide.value<SiteDetailProvide>(context).isCallRefresh();
      }
      notifyListeners();
    });
  }

  // 停用表或传感器
  void stopMeter(context, meterId) async {
    Utils.showLoading(context, title: '正在停用');
    var params = {'id': meterId};
    await HttpUtil.request(context, 'removeAmmeter', data: params).then((data) {
      Navigator.pop(context);
      if (data != null) {
        Utils.showToast('停用表或传感器成功');
        isCallRefresh();
      }
      notifyListeners();
    });
  }

  // 上报数据
  upData(context) async {
    var params = {'id': id};
    await HttpUtil.request(context, 'upData', data: params).then((data) {
      if (data != null) {
        Utils.showToast('已向设备发出指令，请在一分钟后刷新页面');
      }
    });
  }

  // 触发刷新数据
  void isCallRefresh() {
    callRefresh = true;
    notifyListeners();
  }

  // 下拉刷新
  onRefresh(context) async {
    isError = false;
    var params = {"id": id};
    await HttpUtil.request(context, 'dtuDetail', data: params).then((data) {
      DtuDetailModel dataInfo = DtuDetailModel.fromJson(data);
      dtuData = dataInfo;
      isLoad = true;
      callRefresh = false;
    }).catchError((onError) {
      print(onError);
      isError = true;
    });
    notifyListeners();
  }
}
