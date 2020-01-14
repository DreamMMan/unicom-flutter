/*
 * @Author: liangyt
 * @Date: 2019-12-18 10:26:42
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-06 20:50:44
 * @Description: 程序入口文件
 * @FilePath: /unicom_flutter/lib/main.dart
 */

import 'dart:async';
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
import 'package:connectivity/connectivity.dart';

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
  // 网络监测
  Stream<ConnectivityResult> connectChangeListener() async* {
    final Connectivity connectivity = Connectivity();
    await for (ConnectivityResult result
        in connectivity.onConnectivityChanged) {
      yield result;
    }
  }

  StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    connectivitySubscription = connectChangeListener().listen(
      (ConnectivityResult connectivityResult) {
        if (!mounted) {
          return;
        }
        if (connectivityResult == ConnectivityResult.none) {
          BotToast.showText(text: '请检查网络连接！');
        }
      },
    );
  }

  // 极光推送有问题 android 点击信息无反应， ios推送成功但不显示推送信息
  Future<void> initPlatformState() async {
    try {
      // 监听响应方法的编写
      jpush.addEventHandler(
          // 收到推送提醒回调
          onReceiveNotification: (Map<String, dynamic> message) async {
        print('接收推送消息：$message');
      },
          // 打开推送提醒回调
          onOpenNotification: (Map<String, dynamic> message) async {
        print('点击推送消息：$message');
      },
          // 接收自定义消息回调
          onReceiveMessage: (Map<String, dynamic> message) async {
        print('接收自定义推送消息：$message');
      });
    } on PlatformException {
      print('平台版本获取失败，请检查！');
    }
    if (!mounted) return;
  }

  @override
  void dispose() {
    super.dispose();
    connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // fluro 路由注入
    final router = Router();
    Routes.configRoutes(router);
    Application.router = router;

    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BotToastInit(
          child: MaterialApp(
              title: '智慧机房',
              onGenerateRoute: Application.router.generator,
              navigatorObservers: [BotToastNavigatorObserver()],
              theme: ThemeData(
                  primaryColor: MyStyles.e04545,
                  scaffoldBackgroundColor: MyStyles.pageBg,
                  buttonTheme: ButtonThemeData(
                      buttonColor: MyStyles.e04545,
                      disabledColor: MyStyles.cccc)),
              home: SplashPage()),
        ));
  }
}
