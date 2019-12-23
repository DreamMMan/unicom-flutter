/*
 * @Author: liangyt
 * @Date: 2019-12-21 17:14:27
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 10:12:29
 * @Description: 常量
 * @FilePath: /unicom_flutter/lib/utils/constant.dart
 */

class Constant {
  // hive的box name
  static String hiveName = 'unicomBox';

  // 区域列表
  static List regionList = [
    {'name': '全部区域', 'code': null},
    {'name': '罗湖区', 'code': 1},
    {'name': '福田区', 'code': 2},
    {'name': '南山区', 'code': 3},
    {'name': '宝安区', 'code': 4},
    {'name': '龙岗区', 'code': 5},
    {'name': '盐田区', 'code': 6},
    {'name': '龙华新区', 'code': 7},
    {'name': '光明新区', 'code': 8},
    {'name': '坪山新区', 'code': 9}
  ];

  // 图片名字
  static String loginBg = 'assets/login_bg.png';
  static String deleteIcon = 'assets/close1.png';
  static String phoneIcon = 'assets/phone.png';
  static String passwordIcon = 'assets/password.png';
  static String orderDefault = 'assets/order_default.png';
  static String orderActive = 'assets/order_active.png';
  static String alarmDefault = 'assets/alarm_default.png';
  static String alarmActive = 'assets/alarm_active.png';
  static String userIcon = 'assets/user_icon.png';
  static String searchIcon = 'assets/search.png';
}
