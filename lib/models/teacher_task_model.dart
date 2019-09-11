
// 任务类型
enum ETTTaskType {
  ETTTaskTypeResourceStudy            ,//资源学习
  ETTTaskTypeInteractionCommunication ,//互动交流
  ETTTaskTypeTestQuestion             ,//试题
  ETTTaskTypePaperTest                ,//成卷测试
  ETTTaskTypeAutonomyTest             ,//自主测试
  ETTTaskTypeMicroCourseStudy         ,//微课程学习
  ETTTaskTypeLiveCourse               ,//直播课
  ETTTaskTypeRegularTask              ,//一般任务
}

// 任务子类型
enum ETTTaskSubtype {
  ETTTaskSubtypeResourceStudy             ,//资源学习类 包括（文档类任务，声音类任务，图片类，视频类/远程高清类）
  ETTTaskSubtypeInteractionCommunication  ,//互动交流
  ETTTaskSubtypeWebviewObjectiveItem      ,//webview试题（单选题，多选题，填空题）
  ETTTaskSubtypePaperTest                 ,//成卷测试
  ETTTaskSubtypeAutonomyTest              ,//自主测试
  ETTTaskSubtypeMicroCourse               ,//微课
  ETTTaskSubtypeRegularTaskVoice          ,//一般任务语音
  ETTTaskSubtypeRegularTaskPicture        ,//一般任务图片
  ETTTaskSubtypeRegularTaskText           ,//一般任务文字
  ETTTaskSubtypeLiveCourse                ,//直播课
  ETTTaskSubtypeWebviewSubjectiveItem     ,//webview试题主观题
  ETTTaskSubtypeKnowledgeGuidance         ,//知识导学
  ETTTaskAnswerSheet                      ,//答题卡
  ETTTaskAISingle                         ,//AI任务 单项任务
  ETTTaskAIStudyPlan                      ,//AI任务 学习计划
  ETTTaskHoneycomb                        ,//蜂巢任务
  ETTTaskSingSound                        ,//先声任务
}



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