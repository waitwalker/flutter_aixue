///
/// @name StudentSubjectModel
/// @description 学生首页WorkInfoModel
/// @author lca
/// @date 2019-11-11
///
class StudentSubjectModel {
  Data data;
  String msg;
  int result;

  StudentSubjectModel({this.data, this.msg, this.result});

  StudentSubjectModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    msg = json['msg'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['msg'] = this.msg;
    data['result'] = this.result;
    return data;
  }
}

class Data {
  List<ClassTypeList> classTypeList;

  Data({this.classTypeList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['classTypeList'] != null) {
      classTypeList = new List<ClassTypeList>();
      json['classTypeList'].forEach((v) {
        classTypeList.add(new ClassTypeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.classTypeList != null) {
      data['classTypeList'] =
          this.classTypeList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClassTypeList {
  int classType;
  int joinState;
  List<SubjectList> subjectList;

  ClassTypeList({this.classType, this.joinState, this.subjectList});

  ClassTypeList.fromJson(Map<String, dynamic> json) {
    classType = json['classType'];
    joinState = json['joinState'];
    if (json['subjectList'] != null) {
      subjectList = new List<SubjectList>();
      json['subjectList'].forEach((v) {
        subjectList.add(new SubjectList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classType'] = this.classType;
    data['joinState'] = this.joinState;
    if (this.subjectList != null) {
      data['subjectList'] = this.subjectList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubjectList {
  int allTask;
  int asAllCount;
  int asUncorrectionCount;
  int asUnfinishedCount;
  String classHint;
  String dateHint;
  String subjectIcon;
  int subjectId;
  String subjectName;
  int unfinishedNum;

  SubjectList(
      {this.allTask,
        this.asAllCount,
        this.asUncorrectionCount,
        this.asUnfinishedCount,
        this.classHint,
        this.dateHint,
        this.subjectIcon,
        this.subjectId,
        this.subjectName,
        this.unfinishedNum});

  SubjectList.fromJson(Map<String, dynamic> json) {
    allTask = json['allTask'];
    asAllCount = json['asAllCount'];
    asUncorrectionCount = json['asUncorrectionCount'];
    asUnfinishedCount = json['asUnfinishedCount'];
    classHint = json['classHint'];
    dateHint = json['dateHint'];
    subjectIcon = json['subjectIcon'];
    subjectId = json['subjectId'];
    subjectName = json['subjectName'];
    unfinishedNum = json['unfinishedNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allTask'] = this.allTask;
    data['asAllCount'] = this.asAllCount;
    data['asUncorrectionCount'] = this.asUncorrectionCount;
    data['asUnfinishedCount'] = this.asUnfinishedCount;
    data['classHint'] = this.classHint;
    data['dateHint'] = this.dateHint;
    data['subjectIcon'] = this.subjectIcon;
    data['subjectId'] = this.subjectId;
    data['subjectName'] = this.subjectName;
    data['unfinishedNum'] = this.unfinishedNum;
    return data;
  }
}