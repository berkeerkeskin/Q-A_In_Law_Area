import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_a_in_law_area/remote_service/remote_service.dart';
import 'package:q_a_in_law_area/widgets/Ictihat.dart';
import 'package:url_launcher/link.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Ictihat>? ictihats;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  getData(String searchQuery) async{
    ictihats = await RemoteService().getIctihat(searchQuery);

    // get ictihatID link from here
    //TO DO:

    if(ictihats != null){
      setState(() {
        isLoaded = true;
      });
    }
  }

  getLink(String id) async {
    String? link = await RemoteService().getIDLink(id);
    return link;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ictihat Search"),
      ),
      body: Column(
        children: [
          CupertinoSearchTextField(
            onSubmitted: (searchQuery){
              getData(searchQuery);
              print("onsubmit: " + searchQuery);
            },
          ),
          SizedBox(height: 50,),
          Visibility(
            visible: isLoaded,
            child: SingleChildScrollView(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: ictihats?.length,
                  itemBuilder: (context, index){
                    String link = getLink(ictihats![index].id);
                    print("link is here!");
                    return Container(
                      child: Text(ictihats![index].id),
                    );
                  }),
            ),
            replacement: CircularProgressIndicator(),
          ),
        ]
      ),
    );
  }
}
