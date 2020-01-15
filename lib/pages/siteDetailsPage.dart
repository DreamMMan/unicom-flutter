/*
 * @Author: liangyt
 * @Date: 2019-12-23 16:36:39
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-15 18:16:33
 * @Description: 数据采集建设站点详情
 * @FilePath: /unicom_flutter/lib/pages/siteDetailsPage.dart
 */

import 'package:amap_all_fluttify/amap_all_fluttify.dart';
import 'package:flutter/material.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/widgets/common/myAmapView.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';

class SiteDetailsPage extends StatefulWidget {
  @override
  _SiteDetailsPageState createState() => _SiteDetailsPageState();
}

class _SiteDetailsPageState extends State<SiteDetailsPage> {
  String addressDetails;
  LatLng latLng;
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
                LatLng latLngs = await location.latLng;
                print(latLngs);
                setState(() {
                  addressDetails = address;
                  latLng = latLngs;
                });
                print(address);
              }
            },
            child: Text('获取单次定位'),
          ),
          Text(addressDetails ?? '未定位'),
          RaisedButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (BuildContext contetx) {
                    return MyAmapView(
                      latLng: latLng,
                    );
                  });
            },
            child: Text('打开地图'),
          ),
          RaisedButton(
            onPressed: () async {
              final poiList = await AmapSearch.searchKeyword('深圳市天吉大厦');
              String address = await poiList[0].address;
              print(address);
            },
            child: Text('搜索'),
          ),
        ],
      ),
    );
  }
}
