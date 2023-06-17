// ignore_for_file: avoid_print
import 'package:digiquran/common/color.dart';
import 'package:digiquran/common/font.dart';
import 'package:digiquran/common/gap.dart';
import 'package:digiquran/common/skeleton.dart';
import 'package:digiquran/common/static.dart';
import 'package:digiquran/data/controller/geolocator.dart';
import 'package:digiquran/presentation/widget/star_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  final String locale = 'en';
  String address = '';
  HijriCalendar hijriToday = HijriCalendar.now();
  late Stream<DateTime> clockStream;

  @override
  void initState() {
    getHijriDate();
    getLocation();
    getTime();
    loadDone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: primaryColor),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(color: primaryColor),
            child: Stack(
              children: [
                backSection(context),
                StarWidget(
                  top: 80,
                  right: MediaQuery.of(context).size.width / 11.5,
                  size: 10,
                ),
                StarWidget(
                  top: 180,
                  right: MediaQuery.of(context).size.width / 10,
                  size: 10,
                ),
                StarWidget(
                  top: 140,
                  right: MediaQuery.of(context).size.width / 4.5,
                  size: 12,
                ),
                StarWidget(
                  top: 40,
                  right: MediaQuery.of(context).size.width / 3.5,
                  size: 5,
                ),
                StarWidget(
                  top: 80,
                  right: MediaQuery.of(context).size.width / 2,
                  size: 16,
                ),
                StarWidget(
                  top: 120,
                  right: MediaQuery.of(context).size.width / 1.4,
                  size: 8,
                ),
                StarWidget(
                  top: 70,
                  right: MediaQuery.of(context).size.width / 1.15,
                  size: 4,
                ),
                StarWidget(
                  top: 160,
                  right: MediaQuery.of(context).size.width / 1.10,
                  size: 12,
                ),
                frontSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Positioned frontSection(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 2.525,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2,
        color: primaryColor,
        padding: const EdgeInsets.only(top: 4),
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
              bottom: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All Features',
                  style: firaSansH2,
                ),
                const VerticalGap5(),
                Skeleton(
                  isLoading: isLoading,
                  duration: const Duration(seconds: 2),
                  themeMode: ThemeMode.light,
                  shimmerGradient: LinearGradient(
                    colors: [
                      tertiaryColor.withOpacity(.25),
                      tertiaryColor.withOpacity(.5),
                      tertiaryColor.withOpacity(.25),
                    ],
                    begin: const Alignment(-1.0, -0.5),
                    end: const Alignment(1.0, 0.5),
                    stops: const [0.0, 0.5, 1.0],
                    tileMode: TileMode.repeated,
                  ),
                  skeleton: const GridSkeleton(),
                  child: SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 4,
                        mainAxisExtent: 80,
                      ),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: features.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (index == 0) {
                              Navigator.pushNamed(context, featuresNav[0]);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Coming Soon'),
                                ),
                              );
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Icon(
                                  featuresIcon[index],
                                  color: secondaryColor,
                                  size: 24,
                                ),
                              ),
                              const VerticalGap5(),
                              Text(
                                features[index],
                                style: firaSansS3.copyWith(
                                  color: tertiaryColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const VerticalGap15(),
                Text(
                  'News & Updates',
                  style: firaSansH2,
                ),
                const VerticalGap5(),
                // SizedBox(
                //   width: double.infinity,
                //   height: MediaQuery.of(context).size.height / 4,
                //   child: FutureBuilder(
                //     future: Repository().getVideosList(),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         return ListView.separated(
                //           scrollDirection: Axis.horizontal,
                //           separatorBuilder: (context, index) =>
                //               const HorizontalGap10(),
                //           itemCount: snapshot.data!.length,
                //           itemBuilder: (context, index) {
                //             final data = snapshot.data![index];
                //             return Text(data.nextPageToken.toString());
                //           },
                //         );
                //       } else if (snapshot.hasError) {
                //         return Center(
                //           child: Text(
                //             snapshot.error.toString(),
                //             style: firaSansS3.copyWith(
                //               color: tertiaryColor,
                //             ),
                //           ),
                //         );
                //       } else {
                //         return const Center(
                //           child: CircularProgressIndicator(),
                //         );
                //       }
                //     },
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container backSection(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2.5,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Skeleton(
            isLoading: isLoading,
            duration: const Duration(seconds: 2),
            themeMode: ThemeMode.light,
            shimmerGradient: LinearGradient(
              colors: [
                tertiaryColor.withOpacity(.25),
                tertiaryColor.withOpacity(.5),
                tertiaryColor.withOpacity(.25),
              ],
              begin: const Alignment(-1.0, -0.5),
              end: const Alignment(1.0, 0.5),
              stops: const [0.0, 0.5, 1.0],
              tileMode: TileMode.repeated,
            ),
            skeleton: const SmallSkeleton(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hijriToday.toFormat("dd MMMM yyyy"),
                      style: firaSansH2.copyWith(
                        color: secondaryColor,
                      ),
                    ),
                    Text(
                      address,
                      style: firaSansS2.copyWith(
                        color: secondaryColor,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Bootstrap.bell_fill,
                    color: secondaryColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Skeleton(
                  isLoading: isLoading,
                  duration: const Duration(seconds: 2),
                  themeMode: ThemeMode.light,
                  shimmerGradient: LinearGradient(
                    colors: [
                      tertiaryColor.withOpacity(.25),
                      tertiaryColor.withOpacity(.5),
                      tertiaryColor.withOpacity(.25),
                    ],
                    begin: const Alignment(-1.0, -0.5),
                    end: const Alignment(1.0, 0.5),
                    stops: const [0.0, 0.5, 1.0],
                    tileMode: TileMode.repeated,
                  ),
                  skeleton: const ClockSkeleton(),
                  child: StreamBuilder<DateTime>(
                    stream: clockStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          DateFormat('HH:mm').format(snapshot.data!),
                          style: firaSansH1.copyWith(
                            color: secondaryColor,
                            fontSize: 52,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          'Time Error',
                          style: firaSansH1.copyWith(
                            color: secondaryColor,
                            fontSize: 52,
                          ),
                        );
                      } else {
                        return Text(
                          '00:00',
                          style: firaSansH1.copyWith(
                            color: secondaryColor,
                            fontSize: 52,
                          ),
                        );
                      }
                    },
                  ),
                ),
                const VerticalGap5(),
                Skeleton(
                  isLoading: isLoading,
                  duration: const Duration(seconds: 2),
                  themeMode: ThemeMode.light,
                  shimmerGradient: LinearGradient(
                    colors: [
                      tertiaryColor.withOpacity(.25),
                      tertiaryColor.withOpacity(.5),
                      tertiaryColor.withOpacity(.25),
                    ],
                    begin: const Alignment(-1.0, -0.5),
                    end: const Alignment(1.0, 0.5),
                    stops: const [0.0, 0.5, 1.0],
                    tileMode: TileMode.repeated,
                  ),
                  skeleton: const TinySkeleton(),
                  child: Text(
                    '2 Hour remaining until Maghrib',
                    style: firaSansS2.copyWith(
                      color: secondaryColor,
                    ),
                  ),
                ),
                const VerticalGap15(),
                Skeleton(
                  isLoading: isLoading,
                  duration: const Duration(seconds: 2),
                  themeMode: ThemeMode.light,
                  shimmerGradient: LinearGradient(
                    colors: [
                      tertiaryColor.withOpacity(.25),
                      tertiaryColor.withOpacity(.5),
                      tertiaryColor.withOpacity(.25),
                    ],
                    begin: const Alignment(-1.0, -0.5),
                    end: const Alignment(1.0, 0.5),
                    stops: const [0.0, 0.5, 1.0],
                    tileMode: TileMode.repeated,
                  ),
                  skeleton: const GridSkeleton(),
                  child: SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 4,
                        mainAxisExtent: 96,
                      ),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: secondaryColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                sholatTime[index],
                                style: firaSansS2.copyWith(
                                  color: secondaryColor,
                                ),
                              ),
                              Icon(
                                sholatTimeIcon[index],
                                color: secondaryColor,
                              ),
                              Text(
                                'Subuh',
                                style: firaSansS2.copyWith(
                                  color: secondaryColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void loadDone() {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  void getHijriDate() {
    setState(() {
      hijriToday = HijriCalendar.now();
      HijriCalendar.setLocal(locale);
    });
  }

  void getLocation() async {
    double latitude = 0;
    double longitude = 0;
    try {
      Position position = await getCurrentLocation();
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });
      String address = await getAddress(latitude, longitude);
      setState(() {
        this.address = address;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void getTime() {
    clockStream =
        Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
  }
}
