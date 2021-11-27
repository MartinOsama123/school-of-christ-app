
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kdeccourse/app_colors.dart';
import 'package:kdeccourse/category_detail.dart';
import 'package:kdeccourse/firebase_auth_service.dart';
import 'package:kdeccourse/login_screen.dart';
import 'package:kdeccourse/profile_screen.dart';
import 'package:provider/provider.dart';

import 'models/user_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(FirebaseAuth.instance),
        ),
        ChangeNotifierProvider<UserModel>(
          create: (_) => UserModel(
              email: "", name: ""),
        ),
        StreamProvider(
          create: (context) =>
          context.read<FirebaseAuthService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        title: 'KDEC Courses',
        theme: ThemeData(
            primaryColor: AppColor.PRIMARY,
            accentColor: AppColor.SECONDARY,
            fontFamily: "EgyMotion"),
        home:LoginScreen(skip: true),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final imagesName = [
    "أجزاء مدرسة المسيح",
    "أساسيات الإيمان المسيحي",
    "أمثال ومُعجزات المسيح",
    "حياه الخادم",
    "أسئلة صعبة CONFLICT"
  ];
  @override
  Widget build(BuildContext context) {
    context.setLocale(Locale('ar', 'AR'));

    return Scaffold(
      body: CustomScrollView(slivers: [
       SliverPersistentHeader(delegate: CustomSliverAppBarDelegate(expandedHeight: 320),pinned: true,),

        SliverList(
        delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical:10 ,horizontal: 25),
            child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDetails(title: imagesName[index]))),
              child: Column(children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                        "images/${imagesName[index]}.jpg")),
                Text("${imagesName[index]}",style: TextStyle(fontSize: 20),),
              ]),
            ),
          );
        },childCount: imagesName.length
          ))
      ]),
    );
  }
}
class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  CustomSliverAppBarDelegate({required this.expandedHeight});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          buildBodyBar(shrinkOffset),
         // buildAppBar(shrinkOffset),
          Positioned(
            bottom: -20,
            left: 0,
            right: 0,
            child: floatingSearchBar(context, shrinkOffset)
          ),
        Positioned(
              top: 10,
              right: 10,
              child: SafeArea(child: floatingAvatar(context, shrinkOffset))
            ),


        ],),
    );
  }
  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;
  double disAppear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;
  //Widget buildAppBar(double shrinkOffset) => Opacity(opacity: appear(shrinkOffset),child: AppBar(title: Text("School of christ"),centerTitle: true,));
  Widget buildBodyBar(double shrinkOffset) => Opacity(opacity: disAppear(shrinkOffset),child: Image.asset("images/cover.jpg",fit: BoxFit.cover,));
  Widget floatingSearchBar(BuildContext context,double shrinkOffset) =>  Center(
    child: Opacity(
        opacity: disAppear(shrinkOffset),
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width - 40,
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
      ),
  );
  Widget floatingAvatar(BuildContext context,double shrinkOffset) => Opacity(
    opacity: disAppear(shrinkOffset),
    child: CircleAvatar(
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
  );
  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
  
  
}
