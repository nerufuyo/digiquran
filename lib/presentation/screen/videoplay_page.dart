import 'package:digiquran/common/color.dart';
import 'package:digiquran/common/font.dart';
import 'package:digiquran/common/gap.dart';
import 'package:digiquran/data/repository/repostiory.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayPage extends StatefulWidget {
  const VideoPlayPage({super.key, required this.videoID});
  static const routeName = '/video_play_page';
  final String videoID;

  @override
  State<VideoPlayPage> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    print(widget.videoID);
    controller = YoutubePlayerController(
      initialVideoId: widget.videoID,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        captionLanguage: 'en',
        mute: false,
        useHybridComposition: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: YoutubePlayer(
                controller: controller,
                width: MediaQuery.of(context).size.width,
                aspectRatio: 16 / 9,
                showVideoProgressIndicator: true,
                progressIndicatorColor: tertiaryColor.withOpacity(.25),
                progressColors: const ProgressBarColors(
                  playedColor: Colors.red,
                  handleColor: Colors.red,
                ),
              ),
            ),
            FutureBuilder(
              future: Repository().getVideoById(id: widget.videoID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  final formattedDate = DateFormat('dd MMMM yyyy').format(
                      DateTime.parse(data!.snippet!.publishedAt.toString()));
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.snippet!.title.toString(),
                                style: firaSansH2,
                                textAlign: TextAlign.justify,
                              ),
                              const VerticalGap5(),
                              Text(
                                'Uploaded on $formattedDate',
                                style: firaSansS2,
                                textAlign: TextAlign.justify,
                              ),
                              const VerticalGap5(),
                              const Divider(thickness: 2),
                              const VerticalGap5(),
                              Text(
                                data.snippet!.description.toString(),
                                style: firaSansS2,
                              )
                            ],
                          ),
                          const VerticalGap20(),
                          const VerticalGap20(),
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                      'https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const HorizontalGap10(),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.snippet!.channelTitle.toString(),
                                      style: firaSansH4,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const VerticalGap5(),
                                    Text(
                                      '637k subscribers',
                                      style: firaSansS3.copyWith(
                                        color: tertiaryColor.withOpacity(.6),
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
