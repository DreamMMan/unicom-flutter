class SiteDetailsModel {
  int id;
  String name;
  String serialNumber;
  String description;
  String address;
  String targetName;
  String targetAddress;
  int status;
  int deviceStatus;
  int deviceNum;
  int linkNum;
  List<DtuList> dtuList;
  bool canReceipt;

  SiteDetailsModel(
      {this.id,
      this.name,
      this.serialNumber,
      this.description,
      this.address,
      this.targetName,
      this.targetAddress,
      this.status,
      this.deviceStatus,
      this.deviceNum,
      this.linkNum,
      this.dtuList,
      this.canReceipt});

  SiteDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serialNumber = json['serialNumber'];
    description = json['description'];
    address = json['address'];
    targetName = json['targetName'];
    targetAddress = json['targetAddress'];
    status = json['status'];
    deviceStatus = json['deviceStatus'];
    deviceNum = json['deviceNum'];
    linkNum = json['linkNum'];
    if (json['dtuList'] != null) {
      dtuList = new List<DtuList>();
      json['dtuList'].forEach((v) {
        dtuList.add(new DtuList.fromJson(v));
      });
    }
    canReceipt = json['canReceipt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['serialNumber'] = this.serialNumber;
    data['description'] = this.description;
    data['address'] = this.address;
    data['targetName'] = this.targetName;
    data['targetAddress'] = this.targetAddress;
    data['status'] = this.status;
    data['deviceStatus'] = this.deviceStatus;
    data['deviceNum'] = this.deviceNum;
    data['linkNum'] = this.linkNum;
    if (this.dtuList != null) {
      data['dtuList'] = this.dtuList.map((v) => v.toJson()).toList();
    }
    data['canReceipt'] = this.canReceipt;
    return data;
  }
}

class DtuList {
  int id;
  String name;
  bool online;
  String imei;
  List<AmmeterList> ammeterList;
  int updateTime;

  DtuList(
      {this.id,
      this.name,
      this.online,
      this.imei,
      this.ammeterList,
      this.updateTime});

  DtuList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    online = json['online'];
    imei = json['imei'];
    if (json['ammeterList'] != null) {
      ammeterList = new List<AmmeterList>();
      json['ammeterList'].forEach((v) {
        ammeterList.add(new AmmeterList.fromJson(v));
      });
    }
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['online'] = this.online;
    data['imei'] = this.imei;
    if (this.ammeterList != null) {
      data['ammeterList'] = this.ammeterList.map((v) => v.toJson()).toList();
    }
    data['updateTime'] = this.updateTime;
    return data;
  }
}

class AmmeterList {
  int id;
  String name;
  String sn;
  List<LineList> lineList;

  AmmeterList({this.id, this.name, this.sn, this.lineList});

  AmmeterList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sn = json['sn'];
    if (json['lineList'] != null) {
      lineList = new List<LineList>();
      json['lineList'].forEach((v) {
        lineList.add(new LineList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sn'] = this.sn;
    if (this.lineList != null) {
      data['lineList'] = this.lineList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LineList {
  int id;
  String name;
  int status;
  List<DeviceList> deviceList;

  LineList({this.id, this.name, this.status, this.deviceList});

  LineList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
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