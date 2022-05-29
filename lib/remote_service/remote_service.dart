import 'package:q_a_in_law_area/widgets/Ictihat.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RemoteService {

  Future<List<Ictihat>?> getIctihatBert(String searchQuery) async {
    print("get: " + searchQuery);
    var client = http.Client();
    String url = "http://localhost:8000/ictihat/knn-bert-search/" + searchQuery;
    var uri = Uri.parse(url);
    var response = await client.get(uri);

    if(response.statusCode == 200){
      var json = response.body;
      return ictihatFromJson(utf8.decode(response.bodyBytes));
    }
  }

  Future<List<Ictihat>?> getIctihatFasttext(String searchQuery) async {
    print("get: " + searchQuery);
    var client = http.Client();
    String url = "http://localhost:8000/ictihat/knn-ft-search/" + searchQuery;
    var uri = Uri.parse(url);
    var response = await client.get(uri);

    if(response.statusCode == 200){
      var json = response.body;
      return ictihatFromJson(utf8.decode(response.bodyBytes));
    }
  }

}