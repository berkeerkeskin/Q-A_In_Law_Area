// To parse this JSON data, do
//
//     final ictihat = ictihatFromJson(jsonString);

import 'dart:convert';

List<Ictihat> ictihatFromJson(String str) => List<Ictihat>.from(json.decode(str).map((x) => Ictihat.fromJson(x)));

String ictihatToJson(List<Ictihat> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ictihat {
  Ictihat({
    required this.id,
    required this.rankInTSearch,
    required this.rank,
    required this.phraseExist,
    required this.numberOfWords,
    required this.length,
    required this.novel,
  });

  String id;
  String rankInTSearch;
  String rank;
  String phraseExist;
  String numberOfWords;
  String length;
  String novel;

  factory Ictihat.fromJson(Map<String, dynamic> json) => Ictihat(
    id: json["id"],
    rankInTSearch: json["rank_in_t_search"],
    rank: json["rank"],
    phraseExist: json["phrase_exist"],
    numberOfWords: json["number_of_words"],
    length: json["length"],
    novel: json["novel"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rank_in_t_search": rankInTSearch,
    "rank": rank,
    "phrase_exist": phraseExist,
    "number_of_words": numberOfWords,
    "length": length,
    "novel": novel,
  };
}