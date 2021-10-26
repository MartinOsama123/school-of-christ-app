import 'package:flutter/material.dart';
import 'package:kdeccourse/BackendQueries.dart';
import 'package:kdeccourse/CourseDetail.dart';
import 'package:kdeccourse/models/Category.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'AppColor.dart';

class CategoryWidget extends StatelessWidget {
  final String title;
  const CategoryWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: BackendQueries.getAllCategories(title),
      builder: (context, snapshot) => snapshot.hasData && snapshot.data!.isNotEmpty && snapshot.connectionState == ConnectionState.done ? Container(
        height: 250,
        child: Column(children: [
           Row(
             children: [
               Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 24),),
                ),
             ],
           ),
          Expanded(
            child: ListView.builder(itemBuilder: (context, index) => Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
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
                    ),
                   Text(snapshot.data![index].categoryName.trim())
                   /* Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: CircularPercentIndicator(
                        radius: 45,
                        percent: 6 / 100,
                        //   center: new Text(randomNumber.toString(),style: TextStyle(fontSize:10,color: Colors.black,fontWeight: FontWeight.bold),),
                        progressColor: AppColor.SECONDARY,
                      ),
                    ),*/
                  ],
                ),scrollDirection: Axis.horizontal,itemCount: snapshot.data!.length,shrinkWrap: true,),


          )]),
      ): Container(),
    );
  }

}