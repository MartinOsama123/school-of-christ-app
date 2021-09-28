import 'package:flutter/material.dart';

class CourseDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context)),
          automaticallyImplyLeading: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey)),
                  SizedBox(height: 10),
                  Text("Course Name",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  SizedBox(height: 10),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: const Text("About the course",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600))),
                  SizedBox(height: 10),
                  const Text(
                      "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla "),
                  SizedBox(height: 10),
                  Row(children: [Icon(Icons.video_call), Text("16 hours")]),
                  SizedBox(height: 10),
                  /* Row(children: [Icon(Icons.video_call), Text("16 hours")]),
              Row(children: [Icon(Icons.video_call), Text("16 hours")]),*/
                  Align(
                      alignment: Alignment.centerLeft,
                      child: const Text("Curriculum",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w600))),
                  SizedBox(height: 10),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Card(
                            elevation: 2,
                            child: ListTile(
                                title: Text("Introduction"),
                                subtitle: Text("02:07 mins"),
                                trailing: Icon(Icons.play_circle_fill)),
                          ),
                      itemCount: 10),
                ],
              ),
            ),
          ),
        ));
  }
}
