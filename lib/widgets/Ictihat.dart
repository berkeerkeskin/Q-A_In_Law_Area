import 'dart:convert';

List<Ictihat> ictihatFromJson(String str) => List<Ictihat>.from(json.decode(str).map((x) => Ictihat.fromJson(x)));

String ictihatToJson(List<Ictihat> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ictihat {
Ictihat({
required this.id,
required this.rank,
required this.ictihat,
});

String id;
String rank;
String ictihat;

factory Ictihat.fromJson(Map<String, dynamic> json) => Ictihat(
id: json["id"],
rank: json["rank"],
ictihat: json["ictihat"],
);

Map<String, dynamic> toJson() => {
"id": id,
"rank": rank,
"ictihat": ictihat,
};
}
