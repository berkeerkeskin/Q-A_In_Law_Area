import 'package:flutter/material.dart';
import 'package:elastic_client/elastic_client.dart' as elastic;
import 'package:elastic_client/console_http_transport.dart';

class ElasticSearchDelegate extends SearchDelegate{

  @override
  List<Widget> buildActions(BuildContext context){
    return [
      IconButton(onPressed: () async {
      query = "";
      await searchElasticServer(query);
      }, icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget  buildLeading(BuildContext context){
    return IconButton(onPressed: (){
      close(context, null);
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context){
    return FutureBuilder(
        future: searchElasticServer(context),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(!snapshot.hasData)
            return Center(child: Text("Still searching"));

          return _displayIctihat(snapshot.data);
        },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context){
    return FutureBuilder(
        future: searchElasticServer(query),
        builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData)
          return Center(child: Text("Still searching"));

          return _displayIctihat(snapshot.data);
      },
    );
  }

  Widget _displayIctihat(List<Ictihat> IctihatList){
    return ListView.builder(
        itemCount: IctihatList.length,
        itemBuilder: (BuildContext ctxt, int index){
          return DisplaySearchResult(name: IctihatList[index].name, appearenceData: IctihatList[index].appearenceData, powers: IctihatList[index].powers)
        }
    );
  }

  Future searchElasticServer(searchQuery) async{
    final transport = ConsoleHttpTransport(Uri.parse("http url"));
    final client = elastic.Client(transport);
    List<Ictihat> IctihatList = List<Ictihat> ();

    final searchResult = await client.search();

    for(final iter in searchResult.hits){
      Map<dynamic, dynamic> currDoc = iter.doc;
      IctihatList.add(Ictihat(properties));

      await transport.close();

      if(searchResult.totalCount <= 0){
        return null;
      }else{
        return IctihatList;
      }
    }
  }
}
class DisplaySearchResult extends StatelessWidget {
  final String name;
  final String appearenceData;
  final powers;

  const DisplaySearchResult({required this.name, required this.appearenceData, required this.powers}) : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(name ?? "", style: TextStyle(color: Colors.black, fontSize: 20),),
        Text(appearenceData ?? "", style: TextStyle(color: Colors.black, fontSize: 20),),
        Text(powers.toString() ?? "", style: TextStyle(color: Colors.black, fontSize: 20),),
        Divider(color: Colors.black,),
        SizedBox(height: 20,)
      ],
    );
  }
}
