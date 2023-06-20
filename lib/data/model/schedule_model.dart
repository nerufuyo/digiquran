class Schedule {
  final String? id;
  final String? lokasi;
  final String? daerah;
  final Jadwal? jadwal;

  Schedule({
    required this.id,
    required this.lokasi,
    required this.daerah,
    required this.jadwal,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        lokasi: json["lokasi"],
        daerah: json["daerah"],
        jadwal: json["jadwal"] == null ? null : Jadwal.fromJson(json["jadwal"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lokasi": lokasi,
        "daerah": daerah,
        "jadwal": jadwal!.toJson(),
      };
}

class Jadwal {
  final String? tanggal;
  final String? imsak;
  final String? subuh;
  final String? terbit;
  final String? dhuha;
  final String? dzuhur;
  final String? ashar;
  final String? maghrib;
  final String? isya;

  Jadwal({
    required this.tanggal,
    required this.imsak,
    required this.subuh,
    required this.terbit,
    required this.dhuha,
    required this.dzuhur,
    required this.ashar,
    required this.maghrib,
    required this.isya,
  });

  factory Jadwal.fromJson(Map<String, dynamic> json) => Jadwal(
        tanggal: json["tanggal"],
        imsak: json["imsak"],
        subuh: json["subuh"],
        terbit: json["terbit"],
        dhuha: json["dhuha"],
        dzuhur: json["dzuhur"],
        ashar: json["ashar"],
        maghrib: json["maghrib"],
        isya: json["isya"],
      );

  Map<String, dynamic> toJson() => {
        "tanggal": tanggal,
        "imsak": imsak,
        "subuh": subuh,
        "terbit": terbit,
        "dhuha": dhuha,
        "dzuhur": dzuhur,
        "ashar": ashar,
        "maghrib": maghrib,
        "isya": isya,
      };
}
