import 'dart:convert';
import 'dart:io';
import 'package:digiquran/data/model/surah_model.dart';
import 'package:http/http.dart' as http;

class Repository {
  final quranBaseUrl = 'https://apimuslimify.vercel.app/api/v2';

  Future<List<Surah>> getSurahList() async {
    final response = await http.get(Uri.parse('$quranBaseUrl/surah'));

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Surah> surahList = [];
        for (var item in data['data']) {
          surahList.add(Surah.fromJson(item));
        }
        return surahList;
      } else {
        throw Exception('Failed to load surah list');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<Surah> getSurahByNumber({required String surahNumber}) async {
    Map<String, String> parameter = {
      'number': surahNumber,
    };

    final response = await http.get(
      Uri.https('apimuslimify.vercel.app', '/api/v2/surah', parameter),
    );

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final surah = Surah.fromJson(data['data']);
        return surah;
      } else {
        throw Exception('Failed to load surah');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }
}
