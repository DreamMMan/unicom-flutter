/*
 * @Author: liangyt
 * @Date: 2019-12-21 17:14:27
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-02 14:47:22
 * @Description: 常量
 * @FilePath: /unicom_flutter/lib/constant/myConstant.dart
 */


class MyConstant {
  // hive的box name
  static const String hiveName = 'unicomBox';

  // 区域列表
  static List regionList = [
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
  static const String loginBg = 'assets/login_bg.png';
  static const String deleteIcon = 'assets/close1.png';
  static const String phoneIcon = 'assets/phone.png';
  static const String passwordIcon = 'assets/password.png';
  static const String orderDefault = 'assets/order_default.png';
  static const String orderActive = 'assets/order_active.png';
  static const String alarmDefault = 'assets/alarm_default.png';
  static const String alarmActive = 'assets/alarm_active.png';
  static const String userIcon = 'assets/user_icon.png';
  static const String searchIcon = 'assets/search.png';
  static const String alarmIcon1 = 'assets/alarm_icon1.png';
  static const String alarmIcon2 = 'assets/alarm_icon2.png';
}
