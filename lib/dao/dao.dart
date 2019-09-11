
import 'dart:convert';

import 'package:flutter_aixue/common/network/network_manager.dart';
import 'package:flutter_aixue/common/singleton/singleton_manager.dart';
import 'package:flutter_aixue/models/login_model.dart';
import 'package:flutter_aixue/models/teacher_course_list_model.dart';
import 'package:flutter_aixue/models/teacher_resource_model.dart';
import 'package:flutter_aixue/models/teacher_subject_list_model.dart';
import 'package:flutter_aixue/models/teacher_task_model.dart';

class DaoManager {

  ///
  /// @Method: loginFetch
  /// @Parameter:
  /// @ReturnType:
  /// @Description: 获取登录接口数据
  /// @author: lca
  /// @Date: 2019-09-02
  ///
  static Future <ResponseData> loginFetch(Map<String,dynamic> parameters) async {
    var response = await NetworkManager.post(Const.loginInterface, parameters);
    if (response.result) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      print("response.data:${response.data}");

      String jsonString = response.data;

      var resultMap = json.decode(jsonString);
      var loginModel = LoginModel.fromJson(resultMap);
        response.model = loginModel;
        SingletonManager.sharedInstance.loginModel = loginModel;
        return response;
    } else {
      throw Exception("登录接口请求失败");
    }
  }

  ///
  /// @Method: teacherRecentTaskFetch
  /// @Parameter:
  /// @ReturnType:
  /// @Description: 教师获取最近任务
  /// @author: lca
  /// @Date: 2019-09-02
  ///
  static Future <ResponseData> teacherRecentTaskFetch(Map<String,dynamic> parameters) async {
    var response = await NetworkManager.post(Const.teacherRecentTask, parameters);
    if (response.result) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      print("response.data:${response.data}");

      String jsonString = response.data;

      var resultMap = json.decode(jsonString);
      var model = TeacherTaskModel.fromJson(resultMap);
      response.model = model;
      return response;
    } else {
      throw Exception("登录接口请求失败");
    }
  }

  ///
  /// @Method: teacherSubjectsFetch
  /// @Parameter:
  /// @ReturnType:
  /// @Description: 教师获取学科列表
  /// @author: lca
  /// @Date: 2019-09-02
  ///
  static Future <ResponseData> teacherSubjectsFetch(Map<String,dynamic> parameters) async {
    var response = await NetworkManager.post(Const.teacherSubjectList, parameters);
    if (response.result) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      print("response.data:${response.data}");

      String jsonString = response.data;

      var resultMap = json.decode(jsonString);
      var model = TeacherSubjectListModel.fromJson(resultMap);
      response.model = model;
      return response;
    } else {
      throw Exception("登录接口请求失败");
    }
  }

  ///
  /// @Method: teacherCourseFetch
  /// @Parameter:
  /// @ReturnType:
  /// @Description: 教师获取课程列表
  /// @author: lca
  /// @Date: 2019-09-02
  ///
  static Future <ResponseData> teacherCourseFetch(Map<String,dynamic> parameters) async {
    var response = await NetworkManager.post(Const.teacherCourseList, parameters);
    if (response.result) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      print("response.data:${response.data}");

      String jsonString = response.data;

      var resultMap = json.decode(jsonString);
      var model = TeacherCourseListModel.fromJson(resultMap);
      response.model = model;
      return response;
    } else {
      throw Exception("登录接口请求失败");
    }
  }

  ///
  /// @Method: teacherResourceDocumentFetch
  /// @Parameter:
  /// @ReturnType:
  /// @Description: 教师获取学资源文档
  /// @author: lca
  /// @Date: 2019-09-02
  ///
  static Future <ResponseData> teacherResourceDocumentFetch(Map<String,dynamic> parameters) async {
    var response = await NetworkManager.post(Const.teacherResourceDocument, parameters);
    if (response.result) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      print("response.data:${response.data}");

      String jsonString = response.data;

      var resultMap = json.decode(jsonString);
      var model = TeacherResourceModel.fromJson(resultMap);
      response.model = model;
      return response;
    } else {
      throw Exception("登录接口请求失败");
    }
  }


}

