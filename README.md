# unicom_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# 缺少 空调、蓄电池、常规动力、设备修改时上传图片和添加水印和页面某些元素的显示和隐藏问题

Column(
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
      )
