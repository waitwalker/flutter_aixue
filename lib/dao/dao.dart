import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_aixue/assistant/enum_assistant.dart';
import 'package:flutter_aixue/common/network/network_manager.dart';
import 'package:flutter_aixue/common/singleton/singleton_manager.dart';
import 'package:flutter_aixue/models/class_notice_detail_model.dart';
import 'package:flutter_aixue/models/class_notice_model.dart';
import 'package:flutter_aixue/models/login_model.dart';
import 'package:flutter_aixue/models/personal_information_model.dart';
import 'package:flutter_aixue/models/student/student_subject_model.dart';
import 'package:flutter_aixue/models/teacher_course_list_model.dart';
import 'package:flutter_aixue/models/teacher_question_model.dart';
import 'package:flutter_aixue/models/teacher_task_detail_model.dart';
import 'package:flutter_aixue/models/teacher_subject_list_model.dart';
import 'package:flutter_aixue/models/teacher_task_model.dart';

///
/// @name DaoManager
/// @description Dao 管理类
/// @author lca
/// @date 2019-10-09
///
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
  static Future <ResponseData> teacherSubjectFetch(Map<String,dynamic> parameters) async {
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
  /// @Method: teacherTaskDetailFetch
  /// @Parameter:
  /// @ReturnType:
  /// @Description: 教师获取任务详情-学资源
  /// @author: lca
  /// @Date: 2019-09-02
  ///
  static Future <ResponseData> teacherResourceTaskDetailFetch(Map<String,dynamic> parameters) async {
    var response = await NetworkManager.post(Const.teacherResource, parameters);
    if (response.result) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      print("response.data:${response.data}");

      String jsonString = response.data;

      var resultMap = json.decode(jsonString);
      var model = TeacherTaskDetailModel.fromJson(resultMap);
      response.model = model;
      return response;
    } else {
      throw Exception("登录接口请求失败");
    }
  }

  ///
  /// @name teacherGeneralTaskDetailFetch
  /// @description 教师获取一般任务详情
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-09
  ///
  static Future <ResponseData> teacherGeneralTaskDetailFetch(Map<String,dynamic> parameters) async {
    var response = await NetworkManager.post(Const.teacherResource, parameters);
    if (response.result) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      print("response.data:${response.data}");

      String jsonString = response.data;

      var resultMap = json.decode(jsonString);
      var model = TeacherTaskDetailModel.fromJson(resultMap);
      response.model = model;
      return response;
    } else {
      throw Exception("登录接口请求失败");
    }
  }

  ///
  /// @Method: teacherTaskDetailFetch
  /// @Parameter:
  /// @ReturnType:
  /// @Description: 教师获取任务详情-微课程
  /// @author: lca
  /// @Date: 2019-09-23
  ///
  static Future <ResponseData> teacherMicroCourseTaskDetailFetch(Map<String,dynamic> parameters) async {
    var response = await NetworkManager.post(Const.teacherMicroCourse, parameters);
    if (response.result) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      print("response.data:${response.data}");

      String jsonString = response.data;

      var resultMap = json.decode(jsonString);
      var model = TeacherTaskDetailModel.fromJson(resultMap);
      response.model = model;
      return response;
    } else {
      throw Exception("登录接口请求失败");
    }
  }

  ///
  /// @name personalInformationFetch
  /// @description 获取个人信息
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-09-20
  ///
  static Future <ResponseData> personalInformationFetch(Map<String,dynamic> parameters) async {
    var response = await NetworkManager.post(Const.personalInformation, parameters);
    if (response.result) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      print("response.data:${response.data}");

      String jsonString = response.data;

      var resultMap = json.decode(jsonString);
      var model = PersonalInformationModel.fromJson(resultMap);
      response.model = model;
      return response;
    } else {
      throw Exception("个人信息接口请求失败");
    }
  }

  ///
  /// @name uploadAvatarFetch
  /// @description 
  /// @parameters 
  /// @return 
  /// @author lca
  /// @date 2019-09-20
  ///
  static Future<ResponseData> uploadAvatarFetch(Map<String,dynamic> parameters,{FormData data}) async {
    var response = await NetworkManager.post(Const.uploadAvatar, parameters,data: data);
    if (response.result) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      print("response.data:${response.data}");

      String jsonString = response.data;

      var resultMap = json.decode(jsonString);
      var model = PersonalInformationModel.fromJson(resultMap);
      response.model = model;
      return response;
    } else {
      throw Exception("个人信息接口请求失败");
    }
  }

  ///
  /// @name uploadAvatarFetch
  /// @description
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-09-24
  ///
  static Future<ResponseData> teacherQuestionItemTaskDetailFetch(Map<String,dynamic> parameters,{FormData data}) async {
    var response = await NetworkManager.post(Const.questionItems, parameters,data: data);
    if (response.result) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      print("response.data:${response.data}");

      String jsonString = response.data;

      var resultMap = json.decode(jsonString);
      var model = TeacherQuestionModel.fromJson(resultMap);
      response.model = model;
      return response;
    } else {
      throw Exception("个人信息接口请求失败");
    }
  }

  ///
  /// @name teacherClassNoticeListFetch
  /// @description 班级通知列表
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-12
  ///
  static Future<ResponseData> teacherClassNoticeListFetch(Map<String,dynamic> parameters,{FormData data}) async {
    var response = await NetworkManager.post(Const.classNoticeList, parameters,data: data);
    if (response.result) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      print("response.data:${response.data}");

      String jsonString = response.data;

      var resultMap = json.decode(jsonString);
      var model = ClassNoticeModel.fromJson(resultMap);
      response.model = model;
      return response;
    } else {
      throw Exception("个人信息接口请求失败");
    }
  }

  ///
  /// @name teacherClassNoticeDetailFetch
  /// @description 班级通知详情
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-12
  ///
  static Future<ResponseData> teacherClassNoticeDetailFetch(Map<String,dynamic> parameters) async {
    var response = await NetworkManager.get(Const.classNoticeDetail,parameters);
    if (response.result) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      print("response.data:${response.data}");

      String jsonString = response.data;

      var resultMap = json.decode(jsonString);
      var model = ClassNoticeDetailModel.fromJson(resultMap);
      response.model = model;
      return response;
    } else {
      throw Exception("个人信息接口请求失败");
    }
  }

  ///
  /// @name studentHomeWorkInfoFetch
  /// @description 学生首页workInfo接口
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-11-11
  ///
  static Future<ResponseData> studentHomeWorkInfoFetch(Map<String,dynamic> parameters) async {
    var response = await NetworkManager.get(Const.classNoticeDetail,parameters);
    if (response.result) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      print("response.data:${response.data}");

      String jsonString = response.data;

      var resultMap = json.decode(jsonString);
      var model = StudentSubjectModel.fromJson(resultMap);
      response.model = model;
      return response;
    } else {
      throw Exception("个人信息接口请求失败");
    }
  }



}

