class RpinsModel {
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
  List<JobList> jobList;
  bool canReceipt;

  RpinsModel(
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
      this.jobList,
      this.canReceipt});

  RpinsModel.fromJson(Map<String, dynamic> json) {
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
    if (json['jobList'] != null) {
      jobList = new List<JobList>();
      json['jobList'].forEach((v) {
        jobList.add(new JobList.fromJson(v));
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
    if (this.jobList != null) {
      data['jobList'] = this.jobList.map((v) => v.toJson()).toList();
    }
    data['canReceipt'] = this.canReceipt;
    return data;
  }
}

class JobList {
  int id;
  String name;
  bool submit;

  JobList({this.id, this.name, this.submit});

  JobList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    submit = json['submit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['submit'] = this.submit;
    return data;
  }
}
