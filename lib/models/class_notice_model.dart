
///
/// @name ClassNoticeModel
/// @description 
/// @author lca
/// @date 2019-10-12
///
class ClassNoticeModel {
  int result;
  String msg;
  Data data;

  ClassNoticeModel({this.result, this.msg, this.data});

  ClassNoticeModel.fromJson(Map<String, dynamic> json) {
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
  List<ClassList> classList;
  List<ActivityList> activityList;
  int pageNum;

  Data({this.classList, this.activityList, this.pageNum});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['classList'] != null) {
      classList = new List<ClassList>();
      json['classList'].forEach((v) {
        classList.add(new ClassList.fromJson(v));
      });
    }
    if (json['activityList'] != null) {
      activityList = new List<ActivityList>();
      json['activityList'].forEach((v) {
        activityList.add(new ActivityList.fromJson(v));
      });
    }
    pageNum = json['pageNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.classList != null) {
      data['classList'] = this.classList.map((v) => v.toJson()).toList();
    }
    if (this.activityList != null) {
      data['activityList'] = this.activityList.map((v) => v.toJson()).toList();
    }
    data['pageNum'] = this.pageNum;
    return data;
  }
}

class ClassList {
  int classId;
  int classType;
  String className;

  ClassList({this.classId, this.classType, this.className});

  ClassList.fromJson(Map<String, dynamic> json) {
    classId = json['classId'];
    classType = json['classType'];
    className = json['className'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classId'] = this.classId;
    data['classType'] = this.classType;
    data['className'] = this.className;
    return data;
  }
}

class ActivityList {
  int activityId;
  String activityTitle;
  String activityTime;
  String activityPic;

  ActivityList(
      {this.activityId,
        this.activityTitle,
        this.activityTime,
        this.activityPic});

  ActivityList.fromJson(Map<String, dynamic> json) {
    activityId = json['activityId'];
    activityTitle = json['activityTitle'];
    activityTime = json['activityTime'];
    activityPic = json['activityPic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activityId'] = this.activityId;
    data['activityTitle'] = this.activityTitle;
    data['activityTime'] = this.activityTime;
    data['activityPic'] = this.activityPic;
    return data;
  }
}