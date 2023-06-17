class Surah {
  final int? surahNumber;
  final String? arabic;
  final String? latin;
  final String? transliteration;
  final String? translation;
  final int? totalAyat;
  final String? location;
  final List<Ayat>? ayat;

  Surah({
    required this.surahNumber,
    required this.arabic,
    required this.latin,
    required this.transliteration,
    required this.translation,
    required this.totalAyat,
    required this.location,
    required this.ayat,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        surahNumber: json["surah_number"],
        arabic: json["arabic"],
        latin: json["latin"],
        transliteration: json["transliteration"],
        translation: json["translation"],
        totalAyat: json["total_ayat"],
        location: json["location"],
        ayat: json["ayat"] != null
            ? List<Ayat>.from(json["ayat"].map((x) => Ayat.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "surah_number": surahNumber,
        "arabic": arabic,
        "latin": latin,
        "transliteration": transliteration,
        "translation": translation,
        "total_ayat": totalAyat,
        "location": location,
        "ayat": List<dynamic>.from(ayat!.map((x) => x.toJson())),
      };
}

class Ayat {
  final int? surahNumber;
  final int? ayatNumber;
  final String? arabic;
  final String? kitabah;
  final String? latin;
  final String? translation;

  Ayat({
    required this.surahNumber,
    required this.ayatNumber,
    required this.arabic,
    required this.kitabah,
    required this.latin,
    required this.translation,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) => Ayat(
        surahNumber: json["surah_number"],
        ayatNumber: json["ayat_number"],
        arabic: json["arabic"],
        kitabah: json["kitabah"],
        latin: json["latin"],
        translation: json["translation"],
      );

  Map<String, dynamic> toJson() => {
        "surah_number": surahNumber,
        "ayat_number": ayatNumber,
        "arabic": arabic,
        "kitabah": kitabah,
        "latin": latin,
        "translation": translation,
      };
}
