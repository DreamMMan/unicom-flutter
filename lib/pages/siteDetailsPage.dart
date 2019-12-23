/*
 * @Author: liangyt
 * @Date: 2019-12-23 16:36:39
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 16:37:49
 * @Description: 站点详情
 * @FilePath: /unicom_flutter/lib/pages/siteDetailsPage.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';

class SiteDetailsPage extends StatefulWidget {
  @override
  _SiteDetailsPageState createState() => _SiteDetailsPageState();
}

class _SiteDetailsPageState extends State<SiteDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('站点详情'),
    );
  }
}
