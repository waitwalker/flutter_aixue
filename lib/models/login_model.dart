
class LoginModel {
  int result;
  String msg;
  Data data;

  LoginModel({this.result, this.msg, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  int sex;
  String schoolName;
  int gradeId;
  String accessToken;
  String photo;
  String city;
  int hasClass;
  int isHorizontal;
  String tigasePwd;
  int uType;
  String expires;
  int shouldComplete;
  String userName;
  String realName;
  int jid;
  int schoolId;

  Data(
      {this.sex,
        this.schoolName,
        this.gradeId,
        this.accessToken,
        this.photo,
        this.city,
        this.hasClass,
        this.isHorizontal,
        this.tigasePwd,
        this.uType,
        this.expires,
        this.shouldComplete,
        this.userName,
        this.realName,
        this.jid,
        this.schoolId});

  Data.fromJson(Map<String, dynamic> json) {
    sex = json['sex'];
    schoolName = json['schoolName'];
    gradeId = json['gradeId'];
    accessToken = json['accessToken'];
    photo = json['photo'];
    city = json['city'];
    hasClass = json['hasClass'];
    isHorizontal = json['isHorizontal'];
    tigasePwd = json['tigasePwd'];
    uType = json['uType'];
    expires = json['expires'];
    shouldComplete = json['shouldComplete'];
    userName = json['userName'];
    realName = json['realName'];
    jid = json['jid'];
    schoolId = json['schoolId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sex'] = this.sex;
    data['schoolName'] = this.schoolName;
    data['gradeId'] = this.gradeId;
    data['accessToken'] = this.accessToken;
    data['photo'] = this.photo;
    data['city'] = this.city;
    data['hasClass'] = this.hasClass;
    data['isHorizontal'] = this.isHorizontal;
    data['tigasePwd'] = this.tigasePwd;
    data['uType'] = this.uType;
    data['expires'] = this.expires;
    data['shouldComplete'] = this.shouldComplete;
    data['userName'] = this.userName;
    data['realName'] = this.realName;
    data['jid'] = this.jid;
    data['schoolId'] = this.schoolId;
    return data;
  }
}