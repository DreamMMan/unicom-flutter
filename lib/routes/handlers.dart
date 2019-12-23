/*
 * @Author: liangyt
 * @Date: 2019-12-18 10:40:26
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 16:38:22
 * @Description: fluro handler配置集合
 * @FilePath: /unicom_flutter/lib/routes/handlers.dart
 */
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:unicom_flutter/pages/alarmDealPage.dart';
import 'package:unicom_flutter/pages/alarmDetailsPage.dart';
import 'package:unicom_flutter/pages/homePage.dart';
import 'package:unicom_flutter/pages/loginPage.dart';
import 'package:unicom_flutter/pages/orderDetailsPage.dart';
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

// 站点详情 页面
Handler siteDetailsHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return SiteDetailsPage();
});

