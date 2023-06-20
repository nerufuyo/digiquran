class AsmaulHusna {
  final int number;
  final String latin;
  final String arabic;
  final String idTranslation;
  final String enTranslation;

  AsmaulHusna({
    required this.number,
    required this.latin,
    required this.arabic,
    required this.idTranslation,
    required this.enTranslation,
  });

  factory AsmaulHusna.fromJson(Map<String, dynamic> json) => AsmaulHusna(
        number: json["number"],
        latin: json["latin"],
        arabic: json["arabic"],
        idTranslation: json["id_translation"],
        enTranslation: json["en_translation"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "latin": latin,
        "arabic": arabic,
        "id_translation": idTranslation,
        "en_translation": enTranslation,
      };
}
