import 'package:flutter/material.dart';
import 'package:kdeccourse/CourseDetail.dart';
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
                    Container(
                      height: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                          color: Colors.blue),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 30,
                      left: 30,
                      child: Container(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
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
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Popular Courses",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      )),
                ),
                GridView.builder(

                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetail())),
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
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey,
                                    ),
                                  ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                top: 0,
                                child: CircularPercentIndicator(
                                 radius: 45,
                                  percent: 0.100,
                                  center: new Text("10%",style: TextStyle(fontSize:10),),
                                  progressColor: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text("Course Name"),
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
                  ),
                  itemCount: 10,
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
