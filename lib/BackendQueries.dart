import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kdeccourse/models/Category.dart';
import 'package:kdeccourse/models/CourseInfo.dart';
import 'package:kdeccourse/models/Parent.dart';
import 'package:youtube_parser/youtube_parser.dart';

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
}