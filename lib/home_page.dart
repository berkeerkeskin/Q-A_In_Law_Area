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
  late String link;
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
    link = (await RemoteService().getIDLink(id))!;
    return link;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("İçtihat Arama Motoru", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoSearchTextField(
                placeholderStyle: TextStyle(color: Colors.black),
                placeholder: "Bir sorgu giriniz...",
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.6),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10)
                ),
                onSubmitted: (searchQuery){
                  getData(searchQuery);
                  print("onsubmit: " + searchQuery);
                },
              ),
              SizedBox(height: 20,),
              Visibility(
                visible: isLoaded,
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: ictihats?.length,
                    itemBuilder: (context, index){
                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        margin: EdgeInsets.all(60),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star),
                                Text((index + 1).toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Text("id: " + ictihats![index].id, style: TextStyle(fontWeight: FontWeight.bold),),
                            ElevatedButton(
                              onPressed: () async{
                                String a = (await RemoteService().getIDLink(ictihats![index].id))!;
                                await showDialog(context: context, builder: (_) => AlertDialog(
                                  title: Text(a),
                                ) );

                              },
                              child: Text("içtihat..."),
                            ),
                          ]
                        ),
                      );
                    }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 3,
                ),),
                replacement: CircularProgressIndicator(),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
