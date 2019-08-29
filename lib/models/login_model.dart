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
  String onlineTestUrl;
  int squareFlag;
  int sex;
  String schoolName;
  int gradeId;
  String accessToken;
  int isFiveFour;
  int stuHasClass;
  String city;
  int isHorizontal;
  String expires;
  int shouldComplete;
  String userName;
  int jid;
  int hbhxFlag;
  int classCircleFlag;
  String ygId;
  int srcId;
  int srcUid;
  String photo;
  String childCode;
  int uType;
  String tigasePwd;
  int isHasLink;
  String liveLessonUrl;
  String vodLessonUrl;
  String realName;
  int schoolId;

  Data(
      {this.onlineTestUrl,
        this.squareFlag,
        this.sex,
        this.schoolName,
        this.gradeId,
        this.accessToken,
        this.isFiveFour,
        this.stuHasClass,
        this.city,
        this.isHorizontal,
        this.expires,
        this.shouldComplete,
        this.userName,
        this.jid,
        this.hbhxFlag,
        this.classCircleFlag,
        this.ygId,
        this.srcId,
        this.srcUid,
        this.photo,
        this.childCode,
        this.uType,
        this.tigasePwd,
        this.isHasLink,
        this.liveLessonUrl,
        this.vodLessonUrl,
        this.realName,
        this.schoolId});

  Data.fromJson(Map<String, dynamic> json) {
    onlineTestUrl = json['onlineTestUrl'];
    squareFlag = json['squareFlag'];
    sex = json['sex'];
    schoolName = json['schoolName'];
    gradeId = json['gradeId'];
    accessToken = json['accessToken'];
    isFiveFour = json['isFiveFour'];
    stuHasClass = json['stuHasClass'];
    city = json['city'];
    isHorizontal = json['isHorizontal'];
    expires = json['expires'];
    shouldComplete = json['shouldComplete'];
    userName = json['userName'];
    jid = json['jid'];
    hbhxFlag = json['hbhxFlag'];
    classCircleFlag = json['classCircleFlag'];
    ygId = json['ygId'];
    srcId = json['srcId'];
    srcUid = json['srcUid'];
    photo = json['photo'];
    childCode = json['childCode'];
    uType = json['uType'];
    tigasePwd = json['tigasePwd'];
    isHasLink = json['isHasLink'];
    liveLessonUrl = json['liveLessonUrl'];
    vodLessonUrl = json['vodLessonUrl'];
    realName = json['realName'];
    schoolId = json['schoolId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['onlineTestUrl'] = this.onlineTestUrl;
    data['squareFlag'] = this.squareFlag;
    data['sex'] = this.sex;
    data['schoolName'] = this.schoolName;
    data['gradeId'] = this.gradeId;
    data['accessToken'] = this.accessToken;
    data['isFiveFour'] = this.isFiveFour;
    data['stuHasClass'] = this.stuHasClass;
    data['city'] = this.city;
    data['isHorizontal'] = this.isHorizontal;
    data['expires'] = this.expires;
    data['shouldComplete'] = this.shouldComplete;
    data['userName'] = this.userName;
    data['jid'] = this.jid;
    data['hbhxFlag'] = this.hbhxFlag;
    data['classCircleFlag'] = this.classCircleFlag;
    data['ygId'] = this.ygId;
    data['srcId'] = this.srcId;
    data['srcUid'] = this.srcUid;
    data['photo'] = this.photo;
    data['childCode'] = this.childCode;
    data['uType'] = this.uType;
    data['tigasePwd'] = this.tigasePwd;
    data['isHasLink'] = this.isHasLink;
    data['liveLessonUrl'] = this.liveLessonUrl;
    data['vodLessonUrl'] = this.vodLessonUrl;
    data['realName'] = this.realName;
    data['schoolId'] = this.schoolId;
    return data;
  }
}