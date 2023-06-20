import 'package:digiquran/presentation/screen/asmaulhusna_page.dart';
import 'package:digiquran/presentation/screen/dua_page.dart';
import 'package:digiquran/presentation/screen/qibla_page.dart';
import 'package:digiquran/presentation/screen/quran_page.dart';
import 'package:icons_plus/icons_plus.dart';

const channelId = 'UUZHbLWGrq43F0-5Ef37CpWQ';
const apiKey = 'AIzaSyDDBvG8MdM0pEzMGEYsJeevnYwY1iQS_AA';

final List sholatTime = ['Shubuh', 'Dzuhr', 'Asr', 'Maghrib', 'Isha'];
final List sholatTimeIcon = [
  Bootstrap.sunrise_fill,
  Bootstrap.sun_fill,
  Bootstrap.sunset_fill,
  Bootstrap.moon_fill,
  Bootstrap.moon_stars_fill,
];
final List features = [
  'Al-Qur\'an',
  'Asmaul Husna',
  'Qibla',
  'Hadits',
  'Du\'a'
];
final List featuresIcon = [
  Bootstrap.book_fill,
  Bootstrap.alexa,
  Bootstrap.compass_fill,
  Bootstrap.bookmark_star_fill,
  Bootstrap.activity,
];
final List featuresNav = [
  QuranPage.routeName,
  AsmaulHusnaPage.routeName,
  QiblaPage.routeName,
  QuranPage.routeName,
  DuaPage.routeName,
];
