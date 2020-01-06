/*
 * @Author: liangyt
 * @Date: 2020-01-02 15:03:13
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-06 19:47:40
 * @Description: provide 集合
 * @FilePath: /unicom_flutter/lib/utils/myProvide.dart
 */

import 'package:provide/provide.dart';
import 'package:unicom_flutter/providers/alarmDealProvide.dart';
import 'package:unicom_flutter/providers/alarmDetailsProvide.dart';
import 'package:unicom_flutter/providers/alarmProvide.dart';
import 'package:unicom_flutter/providers/homeProvide.dart';
import 'package:unicom_flutter/providers/imageProvide.dart';
import 'package:unicom_flutter/providers/lifeAuditProivde.dart';
import 'package:unicom_flutter/providers/lifeSiteDetailsProvide.dart';
import 'package:unicom_flutter/providers/loginProvide.dart';
import 'package:unicom_flutter/providers/orderDetailsProvide.dart';
import 'package:unicom_flutter/providers/orderProvide.dart';

myProvide() {
  final provides = Providers();
  provides
    ..provide(Provider<HomeProvide>.value(HomeProvide()))
    ..provide(Provider<LoginProvide>.value(LoginProvide()))
    ..provide(Provider<OrderProvide>.value(OrderProvide()))
    ..provide(Provider<AlarmProvide>.value(AlarmProvide()))
    ..provide(Provider<OrderDetailsProvide>.value(OrderDetailsProvide()))
    ..provide(Provider<AlarmDealProvide>.value(AlarmDealProvide()))
    ..provide(Provider<AlarmDetailsProvide>.value(AlarmDetailsProvide()))
    ..provide(Provider<LifeSiteDetailsProvide>.value(LifeSiteDetailsProvide()))
    ..provide(Provider<LifeAuditProvide>.value(LifeAuditProvide()))
    ..provide(Provider<ImageProvide>.value(ImageProvide()));
  return provides;
}
