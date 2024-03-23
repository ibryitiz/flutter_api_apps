class Kisiler {
  final int id;
  final String isim;
  final String durum;
  final String karakterTur;
  final String cinsiyet;
  final Map<String, dynamic> origin;
  final Map<String, dynamic> location;
  final String resim;
  final String url;
  final String created;

  Kisiler.fromMap(Map<String, dynamic> kisiMap)
      : id = kisiMap["id"],
        isim = kisiMap["name"],
        durum = kisiMap["status"],
        karakterTur = kisiMap["species"],
        cinsiyet = kisiMap["gender"],
        origin = (kisiMap["origin"] as Map<String, dynamic>?) ?? {},
        location = (kisiMap["location"] as Map<String, dynamic>?) ?? {},
        resim = kisiMap["image"],
        url = kisiMap["url"],
        created = kisiMap["created"];
        String get originName => origin["name"] ?? "";
        String get locationName => location["name"] ?? "";
}
