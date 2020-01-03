/*
 * @Author: liangyt
 * @Date: 2019-12-18 10:26:42
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-03 15:32:59
 * @Description: 程序入口文件
 * @FilePath: /unicom_flutter/lib/main.dart
 */

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/routes/application.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/utils/myProvide.dart';
import 'pages/splashPage.dart';
import 'routes/config.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

void main() {
  runApp(ProviderNode(
    child: MyApp(),
    providers: myProvide(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final JPush jpush = new JPush(); //初始化极光插件

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // 极光推送
  Future<void> initPlatformState() async {
    try {
      // 监听响应方法的编写
      jpush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {}, // 收到推送提醒
          onOpenNotification: (Map<String, dynamic> message) async {}, // 打开推送提醒
          onReceiveMessage: (Map<String, dynamic> message) async {}); // 接收自定义消息
    } on PlatformException {
      print('平台版本获取失败，请检查！');
    }
    if (!mounted) return;
  }

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
          home: SplashPage()),
    );
  }
}
