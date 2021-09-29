import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kdeccourse/AppColor.dart';

class CourseDetail extends StatelessWidget {
  final String courseName;
  final String image;
  static const List<String> dummy = [" ابعاد العلاقة مع الله", "طبيعة مدرسة المسيح","تابع طبيعة مدرسة المسيح","مبادئ التلمذة: المواظبة والإنتماء","مبادئ التلمذة: الإنضباط","مبادئ التلمذة: الوداعة"];
  const CourseDetail({Key? key, required this.courseName, required this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight:30,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: AppColor.PRIMARY),
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
                      width: 400,
                      height: 200,child: ClipRRect(borderRadius: BorderRadius.circular(8),child: Hero(tag:image,child: Image.asset(image,fit: BoxFit.cover,)))),
                  SizedBox(height: 10),
                  Text(courseName,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  SizedBox(height: 10),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: const Text("About the course",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600))),
                  SizedBox(height: 10),
                  const Text("في هذا البرنامج نعرض منهاج دراسي متكامل للتلمذة الروحية في الحياة المسيحية مع الله وهو عبارة عن مجموعة من الدراسات الاساسية المتسلسلة والمتدرجة التي تخاطب أرواحنا وأذهاننا"),
                  SizedBox(height: 10),
                  Row(children: [Icon(Icons.video_call,color: AppColor.SECONDARY,), Text("16 hours",)]),
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
                                title: Text(dummy[index]),
                                subtitle: Text("30:57 mins"),
                                trailing: Icon(Icons.play_circle_fill,color: AppColor.SECONDARY)),
                          ),
                      itemCount: dummy.length),
                ],
              ),
            ),
          ),
        ));
  }
}
