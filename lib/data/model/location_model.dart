class LocationModel {
  final String id;
  final String lokasi;

  LocationModel({
    required this.id,
    required this.lokasi,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        id: json["id"],
        lokasi: json["lokasi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lokasi": lokasi,
      };
}
