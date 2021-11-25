
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kdeccourse/app_colors.dart';
import 'package:kdeccourse/category_detail.dart';
import 'package:kdeccourse/profile_screen.dart';

import 'models/parent_model.dart';

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
          primaryColor: AppColor.PRIMARY,
          accentColor: AppColor.SECONDARY,
          fontFamily: "EgyMotion"),
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
  final imagesName = [
    "أجزاء مدرسة المسيح",
    "أسئلة صعبة CONFLICT",
    "أساسيات الإيمان المسيحي",
    "أمثال ومُعجزات المسيح",
    "حياه الخادم"
  ];
  @override
  Widget build(BuildContext context) {
    context.setLocale(Locale('ar', 'AR'));

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Column(children: [
                Stack(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.asset(
                          "images/cover.jpg",
                          fit: BoxFit.cover,
                        )),
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
                                            builder: (context) =>
                                                ProfileScreen())),
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


                /*  Padding(
                padding: const EdgeInsets.all(8.0),
                child:  ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.asset("images/cover.jpg",fit: BoxFit.cover,)),
              ),*/
                /*  FutureBuilder<List<Parent>>(
                future: BackendQueries.getAllParents(),
                  builder: (context, snapshot) => snapshot.hasData && snapshot.connectionState == ConnectionState.done?
                  Center(
                    child: ListView.builder(itemCount: snapshot.data!.length,shrinkWrap:true,physics: const NeverScrollableScrollPhysics(),itemBuilder: (context, index) =>
                          CategoryWidget(title: snapshot.data![index].parentName)),
                  ): Center(child: CircularProgressIndicator(),),*/

                // ),
              ]);
            },
            childCount: 1,
          ),
        ),
        SliverList(
        delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDetails(title: imagesName[index]))),
              child: Column(children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                        "images/${imagesName[index]}.jpg")),
                Text("${imagesName[index]}"),
              ]),
            ),
          );
        },childCount: imagesName.length
          ))
      ]),
    );
  }
}
