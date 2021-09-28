import 'package:flutter/material.dart';
import 'package:kdeccourse/CourseDetail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KDEC Courses',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(

                    children: <Widget>[

                      Container(height: MediaQuery.of(context).size.width/2.5,decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),color: Colors.blue),),
                      Positioned(
                        bottom: 20,
                        right: 30,
                        left:30,
                        child: Container(
                            child: TextField (

                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,

                                suffixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                labelText: 'Search',

                              ),
                            ),
                          ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: Align(alignment:Alignment.centerLeft,child: Text("Popular Courses",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),)),
                  ),
                   GridView.builder(shrinkWrap:true,physics: NeverScrollableScrollPhysics(),itemBuilder: (context, index) => Column(children: [
                          Container(width: 150,height: 150,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey,),),
                          Text("Course Name")
                        ],),itemCount: 10,scrollDirection: Axis.vertical, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),),

                ],
              ),
            ),
          ),

      ),
    );
  }
}
