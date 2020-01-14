class AirBatModel {
  int id;
  List<String> nameList;
  bool submit;
  int submitTimestamp;
  List<DeviceList> deviceList;

  AirBatModel(
      {this.id,
      this.nameList,
      this.submit,
      this.submitTimestamp,
      this.deviceList});

  AirBatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameList = json['nameList'].cast<String>();
    submit = json['submit'];
    submitTimestamp = json['submitTimestamp'];
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
    data['nameList'] = this.nameList;
    data['submit'] = this.submit;
    data['submitTimestamp'] = this.submitTimestamp;
    if (this.deviceList != null) {
      data['deviceList'] = this.deviceList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeviceList {
  int id;
  String name;
  String deviceSn;
  String brandName;
  String description;
  int status;
  int backupTime;
  int moduleNum;
  bool canN1;
  String otherDanger;
  List<DangerList> dangerList;

  DeviceList(
      {this.id,
      this.name,
      this.deviceSn,
      this.brandName,
      this.description,
      this.status,
      this.backupTime,
      this.moduleNum,
      this.canN1,
      this.otherDanger,
      this.dangerList});

  DeviceList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deviceSn = json['deviceSn'];
    brandName = json['brandName'];
    description = json['description'];
    status = json['status'];
    backupTime = json['backupTime'];
    moduleNum = json['moduleNum'];
    canN1 = json['canN1'];
    otherDanger = json['otherDanger'];
    if (json['dangerList'] != null) {
      dangerList = new List<DangerList>();
      json['dangerList'].forEach((v) {
        dangerList.add(new DangerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['deviceSn'] = this.deviceSn;
    data['brandName'] = this.brandName;
    data['description'] = this.description;
    data['status'] = this.status;
    data['backupTime'] = this.backupTime;
    data['moduleNum'] = this.moduleNum;
    data['canN1'] = this.canN1;
    data['otherDanger'] = this.otherDanger;
    if (this.dangerList != null) {
      data['dangerList'] = this.dangerList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DangerList {
  int id;
  String name;
  bool enable;

  DangerList({this.id, this.name, this.enable});

  DangerList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    enable = json['enable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['enable'] = this.enable;
    return data;
  }
}
