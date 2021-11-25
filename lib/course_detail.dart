import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kdeccourse/app_colors.dart';
import 'package:kdeccourse/backend_requests.dart';
import 'package:kdeccourse/episode_detail.dart';
import 'package:kdeccourse/models/category_model.dart';
import 'dart:math' as math;
import 'package:easy_localization/easy_localization.dart';
import 'package:kdeccourse/models/course_model.dart';

class CourseDetail extends StatelessWidget {
  final Category category;

  const CourseDetail({Key? key, required this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Transform( alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),child: Icon(Icons.help,size: 50))),
        appBar: AppBar(
          title: Text(category.categoryName,style: TextStyle(fontSize: 25),),
          centerTitle: true,
          toolbarHeight:50,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: AppColor.PRIMARY),
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
                    /*Center(child: Text(category.categoryName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800))),
                    SizedBox(height: 10),
                    */ Text("about".tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    Text(category.categoryDescription),
                    SizedBox(height: 10),
                    // Row(children: [Icon(Icons.video_call,color: AppColor.SECONDARY,), Text("16 hours",)]),
                    SizedBox(height: 10),
                    /* Row(children: [Icon(Icons.video_call), Text("16 hours")]),
                Row(children: [Icon(Icons.video_call), Text("16 hours")]),*/
                      Text("curriculum".tr(),
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => EpisodeDetail(name: coursesData.data![index].courseName))),
                          child: Card(
                                elevation: 2,
                                child: ListTile(
                                    title: Text(coursesData.data![index].courseName),
                                    trailing: Icon(Icons.play_circle_fill,color: AppColor.SECONDARY)),
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
