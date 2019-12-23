class SiteListModel {
  int total;
  List<SiteList> list;

  SiteListModel({this.total, this.list});

  SiteListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['list'] != null) {
      list = new List<SiteList>();
      json['list'].forEach((v) {
        list.add(new SiteList.fromJson(v));
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

class SiteList {
  int id;
  String name;
  String serialNumber;
  String description;
  String address;
  String targetName;
  String targetAddress;
  int status;
  int deviceStatus;

  SiteList(
      {this.id,
      this.name,
      this.serialNumber,
      this.description,
      this.address,
      this.targetName,
      this.targetAddress,
      this.status,
      this.deviceStatus});

  SiteList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serialNumber = json['serialNumber'];
    description = json['description'];
    address = json['address'];
    targetName = json['targetName'];
    targetAddress = json['targetAddress'];
    status = json['status'];
    deviceStatus = json['deviceStatus'];
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
    return data;
  }
}