import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'AppColor.dart';

class CategoryWidget extends StatelessWidget {
  final String title;

  const CategoryWidget({Key? key, required this.title}) : super(key: key);
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
          child: ListView.builder(itemBuilder: (context, index) => Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 250,
                    height: 300,
                    child: ClipRRect(borderRadius: BorderRadius.circular(8),child: Hero(tag: "images/img_$index.png",child: Image.asset("images/img_$index.png",fit: BoxFit.cover,))),
                  ),
                ),
                Positioned(
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
                ),
              ],
            ),scrollDirection: Axis.horizontal,itemCount: 5,shrinkWrap: true,),
        ),
        Divider(thickness: 2,)
      ]),
    );
  }

}