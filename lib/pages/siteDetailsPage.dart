/*
 * @Author: liangyt
 * @Date: 2019-12-23 16:36:39
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-13 21:53:40
 * @Description: 站点详情
 * @FilePath: /unicom_flutter/lib/pages/siteDetailsPage.dart
 */

import 'package:amap_all_fluttify/amap_all_fluttify.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';

class SiteDetailsPage extends StatefulWidget {
  @override
  _SiteDetailsPageState createState() => _SiteDetailsPageState();
}

class _SiteDetailsPageState extends State<SiteDetailsPage> {
  Location _location;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('站点详情'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('获取单次定位'),
            onPressed: () async {
              if (await Utils.requestPermission()) {
                final location = await AmapLocation.fetchLocation();
                setState(() => _location = location);
              }
            },
          ),
          RaisedButton(
            child: Text('获取连续定位'),
            onPressed: () async {
              if (await Utils.requestPermission()) {
                await for (final location in AmapLocation.listenLocation()) {
                  setState(() => _location = location);
                }
              }
            },
          ),
          RaisedButton(
            child: Text('停止定位'),
            onPressed: () async {
              if (await Utils.requestPermission()) {
                await AmapLocation.stopLocation();
                setState(() => _location = null);
              }
            },
          ),
          _location != null
              ? FutureBuilder<String>(
                  initialData: '',
                  future: _location.address,
                  builder: (_, ss) =>
                      Center(child: Text('address: ${ss.data}' ?? '')),
                )
              : Container,
          _location != null
              ? FutureBuilder<String>(
                  initialData: '',
                  future: _location.country,
                  builder: (_, ss) =>
                      Center(child: Text('country: ${ss.data}' ?? '')),
                )
              : Container,
          _location != null
              ? FutureBuilder<String>(
                  initialData: '',
                  future: _location.province,
                  builder: (_, ss) =>
                      Center(child: Text('province: ${ss.data}' ?? '')),
                )
              : Container,
          _location != null
              ? FutureBuilder<String>(
                  initialData: '',
                  future: _location.city,
                  builder: (_, ss) =>
                      Center(child: Text('city: ${ss.data}' ?? '')),
                )
              : Container,
          _location != null
              ? FutureBuilder<String>(
                  initialData: '',
                  future: _location.district,
                  builder: (_, ss) =>
                      Center(child: Text('district: ${ss.data}' ?? '')),
                )
              : Container,
          _location != null
              ? FutureBuilder<String>(
                  initialData: '',
                  future: _location.poiName,
                  builder: (_, ss) =>
                      Center(child: Text('poiName: ${ss.data}' ?? '')),
                )
              : Container,
          _location != null
              ? FutureBuilder<String>(
                  initialData: '',
                  future: _location.street,
                  builder: (_, ss) =>
                      Center(child: Text('street: ${ss.data}' ?? '')),
                )
              : Container,
          _location != null
              ? FutureBuilder<String>(
                  initialData: '',
                  future: _location.aoiName,
                  builder: (_, ss) =>
                      Center(child: Text('aoiName: ${ss.data}' ?? '')),
                )
              : Container,
          _location != null
              ? FutureBuilder<double>(
                  initialData: 0.0,
                  future: _location.latLng.then((it) => it.latitude),
                  builder: (_, ss) =>
                      Center(child: Text('latitude: ${ss.data}' ?? '')),
                )
              : Container,
          _location != null
              ? FutureBuilder<double>(
                  initialData: 0.0,
                  future: _location.latLng.then((it) => it.longitude),
                  builder: (_, ss) =>
                      Center(child: Text('longitude: ${ss.data}' ?? '')),
                )
              : Container,
          _location != null
              ? FutureBuilder<double>(
                  initialData: 0.0,
                  future: _location.altitude,
                  builder: (_, ss) =>
                      Center(child: Text('altitude: ${ss.data}' ?? '')),
                )
              : Container,
          _location != null
              ? FutureBuilder<double>(
                  initialData: 0.0,
                  future: _location.bearing,
                  builder: (_, ss) =>
                      Center(child: Text('bearing: ${ss.data}' ?? '')),
                )
              : Container,
          _location != null
              ? FutureBuilder<double>(
                  initialData: 0.0,
                  future: _location.accuracy,
                  builder: (_, ss) =>
                      Center(child: Text('accuracy: ${ss.data}' ?? '')),
                )
              : Container,
        ],
      ),
    );
  }
}
