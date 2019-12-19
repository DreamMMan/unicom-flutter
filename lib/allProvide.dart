/*
 * @Author: liangyt
 * @Date: 2019-12-19 13:55:35
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-19 13:59:26
 * @Description: provide 集合
 * @FilePath: /unicom_flutter/lib/allProvide.dart
 */

import 'package:provide/provide.dart';
import 'package:unicom_flutter/providers/loginProvide.dart';

allProvide() {
  final provides = Providers();
  provides..provide(Provider<LoginProvide>.value(LoginProvide()));
  return provides;
}
