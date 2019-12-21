/*
 * @Author: liangyt
 * @Date: 2019-12-19 13:55:35
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-21 15:03:35
 * @Description: provide 集合
 * @FilePath: /unicom_flutter/lib/allProvide.dart
 */

import 'package:provide/provide.dart';
import 'package:unicom_flutter/providers/alarmProvide.dart';
import 'package:unicom_flutter/providers/loginProvide.dart';
import 'package:unicom_flutter/providers/orderProvide.dart';

allProvide() {
  final provides = Providers();
  provides
    ..provide(Provider<LoginProvide>.value(LoginProvide()))
    ..provide(Provider<OrderProvide>.value(OrderProvide()))
    ..provide(Provider<AlarmProvide>.value(AlarmProvide()));
  return provides;
}
