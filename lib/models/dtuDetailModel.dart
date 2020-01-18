class DtuDetailModel {
  int id;
  String name;
  double rssi;
  bool online;
  String imei;
  List<AmmeterList> ammeterList;
  int updateTime;
  bool wiredOnline;

  DtuDetailModel(
      {this.id,
      this.name,
      this.rssi,
      this.online,
      this.imei,
      this.ammeterList,
      this.updateTime,
      this.wiredOnline});

  DtuDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rssi = json['rssi'];
    online = json['online'];
    imei = json['imei'];
    if (json['ammeterList'] != null) {
      ammeterList = new List<AmmeterList>();
      json['ammeterList'].forEach((v) {
        ammeterList.add(new AmmeterList.fromJson(v));
      });
    }
    updateTime = json['updateTime'];
    wiredOnline = json['wiredOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['rssi'] = this.rssi;
    data['online'] = this.online;
    data['imei'] = this.imei;
    if (this.ammeterList != null) {
      data['ammeterList'] = this.ammeterList.map((v) => v.toJson()).toList();
    }
    data['updateTime'] = this.updateTime;
    data['wiredOnline'] = this.wiredOnline;
    return data;
  }
}

class AmmeterList {
  int id;
  String name;
  String deviceCode;
  double temperature;
  double humidity;
  double used;
  bool alarming;
  String sn;
  List<LineList> lineList;
  String ammeterName;
  int status;

  AmmeterList(
      {this.id,
      this.name,
      this.deviceCode,
      this.temperature,
      this.humidity,
      this.used,
      this.alarming,
      this.sn,
      this.lineList,
      this.ammeterName,
      this.status});

  AmmeterList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deviceCode = json['deviceCode'];
    temperature = json['temperature'];
    humidity = json['humidity'];
    used = json['used'];
    alarming = json['alarming'];
    sn = json['sn'];
    if (json['lineList'] != null) {
      lineList = new List<LineList>();
      json['lineList'].forEach((v) {
        lineList.add(new LineList.fromJson(v));
      });
    }
    ammeterName = json['ammeterName'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['deviceCode'] = this.deviceCode;
    data['temperature'] = this.temperature;
    data['humidity'] = this.humidity;
    data['used'] = this.used;
    data['alarming'] = this.alarming;
    data['sn'] = this.sn;
    if (this.lineList != null) {
      data['lineList'] = this.lineList.map((v) => v.toJson()).toList();
    }
    data['ammeterName'] = this.ammeterName;
    data['status'] = this.status;
    return data;
  }
}

class LineList {
  int id;
  String name;
  int status;
  double voltage;
  double current;
  double pt;
  double ct;
  List<DeviceList> deviceList;

  LineList(
      {this.id,
      this.name,
      this.status,
      this.voltage,
      this.current,
      this.pt,
      this.ct,
      this.deviceList});

  LineList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    voltage = json['voltage'];
    current = json['current'];
    pt = json['pt'];
    ct = json['ct'];
    if (json['deviceList'] != null) {
      deviceList = new List<DeviceList>();
      json['deviceList'].forEach((v) {
        deviceList.add(new DeviceList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['voltage'] = this.voltage;
    data['current'] = this.current;
    data['pt'] = this.pt;
    data['ct'] = this.ct;
    if (this.deviceList != null) {
      data['deviceList'] = this.deviceList.map((v) => v.toJson()).toList();
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
  String power;
  String specificationModel;
  String assetsSn;
  String capacity;
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
    data['nename'] = this.nename;
    return data;
  }
}
