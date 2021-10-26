import 'dart:math';

import 'package:chewie/chewie.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kdeccourse/AppColor.dart';
import 'package:kdeccourse/BackendQueries.dart';
import 'package:kdeccourse/CategoryWidget.dart';
import 'package:kdeccourse/ProfileScreen.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_player/video_player.dart';

import 'models/Parent.dart';


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
     context.setLocale( Locale('ar', 'AR'));
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
        child:  SingleChildScrollView(
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

              Container(height:250,child: Chewie(controller: chewieController)),
              FutureBuilder<List<Parent>>(
                future: BackendQueries.getAllParents(),
                  builder: (context, snapshot) => snapshot.hasData && snapshot.connectionState == ConnectionState.done?
                  Center(
                    child: ListView.builder(itemCount: snapshot.data!.length,shrinkWrap:true,physics: const NeverScrollableScrollPhysics(),itemBuilder: (context, index) =>
                          CategoryWidget(title: snapshot.data![index].parentName)),
                  ): Center(child: CircularProgressIndicator(),),

              ),
            ]),
        ),

      ),
    );
  }
}
