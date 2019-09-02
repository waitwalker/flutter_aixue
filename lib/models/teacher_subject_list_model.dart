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
  List<SubjectList> subjectList;

  Data({this.subjectList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['subjectList'] != null) {
      subjectList = new List<SubjectList>();
      json['subjectList'].forEach((v) {
        subjectList.add(new SubjectList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subjectList != null) {
      data['subjectList'] = this.subjectList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubjectList {
  int gradeId;
  int materialId;
  List<ClassList> classList;
  int subjectId;

  SubjectList({this.gradeId, this.materialId, this.classList, this.subjectId});

  SubjectList.fromJson(Map<String, dynamic> json) {
    gradeId = json['gradeId'];
    materialId = json['materialId'];
    if (json['classList'] != null) {
      classList = new List<ClassList>();
      json['classList'].forEach((v) {
        classList.add(new ClassList.fromJson(v));
      });
    }
    subjectId = json['subjectId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gradeId'] = this.gradeId;
    data['materialId'] = this.materialId;
    if (this.classList != null) {
      data['classList'] = this.classList.map((v) => v.toJson()).toList();
    }
    data['subjectId'] = this.subjectId;
    return data;
  }
}

class ClassList {
  int classId;
  String className;

  ClassList({this.classId, this.className});

  ClassList.fromJson(Map<String, dynamic> json) {
    classId = json['classId'];
    className = json['className'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classId'] = this.classId;
    data['className'] = this.className;
    return data;
  }
}