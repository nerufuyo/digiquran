import 'dart:convert';
import 'dart:io';
import 'package:digiquran/common/static.dart';
import 'package:digiquran/data/model/asmaulhusna_model.dart';
import 'package:digiquran/data/model/dua_model.dart';
import 'package:digiquran/data/model/location_model.dart';
import 'package:digiquran/data/model/reminder_model.dart';
import 'package:digiquran/data/model/schedule_model.dart';
import 'package:digiquran/data/model/surah_model.dart';
import 'package:digiquran/data/model/video_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Repository {
  final quranBaseUrl = 'https://apimuslimify.vercel.app/api/v2';
  final shalahBaseUrl = 'https://api.myquran.com/v1';
  final videoBaseUrl = 'www.googleapis.com';
 
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

  Future<List<LocationModel>> postLocationList({required String city}) async {
    final response =
        await http.get(Uri.parse('$shalahBaseUrl/sholat/kota/cari/$city'));

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<LocationModel> locationList = [];
        for (var item in data['data']) {
          locationList.add(LocationModel.fromJson(item));
        }
        return locationList;
      } else {
        throw Exception('Failed to load location list');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Schedule> getScheduleByCity({
    required String id,
    required int year,
    required int month,
    required int day,
  }) async {
    final response = await http
        .get(Uri.parse('$shalahBaseUrl/sholat/jadwal/$id/$year/$month/$day'));
    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final schedule = Schedule.fromJson(data['data']);
        return schedule;
      } else {
        throw Exception('Failed to load schedule');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<List<VideoList>> getVideoList() async {
    Map<String, String> parameter = {
      'part': 'snippet',
      'playlistId': channelId,
      'maxResults': '50',
      'key': apiKey,
    };
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    Uri uri = Uri.https(videoBaseUrl, '/youtube/v3/playlistItems', parameter);

    try {
      Response response = await get(uri, headers: header);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> itemList = data['items'];
        final List<VideoList> videoList =
            itemList.map((item) => VideoList.fromJson(item)).toList();
        return videoList;
      } else {
        throw Exception('Failed to load video list');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<VideoList> getVideoById({required String id}) async {
    Map<String, String> parameter = {
      'part': 'snippet',
      'id': id,
      'key': apiKey,
    };
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    Uri uri = Uri.https(videoBaseUrl, '/youtube/v3/videos', parameter);

    try {
      Response response = await get(uri, headers: header);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> itemList = data['items'];
        final video = VideoList.fromJson(itemList[0]);
        return video;
      } else {
        throw Exception('Failed to load video');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

}
