import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kdeccourse/models/category_model.dart';

import 'app_colors.dart';
import 'backend_requests.dart';
import 'course_detail.dart';

class CategoryDetails extends StatelessWidget {
  final String title;

  const CategoryDetails({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,style: TextStyle(fontSize: 25),),
        centerTitle: true,
        toolbarHeight:50,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: AppColor.PRIMARY),
        backgroundColor: AppColor.PRIMARY,
        automaticallyImplyLeading: true,
      ),
      body:   FutureBuilder<List<Category>>(
        future: BackendQueries.getAllCategories(title),//BackendQueries.getAllParents(),
        builder: (context, snapshot) => snapshot.hasData && snapshot.connectionState == ConnectionState.done ?
        GridView.count(
          crossAxisCount: 2,
          children: List.generate(snapshot.data!.length, (index) {
            return Column(
              children: [
                GestureDetector(
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetail(category: snapshot.data![index],))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150,
                      height: 150,
                      child: ClipRRect(borderRadius: BorderRadius.circular(8),child: Hero(tag: "images/${snapshot.data![index].categoryName.trim()}.jpg",child: Image.asset("images/${snapshot.data![index].categoryName.trim()}.jpg",fit: BoxFit.fill,))),
                    ),
                  ),
                ),
                Text(snapshot.data![index].categoryName.trim())
              ],
            );
          }
    ) ) : CircularProgressIndicator(),
      ),
    );
  }

}