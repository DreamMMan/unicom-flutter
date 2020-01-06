/*
 * @Author: liangyt
 * @Date: 2019-12-18 10:40:26
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-06 19:44:42
 * @Description: fluro handler配置集合
 * @FilePath: /unicom_flutter/lib/routes/handlers.dart
 */
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:unicom_flutter/pages/airBatPage.dart';
import 'package:unicom_flutter/pages/alarmDealPage.dart';
import 'package:unicom_flutter/pages/alarmDetailsPage.dart';
import 'package:unicom_flutter/pages/homePage.dart';
import 'package:unicom_flutter/pages/lifeAuditPage.dart';
import 'package:unicom_flutter/pages/lifeSitePage.dart';
import 'package:unicom_flutter/pages/loginPage.dart';
import 'package:unicom_flutter/pages/orderDetailsPage.dart';
import 'package:unicom_flutter/pages/rpinsPage.dart';
import 'package:unicom_flutter/pages/siteDetailsPage.dart';
import 'package:unicom_flutter/pages/splashPage.dart';
import 'package:unicom_flutter/pages/webViewPage.dart';

// 启动页 闪屏页
Handler splashHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return SplashPage();
});

// home 首页
Handler homeHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return HomePage();
});

// webview 页面
Handler webViewHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return WebViewPage();
});

// 登录 页面
Handler loginHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return LoginPage();
});

// 工单详情 页面
Handler orderDetailsHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return OrderDetailsPage();
});

// 报警处理详情 页面
Handler alarmDetailsHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return AlarmDetailsPage();
});

// 报警处理 页面
Handler alarmDealHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return AlarmDealPage();
});

// 常规建设站点详情 页面
Handler siteDetailsHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return SiteDetailsPage();
});

// 生命周期工单站点详情 页面
Handler lifeSiteHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return LifeSitePage();
});

// 常规动力站点详情 页面
Handler rpInHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return RpInPage();
});

// 空调 蓄电池站点详情 页面
Handler airBatHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return AirBatPage();
});

// 生命周期工单审核 页面
Handler lifeAuditHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return LifeAuditPage();
});
