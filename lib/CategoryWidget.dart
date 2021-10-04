import 'package:flutter/material.dart';
import 'package:kdeccourse/CourseDetail.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'AppColor.dart';

class CategoryWidget extends StatelessWidget {
  final String title;
  final List<String> dummy;

  const CategoryWidget({Key? key, required this.title, required this.dummy}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
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
          child: ListView.builder(itemBuilder: (context, index) =>  Column(
            children: [
              Expanded(

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 250,
                          height: 300,
                          child: ClipRRect(borderRadius: BorderRadius.circular(8),child: Hero(tag: "images/img_$index.png",child: GestureDetector(onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetail(courseName: dummy[index], image: "images/img_$index.png"),)),child: Image.asset("images/img_$index.png",fit: BoxFit.cover,)))),
                        ),
                      ),
                    ),
              Text(dummy[index])
            ],
          ),scrollDirection: Axis.horizontal,itemCount: 5,shrinkWrap: true,),
        ),
        Divider(thickness: 2,)
      ]),
    );
  }

}