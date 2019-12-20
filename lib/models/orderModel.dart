class OrderModel {
  int total;
  List<MyList> list;

  OrderModel({this.total, this.list});

  OrderModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['list'] != null) {
      list = new List<MyList>();
      json['list'].forEach((v) {
        list.add(new MyList.fromJson(v));
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

class MyList {
  int id;
  String name;
  int plannedTime;
  int createdTime;
  String ticketNo;
  int rejectionNum;
  int processingNum;
  int completedNum;
  int pendingNum;

  MyList(
      {this.id,
      this.name,
      this.plannedTime,
      this.createdTime,
      this.ticketNo,
      this.rejectionNum,
      this.processingNum,
      this.completedNum,
      this.pendingNum});

  MyList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    plannedTime = json['plannedTime'];
    createdTime = json['createdTime'];
    ticketNo = json['ticketNo'];
    rejectionNum = json['rejectionNum'];
    processingNum = json['processingNum'];
    completedNum = json['completedNum'];
    pendingNum = json['pendingNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['plannedTime'] = this.plannedTime;
    data['createdTime'] = this.createdTime;
    data['ticketNo'] = this.ticketNo;
    data['rejectionNum'] = this.rejectionNum;
    data['processingNum'] = this.processingNum;
    data['completedNum'] = this.completedNum;
    data['pendingNum'] = this.pendingNum;
    return data;
  }
}
