
///
/// @name AvatarModel
/// @description 头像model
/// @author lca
/// @date 2019-09-20
///
class AvatarModel {
  int result;
  String msg;
  Data data;

  AvatarModel({this.result, this.msg, this.data});

  AvatarModel.fromJson(Map<String, dynamic> json) {
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
  String userPhoto;

  Data({this.userPhoto});

  Data.fromJson(Map<String, dynamic> json) {
    userPhoto = json['userPhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userPhoto'] = this.userPhoto;
    return data;
  }
}