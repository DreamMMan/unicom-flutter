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
import 'package:provide/provide.dart';
import 'package:unicom_flutter/allProvide.dart';
import 'package:unicom_flutter/routes/application.dart';
import 'package:unicom_flutter/utils/myColors.dart';
import 'pages/splashPage.dart';
import 'routes/config.dart';
import 'package:bot_toast/bot_toast.dart';

void main() {
  runApp(ProviderNode(
    child: MyApp(),
    providers: allProvide(),
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
            primaryColor: e04545,
            scaffoldBackgroundColor: pageBg,
            buttonTheme:
                ButtonThemeData(buttonColor: e04545, disabledColor: cccc)),
        home: SplashPage(),
      ),
    );
  }
}
