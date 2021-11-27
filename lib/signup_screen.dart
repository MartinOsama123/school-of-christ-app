
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:kdeccourse/backend_requests.dart';
import 'package:kdeccourse/firebase_auth_service.dart';
import 'package:kdeccourse/models/user_model.dart';
import 'package:kdeccourse/profile_screen.dart';
import 'package:provider/provider.dart';

import 'app_colors.dart';
import 'main.dart';
class SignupScreen extends StatefulWidget {



  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool emailValid = true, passValid = true, nameValid = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return context.watch<User?>() == null
        ? Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/app_background.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          appBar: AppBar(
            title:  Text(
              "signup",
              style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold),
            ).tr(),
            centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context))),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'name'.tr(),
                            errorText: !nameValid ? "Name must not be empty" : null
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'email'.tr(),
                            errorText: !emailValid ? "Email must be valid" : null
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'password'.tr(),
                            errorText: !passValid ? "Password must be at least 5 characters" : null
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width / 2,
                    child: ElevatedButton(
                      child: Text("signup").tr(),
                      style: ElevatedButton.styleFrom(
                          primary: AppColor.PRIMARY),
                      onPressed: () async {
                        if(_emailController.text.trim().contains("@") && _nameController.text.trim().isNotEmpty && _passwordController.text.length > 5) {
                          UserModel user = new UserModel(
                              email: _emailController.text.trim(),
                              name: _nameController.text.trim());
                          await context.read<FirebaseAuthService>().signUp(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim());
                          String token =
                              await context.read<User?>()?.getIdToken() ?? "";
                          var en = jsonEncode(user.toJson());
                          await BackendQueries.createUser(token, en);
                        }
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    ): MyHomePage();
  }
}
