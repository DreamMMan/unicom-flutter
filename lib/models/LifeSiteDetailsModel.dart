class LifeSiteDetailsModel {
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
  List<DeviceList> deviceList;
  int targetType;

  LifeSiteDetailsModel(
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
      this.deviceList,
      this.targetType});

  LifeSiteDetailsModel.fromJson(Map<String, dynamic> json) {
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
    if (json['deviceList'] != null) {
      deviceList = new List<DeviceList>();
      json['deviceList'].forEach((v) {
        deviceList.add(new DeviceList.fromJson(v));
      });
    }
    targetType = json['targetType'];
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
    if (this.deviceList != null) {
      data['deviceList'] = this.deviceList.map((v) => v.toJson()).toList();
    }
    data['targetType'] = this.targetType;
    return data;
  }
}

class DeviceList {
  int id;
  String name;
  int status;
  int usedStatus;
  int enableTime;
  String deviceCode;
  String deviceType;
  String deviceSn;
  String assetsSn;
  String brandName;
  String deviceManufactory;
  String deviceModel;
  String power;
  String specificationModel;
  String capacity;
  int backupTime;
  int moduleNum;
  bool canN1;
  int num;
  int moduleModel;
  String nename;

  DeviceList(
      {this.id,
      this.name,
      this.status,
      this.usedStatus,
      this.enableTime,
      this.deviceCode,
      this.deviceType,
      this.deviceSn,
      this.assetsSn,
      this.brandName,
      this.deviceManufactory,
      this.deviceModel,
      this.power,
      this.specificationModel,
      this.capacity,
      this.backupTime,
      this.moduleNum,
      this.canN1,
      this.num,
      this.moduleModel,
      this.nename});

  DeviceList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    usedStatus = json['usedStatus'];
    enableTime = json['enableTime'];
    deviceCode = json['deviceCode'];
    deviceType = json['deviceType'];
    deviceSn = json['deviceSn'];
    assetsSn = json['assetsSn'];
    brandName = json['brandName'];
    deviceManufactory = json['deviceManufactory'];
    deviceModel = json['deviceModel'];
    power = json['power'];
    specificationModel = json['specificationModel'];
    capacity = json['capacity'];
    backupTime = json['backupTime'];
    moduleNum = json['moduleNum'];
    canN1 = json['canN1'];
    num = json['num'];
    moduleModel = json['moduleModel'];
    nename = json['nename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['usedStatus'] = this.usedStatus;
    data['enableTime'] = this.enableTime;
    data['deviceCode'] = this.deviceCode;
    data['deviceType'] = this.deviceType;
    data['deviceSn'] = this.deviceSn;
    data['assetsSn'] = this.assetsSn;
    data['brandName'] = this.brandName;
    data['deviceManufactory'] = this.deviceManufactory;
    data['deviceModel'] = this.deviceModel;
    data['power'] = this.power;
    data['specificationModel'] = this.specificationModel;
    data['capacity'] = this.capacity;
    data['backupTime'] = this.backupTime;
    data['moduleNum'] = this.moduleNum;
    data['canN1'] = this.canN1;
    data['num'] = this.num;
    data['moduleModel'] = this.moduleModel;
    data['nename'] = this.nename;
    return data;
  }
}
