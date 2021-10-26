import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kdeccourse/models/Category.dart';
import 'package:kdeccourse/models/CourseInfo.dart';
import 'package:kdeccourse/models/Parent.dart';

class BackendQueries {
  static const BASE_URL = "https://kdechurch.herokuapp.com";
  static const IMG_URL = "$BASE_URL/api/img/";

  static Future<List<CourseInfo>> getCategoriesInfo(String name) async {
    var response = await http.get(Uri.parse("$BASE_URL/api/course/$name"));


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

  static Future<Category> getAllCategories(String parent) async {
    var response = await http.get(Uri.parse("$BASE_URL/api/category/$parent"));
    return Category.fromJson(
        jsonDecode(Utf8Decoder().convert(response.bodyBytes)));
  }
  static Future<Parent> getAllParents() async {
    var response = await http.get(Uri.parse("$BASE_URL/api/parent/all"));
    return Parent.fromJson(
        jsonDecode(Utf8Decoder().convert(response.bodyBytes)));
  }
}