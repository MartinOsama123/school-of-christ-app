import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'AppColor.dart';

class CategoryWidget extends StatelessWidget {
  final String title;
  static List<String> dummy2 = [
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
  const CategoryWidget({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Column(children: [
         Row(
           children: [
             Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 24),),
              ),
           ],
         ),

        Expanded(
          child: ListView.builder(itemBuilder: (context, index) => Column(
              children: [
                Expanded(

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150,
                      height: 150,
                      child: ClipRRect(borderRadius: BorderRadius.circular(8),child: Hero(tag: "images/${dummy2[index].trim()}.jpg",child: Image.asset("images/${dummy2[index].trim()}.jpg",fit: BoxFit.fill,))),
                    ),
                  ),
                ),
               Text(dummy2[index].trim())
               /* Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: CircularPercentIndicator(
                    radius: 45,
                    percent: 6 / 100,
                    //   center: new Text(randomNumber.toString(),style: TextStyle(fontSize:10,color: Colors.black,fontWeight: FontWeight.bold),),
                    progressColor: AppColor.SECONDARY,
                  ),
                ),*/
              ],
            ),scrollDirection: Axis.horizontal,itemCount: dummy2.length,shrinkWrap: true,),
        ),
        Divider(thickness: 2,)
      ]),
    );
  }

}