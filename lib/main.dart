import 'package:digiquran/presentation/screen/asmaulhusna_page.dart';
import 'package:digiquran/presentation/screen/dua_page.dart';
import 'package:digiquran/presentation/screen/home_page.dart';
import 'package:digiquran/presentation/screen/qibla_page.dart';
import 'package:digiquran/presentation/screen/quran_page.dart';
import 'package:digiquran/presentation/screen/splash_page.dart';
import 'package:digiquran/presentation/screen/video_page.dart';
import 'package:digiquran/presentation/screen/videoplay_page.dart';
import 'package:digiquran/presentation/widget/navigation_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digiquran',
      initialRoute: SplashPage.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case SplashPage.routeName:
            return MaterialPageRoute(builder: (context) => const SplashPage());
          case NavigationWidget.routeName:
            return MaterialPageRoute(
                builder: (context) => const NavigationWidget());
          case HomePage.routeName:
            return MaterialPageRoute(builder: (context) => const HomePage());
          case QuranPage.routeName:
            return MaterialPageRoute(builder: (context) => const QuranPage());
          case DuaPage.routeName:
            return MaterialPageRoute(builder: (context) => const DuaPage());
          case AsmaulHusnaPage.routeName:
            return MaterialPageRoute(
                builder: (context) => const AsmaulHusnaPage());
          case QiblaPage.routeName:
            return MaterialPageRoute(builder: (context) => const QiblaPage());
          case VideoPage.routeName:
            return MaterialPageRoute(builder: (context) => const VideoPage());
          case VideoPlayPage.routeName:
            String id = settings.arguments as String;
            return MaterialPageRoute(
                builder: (context) => VideoPlayPage(
                      videoID: id,
                    ));
          default:
            return MaterialPageRoute(
                builder: (context) => const NavigationWidget());
        }
      },
    );
  }
}
