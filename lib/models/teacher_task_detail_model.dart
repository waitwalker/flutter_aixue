

///
/// @name TeacherMicroSourceModel
/// @description 教师任务详情model - 学资源,微课...
/// @author lca
/// @date 2019-09-23
///
class TeacherTaskDetailModel {
  int result;
  Data data;

  TeacherTaskDetailModel({this.result, this.data});

  TeacherTaskDetailModel.fromJson(Map<String, dynamic> json) {
    var resultType = json["result"];
    var type = resultType.runtimeType;
    if (type == "".runtimeType) {
      print("String 类型");
      result = json['result'];
    } else {
      result = json['result'];
    }
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int taskId;
  String taskTitle;
  String videoPlayTime;
  String jspUrl;
  List<UserReplyList> userReplyList;
  String videoUrl;
  int resId;
  String videoPicUrl;
  int isLastPage;

  String statisticsUrl;
  int taskInfoType;
  List<ResourceList> resourceList;

  Data(
      {this.taskId,
        this.taskTitle,
        this.videoPlayTime,
        this.jspUrl,
        this.userReplyList,
        this.videoUrl,
        this.resId,
        this.videoPicUrl,
        this.isLastPage,
        this.statisticsUrl,
        this.resourceList,
        this.taskInfoType,
      });

  Data.fromJson(Map<String, dynamic> json) {
    taskId = json['taskId'];
    taskTitle = json['taskTitle'];
    videoPlayTime = json['videoPlayTime'];
    jspUrl = json['jspUrl'];
    statisticsUrl = json['statisticsUrl'];
    taskInfoType = json['taskInfoType'];
    if (json['userReplyList'] != null) {
      userReplyList = new List<UserReplyList>();
      json['userReplyList'].forEach((v) {
        userReplyList.add(new UserReplyList.fromJson(v));
      });
    }
    if (json['resourceList'] != null) {
      resourceList = new List<ResourceList>();
      json['resourceList'].forEach((v) {
        resourceList.add(new ResourceList.fromJson(v));
      });
    }
    videoUrl = json['videoUrl'];
    resId = json['resId'];
    videoPicUrl = json['videoPicUrl'];
    isLastPage = json['isLastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskId'] = this.taskId;
    data['taskTitle'] = this.taskTitle;
    data['videoPlayTime'] = this.videoPlayTime;
    data['jspUrl'] = this.jspUrl;

    data['statisticsUrl'] = this.statisticsUrl;
    data['taskInfoType'] = this.taskInfoType;

    if (this.userReplyList != null) {
      data['userReplyList'] =
          this.userReplyList.map((v) => v.toJson()).toList();
    }
    if (this.resourceList != null) {
      data['resourceList'] = this.resourceList.map((v) => v.toJson()).toList();
    }
    data['videoUrl'] = this.videoUrl;
    data['resId'] = this.resId;
    data['videoPicUrl'] = this.videoPicUrl;
    data['isLastPage'] = this.isLastPage;
    return data;
  }
}

class ResourceList {
  String resourceSuffix;
  String resourceUrl;
  int resourceType;

  ResourceList({this.resourceSuffix, this.resourceUrl, this.resourceType});

  ResourceList.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("resourceSuffix")) {
      resourceSuffix = json['resourceSuffix'];
    }
    resourceUrl = json['resourceUrl'];
    resourceType = json['resourceType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (data.containsKey("resourceSuffix")) {
      data['resourceSuffix'] = this.resourceSuffix;
    }
    data['resourceUrl'] = this.resourceUrl;
    data['resourceType'] = this.resourceType;
    return data;
  }
}

class UserReplyList {
  String attachType;
  int replyType;
  List<ResourceList> resourceList;
  int isPrised;
  int priseNum;
  String replyContent;
  UserInfo userInfo;
  String replyTime;
  int replyId;
  int replyNum;

  UserReplyList(
      {this.attachType,
        this.replyType,
        this.resourceList,
        this.isPrised,
        this.priseNum,
        this.replyContent,
        this.userInfo,
        this.replyTime,
        this.replyId,
        this.replyNum});

  UserReplyList.fromJson(Map<String, dynamic> json) {
    attachType = json['attachType'];
    replyType = json['replyType'];
    if (json['resourceList'] != null) {
      resourceList = new List<ResourceList>();
      json['resourceList'].forEach((v) {
        resourceList.add(new ResourceList.fromJson(v));
      });
    }
    isPrised = json['isPrised'];
    priseNum = json['priseNum'];
    replyContent = json['replyContent'];
    userInfo = json['userInfo'] != null
        ? new UserInfo.fromJson(json['userInfo'])
        : null;
    replyTime = json['replyTime'];
    replyId = json['replyId'];
    replyNum = json['replyNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attachType'] = this.attachType;
    data['replyType'] = this.replyType;
    if (this.resourceList != null) {
      data['resourceList'] = this.resourceList.map((v) => v.toJson()).toList();
    }
    data['isPrised'] = this.isPrised;
    data['priseNum'] = this.priseNum;
    data['replyContent'] = this.replyContent;
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo.toJson();
    }
    data['replyTime'] = this.replyTime;
    data['replyId'] = this.replyId;
    data['replyNum'] = this.replyNum;
    return data;
  }
}

class UserInfo {
  String userId;
  String userPhoto;
  String block;
  String userName;
  String isBlocked;
  String userType;

  UserInfo({this.userId,
    this.userPhoto,
    this.block,
    this.userName,
    this.isBlocked,
    this.userType});

  UserInfo.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userPhoto = json['userPhoto'];
    block = json['block'];
    userName = json['userName'];
    isBlocked = json['isBlocked'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userPhoto'] = this.userPhoto;
    data['block'] = this.block;
    data['userName'] = this.userName;
    data['isBlocked'] = this.isBlocked;
    data['userType'] = this.userType;
    return data;
  }
}