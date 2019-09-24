///
/// @name TeacherQuestionModel
/// @description 教师Question model
/// @author lca
/// @date 2019-09-24
///
class TeacherQuestionModel {
  String result;
  Data data;
  String msg;

  TeacherQuestionModel({this.result, this.data, this.msg});

  TeacherQuestionModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class Data {
  int taskId;
  int isFinish;
  int taskState;
  String jspUrl;
  List<QuestionList> questionList;

  Data(
      {this.taskId,
        this.isFinish,
        this.taskState,
        this.jspUrl,
        this.questionList});

  Data.fromJson(Map<String, dynamic> json) {
    taskId = json['taskId'];
    isFinish = json['isFinish'];
    taskState = json['taskState'];
    jspUrl = json['jspUrl'];
    if (json['questionList'] != null) {
      questionList = new List<QuestionList>();
      json['questionList'].forEach((v) {
        questionList.add(new QuestionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskId'] = this.taskId;
    data['isFinish'] = this.isFinish;
    data['taskState'] = this.taskState;
    data['jspUrl'] = this.jspUrl;
    if (this.questionList != null) {
      data['questionList'] = this.questionList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionList {
  int questionId;
  int questionType;

  QuestionList({this.questionId, this.questionType});

  QuestionList.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    questionType = json['questionType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['questionType'] = this.questionType;
    return data;
  }
}