/*
 * @Author: liangyt
 * @Date: 2019-12-21 17:14:27
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-15 17:40:08
 * @Description: 常量
 * @FilePath: /unicom_flutter/lib/constant/myConstant.dart
 */

import 'package:flutter/material.dart';

class MyConstant {
  // hive的box name
  static const String hiveName = 'unicomBox';
  //  高德地图ioskey
  static const String mapKey = 'ef4b58f7cb47e5e8d9ab48c32c8ed7dc';
  // 区域列表
  static const List regionList = [
    {'name': '全部区域', 'code': null},
    {'name': '罗湖区', 'code': 440303},
    {'name': '福田区', 'code': 440304},
    {'name': '南山区', 'code': 440305},
    {'name': '宝安区', 'code': 440306},
    {'name': '龙岗区', 'code': 440307},
    {'name': '盐田区', 'code': 440308},
    {'name': '龙华新区', 'code': 440309},
    {'name': '光明新区', 'code': 440310},
    {'name': '坪山新区', 'code': 440311}
  ];

  // 图片名字
  static const String loginBg = 'assets/images/login_bg.png';
  static const String splash = 'assets/images/splash.png';
  static const String deleteIcon = 'assets/images/close1.png';
  static const String phoneIcon = 'assets/images/phone.png';
  static const String passwordIcon = 'assets/images/password.png';
  static const String orderDefault = 'assets/images/order_default.png';
  static const String orderActive = 'assets/images/order_active.png';
  static const String alarmDefault = 'assets/images/alarm_default.png';
  static const String alarmActive = 'assets/images/alarm_active.png';
  static const String userIcon = 'assets/images/user_icon.png';
  static const String searchIcon = 'assets/images/search.png';
  static const String alarmIcon1 = 'assets/images/alarm_icon1.png';
  static const String alarmIcon2 = 'assets/images/alarm_icon2.png';
  static const String upload = 'assets/images/upload.png';
  static const String marker = 'assets/images/marker.png';

  // 阿里巴巴矢量图标
  static const IconData arrowIcon = IconData(0xe775, fontFamily: 'iconfont');
}
