class Dua {
  final int number;
  final String name;
  final String arabic;
  final String latin;
  final String translation;

  Dua({
    required this.number,
    required this.name,
    required this.arabic,
    required this.latin,
    required this.translation,
  });

  factory Dua.fromJson(Map<String, dynamic> json) => Dua(
        number: json["number"],
        name: json["name"],
        arabic: json["arabic"],
        latin: json["latin"],
        translation: json["translation"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
        "arabic": arabic,
        "latin": latin,
        "translation": translation,
      };
}
