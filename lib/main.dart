import 'dart:math';

import 'package:chewie/chewie.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kdeccourse/AppColor.dart';
import 'package:kdeccourse/CategoryWidget.dart';
import 'package:kdeccourse/ProfileScreen.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_player/video_player.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('ar', 'AR')],
        path:
            'assets/translation', // <-- change the path of the translation files
        fallbackLocale: Locale('ar', 'AR'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      title: 'KDEC Courses',
      theme: ThemeData(
          primaryColor: AppColor.PRIMARY, accentColor: AppColor.SECONDARY),
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
  final videoPlayerController = VideoPlayerController.asset('assets/intro.mp4');


  List<String> dummy = [
    "التلمذه",
    "شخصية الله",
    "سلطان الله ومسئولية الإنسان",
    "الإنسان",
    "الروح القدس",
    "الإختبار المسيحي للنصرة"
  ];

  List<String> dummy2 = [
    " إختيار شريك الحياة",
    " العلاقات الإنسانية",
    " أنواع الصلاة",
    " شخصية الإنسان",
    " مبادئ العلاقات الإنسانية",
    "العلاقات الزوجية",
    " الإختبار المسيحي (لا انا بل المسيح)",
    "الإيمان",
    "التسبيح",
    "التلمذة",
    "الرجاء",
    "الروح القدس",
    "التلمذة",
    "الرجاء",
    "الشركة مع الله",
    "الشكر",
    "الصراع الروحي",
    "الطلب والتضرع",
    "الكنيسة (العلاقة مع الجسد)",
    "المأمورية العظمى ",
    "المحبة",
    "المشاركة",
    "تربية الأطفال",
    "دراسة الكلمة المقدسة",
    "سلطان الله ومسؤلية الإنسان",
    "شخصية الله ",
    "شخصية المسيح",
    "شفاء النفس",
    "مبادئ العلاقة مع الله",
    "مقدمة الخلوة الشخصية",
    "نقاء القلب"
  ];

  @override
  void initState() {
    initilizeVideo();
  }

  Future<void> initilizeVideo() async {
    await videoPlayerController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    // context.setLocale( Locale('ar', 'AR'));
    final chewieController = ChewieController(
      aspectRatio: 1,
      videoPlayerController: videoPlayerController,
      autoInitialize: true,
      autoPlay: true,
      allowMuting: true,
      allowFullScreen: false,
      showControls: false,
      looping: true,
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: AppColor.PRIMARY),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [

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
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              labelText: 'search'.tr(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileScreen())),
                                icon: Icon(
                                  Icons.person,
                                  color: AppColor.SECONDARY,
                                ))),
                        SizedBox(
                          width: 10,
                        ),
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
            Container(height:250,child: Chewie(controller: chewieController)),
            CategoryWidget(title: "اجزاء مدرسه المسيح"),
            CategoryWidget(title: "أساسيات الإيمان المسيحي"),
            CategoryWidget(title: "أمثال ومعجزات المسيح"),
            CategoryWidget(title: "أسئلة صعبة CONFLICT"),

            /*  GridView.builder(
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

                        Text(dummy[index]),
                        SizedBox(height: 5,),
                       */ /* Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: LinearPercentIndicator(
                            lineHeight:10,
                            percent: 0.100,
                            center: new Text("10%",style: TextStyle(fontSize:10),),
                            progressColor: Colors.red,
                          ),
                        ),*/ /*
                      ],
                    ),
                  );},
                  itemCount: dummy.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    childAspectRatio: (1 / 1.2)),
                ),
              ],*/
          ]),
        ),
      ),
    );
  }
}
