/*
 * @Author: liangyt
 * @Date: 2019-12-19 13:55:35
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 17:00:25
 * @Description: provide 集合
 * @FilePath: /unicom_flutter/lib/allProvide.dart
 */

import 'package:provide/provide.dart';
import 'package:unicom_flutter/providers/alarmDealProvide.dart';
import 'package:unicom_flutter/providers/alarmDetailsProvide.dart';
import 'package:unicom_flutter/providers/alarmProvide.dart';
import 'package:unicom_flutter/providers/homeProvide.dart';
import 'package:unicom_flutter/providers/loginProvide.dart';
import 'package:unicom_flutter/providers/orderDetailsProvide.dart';
import 'package:unicom_flutter/providers/orderProvide.dart';

allProvide() {
  final provides = Providers();
  provides
    ..provide(Provider<HomeProvide>.value(HomeProvide()))
    ..provide(Provider<LoginProvide>.value(LoginProvide()))
    ..provide(Provider<OrderProvide>.value(OrderProvide()))
    ..provide(Provider<AlarmProvide>.value(AlarmProvide()))
    ..provide(Provider<OrderDetailsProvide>.value(OrderDetailsProvide()))
    ..provide(Provider<AlarmDealProvide>.value(AlarmDealProvide()))
    ..provide(Provider<AlarmDetailsProvide>.value(AlarmDetailsProvide()));
  return provides;
}
