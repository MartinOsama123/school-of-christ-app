import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kdeccourse/AppColor.dart';
import 'package:kdeccourse/CourseDetail.dart';
import 'package:kdeccourse/ProfileScreen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KDEC Courses',
      theme: ThemeData(
        primaryColor: AppColor.PRIMARY,
        accentColor: AppColor.SECONDARY
      ),
      home: MyHomePage(title: 'Courses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> dummy  = ["التلمذه","شخصية الله", "سلطان الله ومسئولية الإنسان","الإنسان","الروح القدس","الإختبار المسيحي للنصرة"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: AppColor.PRIMARY),
        ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.width / 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                          color: AppColor.PRIMARY),
                    ),
                    Positioned(
                      bottom: 20,

                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: Row(

                          children: [
                            SizedBox(width: 10,),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  suffixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  labelText: 'Search',
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            CircleAvatar(backgroundColor:Colors.white,child: IconButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen())), icon: Icon(Icons.person,color: AppColor.SECONDARY,))),
                            SizedBox(width: 10,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
            /*    Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Popular Courses",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      )),
                ),*/
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    Random random = new Random();
                    int randomNumber = random.nextInt(11) * 10;
                    return GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetail(courseName: dummy[index],image: "images/img_$index.png"))),
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                    width: 300,
                                    height: 500,
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
                                  percent: randomNumber / 100,
                               //   center: new Text(randomNumber.toString(),style: TextStyle(fontSize:10,color: Colors.black,fontWeight: FontWeight.bold),),
                                  progressColor: AppColor.SECONDARY,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(dummy[index]),
                        SizedBox(height: 5,),
                       /* Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: LinearPercentIndicator(
                            lineHeight:10,
                            percent: 0.100,
                            center: new Text("10%",style: TextStyle(fontSize:10),),
                            progressColor: Colors.red,
                          ),
                        ),*/
                      ],
                    ),
                  );},
                  itemCount: dummy.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    childAspectRatio: (1 / 1.2)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
