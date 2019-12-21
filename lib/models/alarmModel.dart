class AlarmModel {
  int total;
  List<AlarmList> list;

  AlarmModel({this.total, this.list});

  AlarmModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['list'] != null) {
      list = new List<AlarmList>();
      json['list'].forEach((v) {
        list.add(new AlarmList.fromJson(v));
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

class AlarmList {
  int id;
  String name;
  int createTime;
  String siteName;
  String sn;
  String lineName;
  int dtuId;
  int removeTime;
  String handUserInfo;

  AlarmList(
      {this.id,
      this.name,
      this.createTime,
      this.siteName,
      this.sn,
      this.lineName,
      this.dtuId,
      this.removeTime,
      this.handUserInfo});

  AlarmList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createTime = json['createTime'];
    siteName = json['siteName'];
    sn = json['sn'];
    lineName = json['lineName'];
    dtuId = json['dtuId'];
    removeTime = json['removeTime'];
    handUserInfo = json['handUserInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['createTime'] = this.createTime;
    data['siteName'] = this.siteName;
    data['sn'] = this.sn;
    data['lineName'] = this.lineName;
    data['dtuId'] = this.dtuId;
    data['removeTime'] = this.removeTime;
    data['handUserInfo'] = this.handUserInfo;
    return data;
  }
}