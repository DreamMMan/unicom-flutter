/*
 * @Author: liangyt
 * @Date: 2019-12-18 13:54:42
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 10:04:32
 * @Description: 首页广告进入的webview页面
 * @FilePath: /unicom_flutter/lib/pages/webViewPage.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:unicom_flutter/routes/application.dart';
import 'package:unicom_flutter/utils/index.dart';

class WebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return;
      },
      child: MaterialApp(
        routes: {
          "/": (_) => new WebviewScaffold(
                url: "https://www.igelian.com",
                appBar: new AppBar(
                  title: new Text("个联智能-全球化物联网完整解决方案"),
                  leading: InkWell(
                    onTap: () async {
                      var box = await Utils.unicomBox();
                      var token = box.get('token');
                      Application.router.navigateTo(
                          context, token != null ? '/' : '/login',
                          clearStack: true);
                    },
                    child: Icon(Icons.close, size: 36),
                  ),
                ),
              ),
        },
      ),
    );
  }
}
