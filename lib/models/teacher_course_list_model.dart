class TeacherCourseListModel {
  int result;
  String msg;
  Data data;

  TeacherCourseListModel({this.result, this.msg, this.data});

  TeacherCourseListModel.fromJson(Map<String, dynamic> json) {
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
  List<LessonList> lessonList;
  int pageNum;

  Data({this.lessonList, this.pageNum});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['lessonList'] != null) {
      lessonList = new List<LessonList>();
      json['lessonList'].forEach((v) {
        lessonList.add(new LessonList.fromJson(v));
      });
    }
    pageNum = json['pageNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lessonList != null) {
      data['lessonList'] = this.lessonList.map((v) => v.toJson()).toList();
    }
    data['pageNum'] = this.pageNum;
    return data;
  }
}

class LessonList {
  String lessonName;
  int lessonId;
  int beginTime;
  int endTime;

  LessonList({this.lessonName, this.lessonId, this.beginTime, this.endTime});

  LessonList.fromJson(Map<String, dynamic> json) {
    lessonName = json['lessonName'];
    lessonId = json['lessonId'];
    beginTime = json['beginTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lessonName'] = this.lessonName;
    data['lessonId'] = this.lessonId;
    data['beginTime'] = this.beginTime;
    data['endTime'] = this.endTime;
    return data;
  }
}