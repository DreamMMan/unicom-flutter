/*
 * @Author: liangyt
 * @Date: 2019-12-18 13:54:42
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-18 14:06:09
 * @Description: 首页广告进入的webview页面
 * @FilePath: /unicom_flutter/lib/pages/webViewPage.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:unicom_flutter/routes/application.dart';

class WebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (_) => new WebviewScaffold(
              url: "https://www.igelian.com",
              appBar: new AppBar(
                title: new Text("Widget webview"),
                leading: InkWell(
                  onTap: () {
                    Application.router.navigateTo(context, '/', replace: true);
                  },
                  child: Icon(Icons.keyboard_arrow_left, size: 36),
                ),
              ),
            ),
      },
    );
  }
}
