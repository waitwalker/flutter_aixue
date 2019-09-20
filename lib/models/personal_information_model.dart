
///
/// @name PersonalInformationModel
/// @description 个人信息model
/// @author lca
/// @date 2019-09-20
///
class PersonalInformationModel {
  int result;
  String msg;
  Data data;

  PersonalInformationModel({this.result, this.msg, this.data});

  PersonalInformationModel.fromJson(Map<String, dynamic> json) {
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
  String uName;
  String phone;
  int sex;
  String schoolName;
  int gradeId;
  int isOtherUser;
  int block;
  int isBlocked;
  int userType;
  String subjectStr;
  String uPhoto;
  int isFriend;
  String nickName;
  int jid;

  Data(
      {this.uName,
        this.phone,
        this.sex,
        this.schoolName,
        this.gradeId,
        this.isOtherUser,
        this.block,
        this.isBlocked,
        this.userType,
        this.subjectStr,
        this.uPhoto,
        this.isFriend,
        this.nickName,
        this.jid});

  Data.fromJson(Map<String, dynamic> json) {
    uName = json['uName'];
    phone = json['phone'];
    sex = json['sex'];
    schoolName = json['schoolName'];
    gradeId = json['gradeId'];
    isOtherUser = json['isOtherUser'];
    block = json['block'];
    isBlocked = json['isBlocked'];
    userType = json['userType'];
    subjectStr = json['subjectStr'];
    uPhoto = json['uPhoto'];
    isFriend = json['isFriend'];
    nickName = json['nickName'];
    jid = json['jid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uName'] = this.uName;
    data['phone'] = this.phone;
    data['sex'] = this.sex;
    data['schoolName'] = this.schoolName;
    data['gradeId'] = this.gradeId;
    data['isOtherUser'] = this.isOtherUser;
    data['block'] = this.block;
    data['isBlocked'] = this.isBlocked;
    data['userType'] = this.userType;
    data['subjectStr'] = this.subjectStr;
    data['uPhoto'] = this.uPhoto;
    data['isFriend'] = this.isFriend;
    data['nickName'] = this.nickName;
    data['jid'] = this.jid;
    return data;
  }
}