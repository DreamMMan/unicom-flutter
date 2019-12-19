/*
 * @Author: liangyt
 * @Date: 2019-12-19 14:42:20
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-19 14:44:16
 * @Description: 规则校验
 * @FilePath: /unicom_flutter/lib/utils/rules.dart
 */

class Rules {
  ///手机号验证
  static bool isPhone(String str) {
    return RegExp(
            r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$")
        .hasMatch(str);
  }
}
