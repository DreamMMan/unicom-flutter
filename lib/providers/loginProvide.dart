/*
 * @Author: liangyt
 * @Date: 2019-12-19 13:52:35
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-19 13:52:42
 * @Description: login Provide
 * @FilePath: /unicom_flutter/lib/providers/loginProvide.dart
 */
import 'package:flutter/material.dart';
import 'package:unicom_flutter/http/httpUtil.dart';
import 'package:unicom_flutter/routes/application.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/utils/rules.dart';

class LoginProvide with ChangeNotifier {
  String username = '';
  String password = '';

  // 获取手机号和密码
  void setValue(name, pwd) {
    username = name;
    password = pwd;
    notifyListeners();
  }

  // 提交登录
  void submit(BuildContext context) async {
    var box = await Utils.unicomBox();
    if (!Rules.isPhone(username)) {
      Utils.showToast('请输入正确的手机号');
      return;
    }
    if (password.trim().length < 1) {
      Utils.showToast('请输入密码');
      return;
    }
    Utils.showLoading(context);
    var params = {'username': username, 'password': password};
    HttpUtil.request('login', context, data: params).then((value) {
      if (value != null) {
        box.put('token', value);
        box.put('username', username);
        Navigator.pop(context);
        Application.router.navigateTo(context, '/');
      }
    });
  }
}
