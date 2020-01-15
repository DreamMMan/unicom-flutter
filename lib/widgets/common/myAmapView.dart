/*
 * @Author: liangyt
 * @Date: 2020-01-15 16:54:09
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-15 18:26:46
 * @Description: 高德地图
 * @FilePath: /unicom_flutter/lib/widgets/common/myAmapView.dart
 */
import 'package:amap_all_fluttify/amap_all_fluttify.dart';
import 'package:flutter/material.dart';
import 'package:unicom_flutter/constant/myConstant.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';

class MyAmapView extends StatefulWidget {
  final LatLng latLng;
  MyAmapView({this.latLng});
  @override
  _MyAmapViewState createState() => _MyAmapViewState();
}

class _MyAmapViewState extends State<MyAmapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('修改定位'),
      body: AmapView(
        // 地图类型
        mapType: MapType.Standard,
        // 是否显示缩放控件
        showZoomControl: true,
        // 是否显示指南针控件
        showCompass: false,
        // 是否显示比例尺控件
        showScaleControl: true,
        // 是否使能缩放手势
        zoomGesturesEnabled: true,
        // 是否使能滚动手势
        scrollGesturesEnabled: true,
        // 是否使能旋转手势
        rotateGestureEnabled: true,
        // 是否使能倾斜手势
        tiltGestureEnabled: false,
        // 缩放级别
        zoomLevel: 16,
        // 中心点坐标
        centerCoordinate: widget.latLng,
        // 标记
        markers: <MarkerOption>[
          MarkerOption(
              latLng: widget.latLng,
              title: '北京',
              snippet: '描述',
              iconUri: Uri.parse(MyConstant.marker),
              imageConfig: createLocalImageConfiguration(context))
        ],
        // 标识点击回调
        onMarkerClicked: (Marker marker) async {
          print('标识点击回调=======>$marker');
        },
        // 地图点击回调
        onMapClicked: (LatLng coord) async {
          print('标识点击回调=======>$coord');
        },
        // 地图拖动开始回调
        onMapMoveStart: (MapMove move) async {
          print('地图拖动开始回调=======>$move');
        },
        // 地图拖动结束回调
        onMapMoveEnd: (MapMove move) async {
          print('地图拖动结束回调=======>$move');
        },
        // 地图创建完成回调
        onMapCreated: (controller) async {
          // requestPermission是权限请求方法, 需要你自己实现
          if (await Utils.requestPermission()) {
            await controller.showMyLocation(true);
          }
        },
      ),
    );
  }
}
