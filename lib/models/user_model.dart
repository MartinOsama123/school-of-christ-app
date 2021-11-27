import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  late String email;
  late String name;



  UserModel({required this.email, required this.name});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;

    return data;
  }
  void setUser(UserModel model){
    email = model.email;
    name = model.name;

    notifyListeners();
  }


}