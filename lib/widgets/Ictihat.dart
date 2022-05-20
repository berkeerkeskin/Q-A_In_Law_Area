import 'dart:convert';

List<Ictihat> ictihatFromJson(String str) => List<Ictihat>.from(json.decode(str).map((x) => Ictihat.fromJson(x)));

String ictihatToJson(List<Ictihat> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ictihat {
  Ictihat({
    required this.daire,
    required this.hukum,
    required this.esas,
    required this.mahkeme,
    required this.ictihat,
  });

  String daire;
  String hukum;
  String esas;
  String mahkeme;
  String ictihat;

  factory Ictihat.fromJson(Map<String, dynamic> json) => Ictihat(
    daire: json["daire"],
    hukum: json["hukum"],
    esas: json["esas"],
    mahkeme: json["mahkeme"],
    ictihat: json["ictihat"],
  );

  Map<String, dynamic> toJson() => {
    "daire": daire,
    "hukum": hukum,
    "esas": esas,
    "mahkeme": mahkeme,
    "ictihat": ictihat,
  };
}