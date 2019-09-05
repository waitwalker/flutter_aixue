class TeacherResourceDocumentModel {
  int result;
  Data data;

  TeacherResourceDocumentModel({this.result, this.data});

  TeacherResourceDocumentModel.fromJson(Map<String, dynamic> json) {
    result = int.parse(json['result']);
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
  String statisticsUrl;
  String taskTitle;
  int taskInfoType;
  List<ResourceList> resourceList;
  List<UserReplyList> userReplyList;
  int isLastPage;
  String jspUrl;

  Data(
      {this.taskId,
        this.statisticsUrl,
        this.taskTitle,
        this.taskInfoType,
        this.resourceList,
        this.userReplyList,
        this.isLastPage,
        this.jspUrl});

  Data.fromJson(Map<String, dynamic> json) {
    taskId = json['taskId'];
    statisticsUrl = json['statisticsUrl'];
    taskTitle = json['taskTitle'];
    taskInfoType = json['taskInfoType'];
    if (json['resourceList'] != null) {
      resourceList = new List<ResourceList>();
      json['resourceList'].forEach((v) {
        resourceList.add(new ResourceList.fromJson(v));
      });
    }
    if (json['userReplyList'] != null) {
      userReplyList = new List<UserReplyList>();
      json['userReplyList'].forEach((v) {
        userReplyList.add(new UserReplyList.fromJson(v));
      });
    }
    isLastPage = json['isLastPage'];
    jspUrl = json['jspUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskId'] = this.taskId;
    data['statisticsUrl'] = this.statisticsUrl;
    data['taskTitle'] = this.taskTitle;
    data['taskInfoType'] = this.taskInfoType;
    if (this.resourceList != null) {
      data['resourceList'] = this.resourceList.map((v) => v.toJson()).toList();
    }
    if (this.userReplyList != null) {
      data['userReplyList'] =
          this.userReplyList.map((v) => v.toJson()).toList();
    }
    data['isLastPage'] = this.isLastPage;
    data['jspUrl'] = this.jspUrl;
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

  UserInfo(
      {this.userId,
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