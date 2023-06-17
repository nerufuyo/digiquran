import 'dart:convert';
import 'dart:io';
import 'package:digiquran/data/model/asmaulhusna_model.dart';
import 'package:digiquran/data/model/dua_model.dart';
import 'package:digiquran/data/model/reminder_model.dart';
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
  
  Future<List<Reminder>> getReminderList() async {
    final response = await http.get(Uri.parse('$quranBaseUrl/quotes'));

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Reminder> reminderList = [];
        for (var item in data['data']) {
          reminderList.add(Reminder.fromJson(item));
        }
        return reminderList;
      } else {
        throw Exception('Failed to load reminder list');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<List<Dua>> getDuaList() async {
    final response = await http.get(Uri.parse('$quranBaseUrl/doaharian'));

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Dua> duaList = [];
        for (var item in data['data']) {
          duaList.add(Dua.fromJson(item));
        }
        return duaList;
      } else {
        throw Exception('Failed to load dua list');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<List<AsmaulHusna>> getAsmaulHusnaList() async {
    final response = await http.get(Uri.parse('$quranBaseUrl/asmaulhusna'));

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<AsmaulHusna> asmaulHusnaList = [];
        for (var item in data['data']) {
          asmaulHusnaList.add(AsmaulHusna.fromJson(item));
        }
        return asmaulHusnaList;
      } else {
        throw Exception('Failed to load asmaul husna list');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }
}
