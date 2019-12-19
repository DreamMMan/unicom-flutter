/*
 * @Author: liangyt
 * @Date: 2019-12-18 10:50:53
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-18 14:08:07
 * @Description: 首页
 * @FilePath: /unicom_flutter/lib/pages/homePage.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/routes/application.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/widgets/myAppBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('首页'),
      body: Container(
        child: RaisedButton(
          onPressed: () async {
            var box = await Utils.unicomBox();
            box.delete('token');
            Application.router.navigateTo(context, '/login', replace: true);
          },
          child: Text('退出登录'),
        ),
      ),
    );
  }
}
