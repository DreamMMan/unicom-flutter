/*
 * @Author: liangyt
 * @Date: 2019-12-23 09:27:49
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 09:40:37
 * @Description: 站点详情provide
 * @FilePath: /unicom_flutter/lib/providers/orderDetailsProvide.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/http/httpUtil.dart';
import 'package:unicom_flutter/models/orderDetailsModel.dart';
import 'package:unicom_flutter/models/siteListModel.dart';

class OrderDetailsProvide with ChangeNotifier {
  int id;
  int districtCode;
  String keyWord = '';
  bool isLife = false;
  int size = 20;
  int page = 0;
  int total = 0;
  bool isError = false;
  bool isCallRefresh = false;
  List<SiteList> list = [];
  OrderDetailsModel orderData;

  // 获取从首页的工单id 和是否是生命周期
  void setIdAndIslife(int orderId, bool islife) {
    id = orderId;
    isLife = islife;
    notifyListeners();
  }

  // 下拉刷新
  onRefresh(context) async {
    orderData = null;
    isError = false;
    isCallRefresh = false;
    var params = {
      "page": 0,
      "size": size,
      'id': id,
      'districtCode': districtCode,
      'keyWord': keyWord
    };
    // 获取工单详情
    await HttpUtil.request(context, 'orderDetails', data: {'id': id})
        .then((data) {
      OrderDetailsModel dataInfo = OrderDetailsModel.fromJson(data);
      orderData = dataInfo;
      notifyListeners();
    }).catchError((onError) {
      print(onError.toString());
    });

    // 获取站点列表
    await HttpUtil.request(context, 'appSiteList', data: params).then((data) {
      SiteListModel siteList = SiteListModel.fromJson(data);
      page = 0;
      total = siteList.total;
      list = siteList.list;
      notifyListeners();
    }).catchError((onError) {
      print(onError.toString());
      isError = true;
      notifyListeners();
    });
  }

  // 上拉加载
  onLoad(context) async {
    isError = false;
    var params = {
      "page": list.length > 0 ? page + 1 : 0,
      "size": size,
      'id': id,
      'districtCode': districtCode,
      'keyWord': keyWord
    };
    await HttpUtil.request(context, 'appSiteList', data: params).then((data) {
      SiteListModel siteList = SiteListModel.fromJson(data);
      page++;
      total = siteList.total;
      list..addAll(siteList.list);
      notifyListeners();
    }).catchError((onError) {
      print(onError.toString());
      isError = true;
      notifyListeners();
    });
  }

  // 触发刷新
  void callRefresh() {
    isCallRefresh = true;
    notifyListeners();
  }
}