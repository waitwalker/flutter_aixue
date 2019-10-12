
///
/// @name ClassNoticeDetailModel
/// @description 班级通知详情model
/// @author lca
/// @date 2019-10-12
///
class ClassNoticeDetailModel {
  int result;
  String msg;
  Data data;

  ClassNoticeDetailModel({this.result, this.msg, this.data});

  ClassNoticeDetailModel.fromJson(Map<String, dynamic> json) {
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
  String replyImg;
  int canReply;
  List<SecondaryReplyList> secondaryReplyList;
  int priseNum;
  String replyContent;
  String replyTime;
  String replyTitle;
  int replyId;
  int replyNum;

  Data(
      {this.replyImg,
        this.canReply,
        this.secondaryReplyList,
        this.priseNum,
        this.replyContent,
        this.replyTime,
        this.replyTitle,
        this.replyId,
        this.replyNum});

  Data.fromJson(Map<String, dynamic> json) {
    replyImg = json['replyImg'];
    canReply = json['canReply'];
    if (json['secondaryReplyList'] != null) {
      secondaryReplyList = new List<SecondaryReplyList>();
      json['secondaryReplyList'].forEach((v) {
        secondaryReplyList.add(new SecondaryReplyList.fromJson(v));
      });
    }
    priseNum = json['priseNum'];
    replyContent = json['replyContent'];
    replyTime = json['replyTime'];
    replyTitle = json['replyTitle'];
    replyId = json['replyId'];
    replyNum = json['replyNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['replyImg'] = this.replyImg;
    data['canReply'] = this.canReply;
    if (this.secondaryReplyList != null) {
      data['secondaryReplyList'] =
          this.secondaryReplyList.map((v) => v.toJson()).toList();
    }
    data['priseNum'] = this.priseNum;
    data['replyContent'] = this.replyContent;
    data['replyTime'] = this.replyTime;
    data['replyTitle'] = this.replyTitle;
    data['replyId'] = this.replyId;
    data['replyNum'] = this.replyNum;
    return data;
  }
}

class SecondaryReplyList {
  String replyContent;
  UserInfo userInfo;
  String replyTime;
  int replyId;

  SecondaryReplyList(
      {this.replyContent, this.userInfo, this.replyTime, this.replyId});

  SecondaryReplyList.fromJson(Map<String, dynamic> json) {
    replyContent = json['replyContent'];
    userInfo = json['userInfo'] != null
        ? new UserInfo.fromJson(json['userInfo'])
        : null;
    replyTime = json['replyTime'];
    replyId = json['replyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['replyContent'] = this.replyContent;
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo.toJson();
    }
    data['replyTime'] = this.replyTime;
    data['replyId'] = this.replyId;
    return data;
  }
}

class UserInfo {
  String userPhoto;
  String userName;
  int block;
  int isBlocked;
  int userType;
  int userId;

  UserInfo(
      {this.userPhoto,
        this.userName,
        this.block,
        this.isBlocked,
        this.userType,
        this.userId});

  UserInfo.fromJson(Map<String, dynamic> json) {
    userPhoto = json['userPhoto'];
    userName = json['userName'];
    block = json['block'];
    isBlocked = json['isBlocked'];
    userType = json['userType'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userPhoto'] = this.userPhoto;
    data['userName'] = this.userName;
    data['block'] = this.block;
    data['isBlocked'] = this.isBlocked;
    data['userType'] = this.userType;
    data['userId'] = this.userId;
    return data;
  }
}