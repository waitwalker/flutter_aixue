class TeacherTaskModel {
  int result;
  String msg;
  Data data;

  TeacherTaskModel({this.result, this.msg, this.data});

  TeacherTaskModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<LastTaskList> lastTaskList;
  int hasNewNotice;

  Data({this.lastTaskList, this.hasNewNotice});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['lastTaskList'] != null) {
      lastTaskList = new List<LastTaskList>();
      json['lastTaskList'].forEach((v) {
        lastTaskList.add(new LastTaskList.fromJson(v));
      });
    }
    hasNewNotice = json['hasNewNotice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lastTaskList != null) {
      data['lastTaskList'] = this.lastTaskList.map((v) => v.toJson()).toList();
    }
    data['hasNewNotice'] = this.hasNewNotice;
    return data;
  }
}

class LastTaskList {
  int taskId;
  String scaleHint;
  int undeal;
  String jspUrl;
  int taskType;
  String dateHint;
  int taskSubType;
  String taskName;

  LastTaskList(
      {this.taskId,
        this.scaleHint,
        this.undeal,
        this.jspUrl,
        this.taskType,
        this.dateHint,
        this.taskSubType,
        this.taskName});

  LastTaskList.fromJson(Map<String, dynamic> json) {
    taskId = json['taskId'];
    scaleHint = json['scaleHint'];
    undeal = json['undeal'];
    jspUrl = json['jspUrl'];
    taskType = json['taskType'];
    dateHint = json['dateHint'];
    taskSubType = json['taskSubType'];
    taskName = json['taskName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskId'] = this.taskId;
    data['scaleHint'] = this.scaleHint;
    data['undeal'] = this.undeal;
    data['jspUrl'] = this.jspUrl;
    data['taskType'] = this.taskType;
    data['dateHint'] = this.dateHint;
    data['taskSubType'] = this.taskSubType;
    data['taskName'] = this.taskName;
    return data;
  }
}