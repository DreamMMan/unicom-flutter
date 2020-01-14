/*
 * @Author: liangyt
 * @Date: 2019-12-23 16:36:39
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-14 10:10:30
 * @Description: 站点详情
 * @FilePath: /unicom_flutter/lib/pages/siteDetailsPage.dart
 */

import 'package:amap_all_fluttify/amap_all_fluttify.dart';
import 'package:flutter/material.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';

class SiteDetailsPage extends StatefulWidget {
  @override
  _SiteDetailsPageState createState() => _SiteDetailsPageState();
}

class _SiteDetailsPageState extends State<SiteDetailsPage> {
  String addressDetails;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('站点详情'),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () async {
              if (await Utils.requestPermission()) {
                final location = await AmapLocation.fetchLocation();
                String address = await location.address;
                setState(() {
                  addressDetails = address;
                });
                print(address);
              }
            },
            child: Text('获取单次定位'),
          ),
          Text(addressDetails ?? '未定位')
        ],
      ),
    );
  }
}
