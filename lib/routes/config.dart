/*
 * @Author: liangyt
 * @Date: 2019-12-18 10:40:16
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-18 10:40:37
 * @Description: fluro 路由配置
 * @FilePath: /unicom_flutter/lib/routes/config.dart
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:unicom_flutter/routes/handlers.dart';

class Routes {
  static void configRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      print('找不到路由');
      return Container();
    });

    // 首页
    router.define('/',
        handler: homeHandler, transitionType: TransitionType.cupertino);
  }
}
