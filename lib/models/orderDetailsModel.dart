class OrderDetailsModel {
  int id;
  String name;
  int plannedTime;
  int createdTime;
  String ticketNo;
  int rejectionNum;
  int processingNum;
  int completedNum;
  int pendingNum;
  String content;
  int totalSite;

  OrderDetailsModel(
      {this.id,
      this.name,
      this.plannedTime,
      this.createdTime,
      this.ticketNo,
      this.rejectionNum,
      this.processingNum,
      this.completedNum,
      this.pendingNum,
      this.content,
      this.totalSite});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    plannedTime = json['plannedTime'];
    createdTime = json['createdTime'];
    ticketNo = json['ticketNo'];
    rejectionNum = json['rejectionNum'];
    processingNum = json['processingNum'];
    completedNum = json['completedNum'];
    pendingNum = json['pendingNum'];
    content = json['content'];
    totalSite = json['totalSite'];
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
    data['content'] = this.content;
    data['totalSite'] = this.totalSite;
    return data;
  }
}