/*
 * @Author: liangyt
 * @Date: 2019-12-18 10:40:26
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-18 10:43:56
 * @Description: fluro handler配置集合
 * @FilePath: /unicom_flutter/lib/routes/handlers.dart
 */
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:unicom_flutter/pages/homePage.dart';
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
