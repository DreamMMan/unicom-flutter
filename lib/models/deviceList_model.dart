class DeviceListModel {
  int total;
  List<DeviceList> list;

  DeviceListModel({this.total, this.list});

  DeviceListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['list'] != null) {
      list = new List<DeviceList>();
      json['list'].forEach((v) {
        list.add(new DeviceList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeviceList {
  int id;
  String name;
  String deviceCode;
  String deviceType;
  String deviceSn;
  String brandName;
  String deviceManufactory;
  String deviceModel;
  double power;
  String specificationModel;
  String assetsSn;
  String capacity;
  bool link;
  bool main;
  String nename;

  DeviceList(
      {this.id,
      this.name,
      this.deviceCode,
      this.deviceType,
      this.deviceSn,
      this.brandName,
      this.deviceManufactory,
      this.deviceModel,
      this.power,
      this.specificationModel,
      this.assetsSn,
      this.capacity,
      this.link,
      this.main,
      this.nename});

  DeviceList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deviceCode = json['deviceCode'];
    deviceType = json['deviceType'];
    deviceSn = json['deviceSn'];
    brandName = json['brandName'];
    deviceManufactory = json['deviceManufactory'];
    deviceModel = json['deviceModel'];
    power = json['power'];
    specificationModel = json['specificationModel'];
    assetsSn = json['assetsSn'];
    capacity = json['capacity'];
    link = json['link'];
    main = json['main'];
    nename = json['nename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['deviceCode'] = this.deviceCode;
    data['deviceType'] = this.deviceType;
    data['deviceSn'] = this.deviceSn;
    data['brandName'] = this.brandName;
    data['deviceManufactory'] = this.deviceManufactory;
    data['deviceModel'] = this.deviceModel;
    data['power'] = this.power;
    data['specificationModel'] = this.specificationModel;
    data['assetsSn'] = this.assetsSn;
    data['capacity'] = this.capacity;
    data['link'] = this.link;
    data['main'] = this.main;
    data['nename'] = this.nename;
    return data;
  }
}