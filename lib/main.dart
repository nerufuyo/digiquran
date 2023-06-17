import 'package:digiquran/presentation/screen/asmaulhusna_page.dart';
import 'package:digiquran/presentation/screen/dua_page.dart';
import 'package:digiquran/presentation/screen/home_screen.dart';
import 'package:digiquran/presentation/screen/qibla_page.dart';
import 'package:digiquran/presentation/screen/quran_page.dart';
import 'package:digiquran/presentation/widget/navigation_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: NavigationWidget.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case NavigationWidget.routeName:
            return MaterialPageRoute(
                builder: (context) => const NavigationWidget());
          case HomeScreen.routeName:
            return MaterialPageRoute(builder: (context) => const HomeScreen());
          case QuranPage.routeName:
            return MaterialPageRoute(builder: (context) => const QuranPage());
          case DuaPage.routeName:
            return MaterialPageRoute(builder: (context) => const DuaPage());
          case AsmaulHusnaPage.routeName:
            return MaterialPageRoute(
                builder: (context) => const AsmaulHusnaPage());
          case QiblaPage.routeName:
            return MaterialPageRoute(builder: (context) => const QiblaPage());
          default:
            return MaterialPageRoute(
                builder: (context) => const NavigationWidget());
        }
      },
    );
  }
}