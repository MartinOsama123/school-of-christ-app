import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kdeccourse/app_colors.dart';
import 'package:kdeccourse/backend_requests.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:youtube_parser/youtube_parser.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'models/course_model.dart';

class EpisodeDetail extends StatelessWidget {
  final String name;

  const EpisodeDetail({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CourseInfo>(
        future: BackendQueries.getCourseInfo(name),
        builder: (context, snapshot) =>
        snapshot.connectionState == ConnectionState.done && snapshot.hasData
            ?  Scaffold(
          appBar: AppBar(title: Text(snapshot.data!.courseName),centerTitle: true,automaticallyImplyLeading: true,backgroundColor: AppColor.PRIMARY,),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Container(
                      height: 400,
                      child: YoutubePlayerIFrame(
                        controller: YoutubePlayerController(
                            initialVideoId:
                                getIdFromUrl(snapshot.data!.courseLink) ?? "",
                            params: YoutubePlayerParams(
                                mute: false,
                                showControls: true,
                                showFullscreenButton: true)),
                        aspectRatio: 16 / 9,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(snapshot.data!.courseDescription),
                    ),
                  Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("attachments".tr(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 24),),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              icon: FaIcon(FontAwesomeIcons.filePdf,color: AppColor.SECONDARY,),
                              onPressed: () {
                              }),
                          IconButton(
                              icon: FaIcon(FontAwesomeIcons.music,color: AppColor.SECONDARY,),
                              onPressed: () {

                              }),
                        ],
                      ),
                    ),Spacer()
                  ])
      ): Center(child: CircularProgressIndicator()),
    );
  }
}
