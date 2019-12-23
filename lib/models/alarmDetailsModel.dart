class AlarmDetailsModel {
  int id;
  String name;
  int createTime;
  String siteName;
  String sn;
  String lineName;
  int dtuId;
  int removeTime;
  String handUserInfo;
  int updateTime;
  String siteAddress;
  int siteId;
  bool remove;
  String handDescription;

  AlarmDetailsModel(
      {this.id,
      this.name,
      this.createTime,
      this.siteName,
      this.sn,
      this.lineName,
      this.dtuId,
      this.removeTime,
      this.handUserInfo,
      this.updateTime,
      this.siteAddress,
      this.siteId,
      this.remove,
      this.handDescription});

  AlarmDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createTime = json['createTime'];
    siteName = json['siteName'];
    sn = json['sn'];
    lineName = json['lineName'];
    dtuId = json['dtuId'];
    removeTime = json['removeTime'];
    handUserInfo = json['handUserInfo'];
    updateTime = json['updateTime'];
    siteAddress = json['siteAddress'];
    siteId = json['siteId'];
    remove = json['remove'];
    handDescription = json['handDescription'];
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
    data['updateTime'] = this.updateTime;
    data['siteAddress'] = this.siteAddress;
    data['siteId'] = this.siteId;
    data['remove'] = this.remove;
    data['handDescription'] = this.handDescription;
    return data;
  }
}
