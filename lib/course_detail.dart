import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:kdeccourse/app_colors.dart';
import 'package:kdeccourse/backend_requests.dart';
import 'package:kdeccourse/episode_detail.dart';
import 'package:kdeccourse/models/category_model.dart';
import 'dart:math' as math;
import 'package:easy_localization/easy_localization.dart';
import 'package:kdeccourse/models/course_model.dart';
import 'package:kdeccourse/models/progress_model.dart';
import 'package:provider/src/provider.dart';

class CourseDetail extends StatelessWidget {
  final Category category;

  const CourseDetail({Key? key, required this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        final Email email = Email(
          body: 'School of Christ app',
          subject: 'Email subject',
          recipients: ["martinosama2015@gmail.com"],
         /* cc: ['cc@example.com'],
          bcc: ['bcc@example.com'],
          attachmentPaths: ['/path/to/attachment.zip'],*/
          isHTML: false,
        );

        await FlutterEmailSender.send(email);
      },child: Transform( alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),child: Icon(Icons.help,size: 50))),
        appBar: AppBar(
          title: Text(category.categoryName,style: TextStyle(fontSize: 25),),
          centerTitle: true,
          toolbarHeight:50,
          elevation: 0,
          backgroundColor: AppColor.PRIMARY,
          automaticallyImplyLeading: true,
        ),
        body: SafeArea(
          child: FutureBuilder<List<CourseInfo>>(
            future: BackendQueries.getAllCourses(category.categoryName),
            builder: (context, coursesData) =>  coursesData.hasData ? Padding(
              padding: const EdgeInsets.all(26.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 400,
                        height: 200,child: ClipRRect(borderRadius: BorderRadius.circular(8),child: Hero(tag:"${category.categoryName}.jpg",child: Image.asset("images/${category.categoryName}.jpg",fit: BoxFit.cover)))),
                    SizedBox(height: 10),

                    Text("about".tr(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                    SizedBox(height: 10),
                    Text(category.categoryDescription),
                    SizedBox(height: 10),
                    SizedBox(height: 10),

                      Text("curriculum".tr(),
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500)),
                    SizedBox(height: 10),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => FutureBuilder<ProgressModel>(
                          future: BackendQueries.getProgress(new ProgressModel.withoutProgress(context.read<User?>()?.email ?? "", coursesData.data![index].courseName)),
                          builder: (context, progress) =>  GestureDetector(
                            onTap: () async {
                              if(context.read<User?>() != null)
                              await BackendQueries.addProgress(ProgressModel(context.read<User?>()?.email ?? "", coursesData.data![index].courseName, progress.hasData ? progress.data!.progress + 1 : 1));
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EpisodeDetail(name: coursesData.data![index].courseName)));},
                            child: Card(
                                  elevation: 2,
                                  child: ListTile(
                                      title: Text(coursesData.data![index].courseName),
                                      trailing: Icon(Icons.play_circle_fill,color: AppColor.PRIMARY)),
                                ),
                          ),
                        ),
                        itemCount: coursesData.data!.length),
                  ],
                ),
              ),
            ) : Center(child: CircularProgressIndicator(),),
          ),
        ));
  }
}
