/*
 * @Author: liangyt
 * @Date: 2019-12-18 10:26:42
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-02 15:20:05
 * @Description: 程序入口文件
 * @FilePath: /unicom_flutter/lib/main.dart
 */

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/routes/application.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/utils/myProvide.dart';
import 'pages/splashPage.dart';
import 'routes/config.dart';
import 'package:bot_toast/bot_toast.dart';

void main() {
  runApp(ProviderNode(
    child: MyApp(),
    providers: myProvide(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // fluro 路由注入
    final router = Router();
    Routes.configRoutes(router);
    Application.router = router;

    return BotToastInit(
      child: MaterialApp(
        title: '智慧机房',
        onGenerateRoute: Application.router.generator,
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: ThemeData(
            primaryColor: MyStyles.e04545,
            scaffoldBackgroundColor: MyStyles.pageBg,
            buttonTheme: ButtonThemeData(
                buttonColor: MyStyles.e04545, disabledColor: MyStyles.cccc)),
        home: SplashPage(),
      ),
    );
  }
}
