import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kdeccourse/models/category_model.dart';
import 'package:kdeccourse/models/course_model.dart';
import 'package:kdeccourse/models/parent_model.dart';
import 'package:kdeccourse/models/progress_model.dart';
import 'package:youtube_parser/youtube_parser.dart';

import 'models/user_model.dart';

class BackendQueries {
  static const BASE_URL = "https://kdec-course.herokuapp.com";
  static const IMG_URL = "$BASE_URL/api/img/";

  static Future<CourseInfo> getCourseInfo(String course) async {
    var response = await http.get(Uri.parse("$BASE_URL/api/course/$course"));
    final vs = CourseInfo.fromJson(jsonDecode(Utf8Decoder().convert(response.bodyBytes)));
    print(vs.courseLink);
    print(getIdFromUrl(vs.courseLink));

    return CourseInfo.fromJson(jsonDecode(Utf8Decoder().convert(response.bodyBytes)));
  }
  static Future<List<CourseInfo>> getAllCourses(String name) async {
    var response = await http.get(Uri.parse("$BASE_URL/api/course/all/$name"));


    List<CourseInfo> list = <CourseInfo>[];
    if (response.statusCode == 200) {
      try {
        var albums = jsonDecode(Utf8Decoder().convert(response.bodyBytes));
        for (var a in albums) {
          list.add(CourseInfo.fromJson(a));
        }
      } catch (e) {
        print(e.toString());
      }
    }
    return list;
  }
  static Future<List<Category>> getAllCategories(String parent) async {
    var response = await http.get(Uri.parse("$BASE_URL/api/category/$parent"));

    List<Category> list = <Category>[];
    if (response.statusCode == 200) {
      try {
        var albums = jsonDecode(Utf8Decoder().convert(response.bodyBytes));
        for (var a in albums) {
          list.add(Category.fromJson(a));
        }
      } catch (e) {
        print(e.toString());
      }
    }
    return list;
  }
  static Future<List<Parent>> getAllParents() async {
    var response = await http.get(Uri.parse("$BASE_URL/api/parent/all"));

    List<Parent> list = <Parent>[];
    if (response.statusCode == 200) {
      try {
        var albums = jsonDecode(Utf8Decoder().convert(response.bodyBytes));
        for (var a in albums) {
          list.add(Parent.fromJson(a));
        }
      } catch (e) {
        print(e.toString());
      }
    }
    print(list);
    return list;
  }
  static Future<String> createUser(String token,String user) async {
    var response = await http.post(Uri.parse("$BASE_URL/api/users/create/$token"),  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: user);
    return response.body;
  }
  static Future<UserModel> getUserInfo(String idToken) async {
    var response = await http.get(Uri.parse("$BASE_URL/api/users/$idToken"));
    var result = UserModel.fromJson(jsonDecode(Utf8Decoder().convert(response.bodyBytes)));
    return result;
  }
  static Future<ProgressModel> addProgress(ProgressModel progressModel) async {
    var response = await http.post(Uri.parse("$BASE_URL/api/progress/create/"),  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: progressModel);
    return ProgressModel.fromJson(jsonDecode(Utf8Decoder().convert(response.bodyBytes)));
  }
  static Future<ProgressModel> getProgress(ProgressModel progressModel) async {
    var response = await http.post(Uri.parse("$BASE_URL/api/progress/course/"),  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: progressModel);
    return ProgressModel.fromJson(jsonDecode(Utf8Decoder().convert(response.bodyBytes)));
  }
}