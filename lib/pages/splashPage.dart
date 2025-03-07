/*
 * @Author: liangyt
 * @Date: 2019-12-18 10:36:37
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-02 15:12:14
 * @Description: 启动页 广告页
 * @FilePath: /unicom_flutter/lib/pages/splashPage.dart
 */
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/constant/myConstant.dart';
import 'package:unicom_flutter/providers/loginProvide.dart';
import 'package:unicom_flutter/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:common_utils/common_utils.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  TimerUtil mTimerUtil;
  String token;

  @override
  void initState() {
    super.initState();
    // 倒计时
    mTimerUtil = new TimerUtil(mInterval: 1000, mTotalTime: 3000);
    mTimerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      if (_tick.toInt() == 0) {
        Application.router
            .navigateTo(context, token != null ? '/' : '/login', replace: true);
        mTimerUtil.cancel();
      }
    });
    mTimerUtil.startCountDown();
    hiveInit();
  }

  @override
  void dispose() {
    super.dispose();
    if (mTimerUtil != null) mTimerUtil.cancel();
  }

  // 初始化 Hive
  void hiveInit() async {
    // path_provider插件 用于查找文件系统上常用位置
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    var box = await Hive.openBox(MyConstant.hiveName);
    Provide.value<LoginProvide>(context)
        .setValue(box.get('username') ?? '', '');
    setState(() {
      token = box.get('token');
    });
  }

  @override
  Widget build(BuildContext context) {
    // 屏幕适配初始化
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // 广告图片
        InkWell(
          onTap: () {
            Application.router.navigateTo(context, '/webView');
            mTimerUtil.cancel();
          },
          child: Image.asset(
            MyConstant.splash,
            fit: BoxFit.cover,
          ),
        ),
        // 右上角提示部件
        Positioned(
            right: MyScreen.setWidth(30),
            top: MyScreen.statusBarHeight + MyScreen.setWidth(30),
            child: InkWell(
              onTap: () {
                Application.router.navigateTo(
                    context, token != null ? '/' : '/login',
                    replace: true);
                mTimerUtil.cancel();
              },
              child: Container(
                padding:
                    MyScreen.setEdge(left: 20, top: 5, right: 20, bottom: 5),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  '跳过广告',
                  style: MyStyles.f26cf,
                ),
              ),
            ))
      ],
    ));
  }
}
