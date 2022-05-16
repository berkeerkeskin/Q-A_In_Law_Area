import 'package:q_a_in_law_area/widgets/Ictihat.dart';
import 'package:http/http.dart' as http;

class RemoteService {

  Future<List<Ictihat>?> getIctihat(String searchQuery) async {
    print("get: " + searchQuery);
    var client = http.Client();
    String url = "http://localhost:8000/general-search/" + searchQuery;
    var uri = Uri.parse(url);
    var response = await client.get(uri);

    if(response.statusCode == 200){
      var json = response.body;
      return ictihatFromJson(json);
    }
  }

  Future<String?> getIDLink(String ictihatID) async {
    var client = http.Client();
    String url = "http://localhost:8000/get-by-id/" + ictihatID;
    var uri = Uri.parse(url);
    var response = await client.get(uri);

    if(response.statusCode == 200){
      var string = response.body;
      return string;
    }
  }

}