/*
 * @Author: liangyt
 * @Date: 2019-12-18 10:26:42
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-18 14:07:18
 * @Description: 程序入口文件
 * @FilePath: /unicom_flutter/lib/main.dart
 */

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:unicom_flutter/routes/application.dart';
import 'pages/splashPage.dart';
import 'routes/config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // fluro 路由注入
    final router = Router();
    Routes.configRoutes(router);
    Application.router = router;

    return MaterialApp(
      title: '智慧机房',
      onGenerateRoute: Application.router.generator,
      home: SplashPage(),
    );
  }
}
