import 'package:flutter_aixue/assistant/enum_assistant.dart';


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

  ETTTaskType kTaskType;
  ETTTaskSubtype kTaskSubtype;

  LastTaskList(
      {this.taskId,
        this.scaleHint,
        this.undeal,
        this.jspUrl,
        this.taskType,
        this.dateHint,
        this.taskSubType,
        this.taskName,
        this.kTaskType,
        this.kTaskSubtype,
      });

  LastTaskList.fromJson(Map<String, dynamic> json) {
    taskId = json['taskId'];
    scaleHint = json['scaleHint'];
    undeal = json['undeal'];
    jspUrl = json['jspUrl'];
    taskType = json['taskType'];
    dateHint = json['dateHint'];
    taskSubType = json['taskSubType'];
    taskName = json['taskName'];

    switch (taskType) {
      case 1:
        kTaskType = ETTTaskType.ETTTaskTypeResourceStudy;
        break;
      case 2:
        kTaskType = ETTTaskType.ETTTaskTypeInteractionCommunication;
        break;
      case 3:
        kTaskType = ETTTaskType.ETTTaskTypeTestQuestion;
        break;
      case 4:
        kTaskType = ETTTaskType.ETTTaskTypePaperTest;
        break;
      case 5:
        kTaskType = ETTTaskType.ETTTaskTypeAutonomyTest;
        break;
      case 6:
        kTaskType = ETTTaskType.ETTTaskTypeMicroCourseStudy;
        break;
      case 7:
        kTaskType = ETTTaskType.ETTTaskTypeLiveCourse;
        break;
      case 8:
        kTaskType = ETTTaskType.ETTTaskTypeRegularTask;
        break;
    }

    switch (taskSubType) {
      case 1:
        kTaskSubtype = ETTTaskSubtype.ETTTaskSubtypeResourceStudy;
        break;
      case 2:
        kTaskSubtype = ETTTaskSubtype.ETTTaskSubtypeInteractionCommunication;
        break;
      case 3:
        kTaskSubtype = ETTTaskSubtype.ETTTaskSubtypeWebviewObjectiveItem;
        break;
      case 4:
        kTaskSubtype = ETTTaskSubtype.ETTTaskSubtypePaperTest;
        break;
      case 5:
        kTaskSubtype = ETTTaskSubtype.ETTTaskSubtypeAutonomyTest;
        break;
      case 6:
        kTaskSubtype = ETTTaskSubtype.ETTTaskSubtypeMicroCourse;
        break;
      case 7:
        kTaskSubtype = ETTTaskSubtype.ETTTaskSubtypeRegularTaskVoice;
        break;
      case 8:
        kTaskSubtype = ETTTaskSubtype.ETTTaskSubtypeRegularTaskPicture;
        break;
      case 9:
        kTaskSubtype = ETTTaskSubtype.ETTTaskSubtypeRegularTaskText;
        break;
      case 10:
        kTaskSubtype = ETTTaskSubtype.ETTTaskSubtypeLiveCourse;
        break;
      case 11:
        kTaskSubtype = ETTTaskSubtype.ETTTaskSubtypeWebviewSubjectiveItem;
        break;
      case 12:
        kTaskSubtype = ETTTaskSubtype.ETTTaskSubtypeKnowledgeGuidance;
        break;
      case 14:
        kTaskSubtype = ETTTaskSubtype.ETTTaskAnswerSheet;
        break;
      case 15:
        kTaskSubtype = ETTTaskSubtype.ETTTaskAISingle;
        break;
      case 16:
        kTaskSubtype = ETTTaskSubtype.ETTTaskAIStudyPlan;
        break;
      case 17:
        kTaskSubtype = ETTTaskSubtype.ETTTaskHoneycomb;
        break;
      case 18:
        kTaskSubtype = ETTTaskSubtype.ETTTaskSingSound;
        break;

    }

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