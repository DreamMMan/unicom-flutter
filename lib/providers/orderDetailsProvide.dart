/*
 * @Author: liangyt
 * @Date: 2019-12-23 09:27:49
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-15 16:38:08
 * @Description: 工单详情页面
 * @FilePath: /unicom_flutter/lib/providers/orderDetailsProvide.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/http/httpUtil.dart';
import 'package:unicom_flutter/models/orderDetailsModel.dart';
import 'package:unicom_flutter/models/siteListModel.dart';

class OrderDetailsProvide with ChangeNotifier {
  int id;
  int districtCode;
  String region = '区域（全部）';
  String keyWord = '';
  bool isLife = false;
  int size = 20;
  int page = 0;
  int total = 0;
  bool isError = false;
  bool isCallRefresh = false;
  bool isLoaded = false;
  List<SiteList> list = [];
  OrderDetailsModel orderData;

  // 获取从首页的工单id 和是否是生命周期
  void setIdAndIslife(int orderId, bool islife) {
    id = orderId;
    isLife = islife;
    districtCode = null;
    region = '区域（全部）';
    keyWord = '';
    page = 0;
    total = 0;
    list = [];
    orderData = null;
    isLoaded = false;
    notifyListeners();
  }

  // 设置区域名和code
  void setRegion(String name, int code) {
    region = name;
    districtCode = code;
    isCallRefresh = true;
    notifyListeners();
  }

  // 获取输入框数据
  void setkeyWorld(world) {
    keyWord = world;
    notifyListeners();
  }

  // 触发刷新
  void callRefresh() {
    isCallRefresh = true;
    notifyListeners();
  }

  // 下拉刷新
  onRefresh(context) async {
    isError = false;
    isCallRefresh = false;
    isLoaded = true;
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
    });

    // 获取站点列表
    await HttpUtil.request(context, 'appSiteList', data: params).then((data) {
      SiteListModel siteList = SiteListModel.fromJson(data);
      page = 0;
      total = siteList.total;
      list = siteList.list;
      notifyListeners();
    }).catchError((onError) {
      isError = true;
      notifyListeners();
    });
  }

  // 上拉加载
  onLoad(context) async {
    isError = false;
    var params = {
      "page": page + 1,
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
      isError = true;
      notifyListeners();
    });
  }
}
