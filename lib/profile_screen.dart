import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kdeccourse/app_colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProfileScreen extends StatelessWidget {
  List<String> dummy  = ["التلمذه","شخصية الله", "سلطان الله","الإنسان","الروح القدس","الإختبار المسيحي للنصرة"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back_ios),color: Colors.black,onPressed: ()=>Navigator.pop(context)),backgroundColor: Colors.transparent,elevation: 0,toolbarHeight: 30,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(alignment:Alignment.centerLeft,child: const Text("Enrolled Courses",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: dummy.length,
                itemBuilder: (context, index){
                  Random random = new Random();
                  int randomNumber = random.nextInt(11) * 10;
                  return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Row(children: [
                       Expanded(
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Container(height: 150,width: 120,child: Image.asset("images/img_$index.png",fit: BoxFit.cover,)),
                               Text("Progress: $randomNumber"),
                               Container(
                                 width: 90,
                                 child: LinearPercentIndicator(
                                   lineHeight:4,

                                   percent: randomNumber / 100,
                                   progressColor: AppColor.SECONDARY,
                                 ),
                               ),
                           ],
                         ),
                       ),
                      Expanded(
                        child: Align(alignment:Alignment.center,child: Text(dummy[index],style: TextStyle(fontSize: 18),)),
                      ),
                    ]),
                  ),
                );}
              )
            ],),
          ),
        ),
      ),
    );
  }

}