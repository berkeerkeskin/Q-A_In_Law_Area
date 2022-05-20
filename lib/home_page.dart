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
  bool _bert = true;
  bool _fasttext = false;
  @override
  void initState() {
    super.initState();
  }

  getDataBert(String searchQuery) async{
    ictihats = await RemoteService().getIctihatBert(searchQuery);

    if(ictihats != null){
      setState(() {
        isLoaded = true;
      });
    }
  }

  getDataFasttext(String searchQuery) async {
    ictihats = (await RemoteService().getIctihatFasttext(searchQuery))!;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.yellow.shade400),
        backgroundColor: Colors.black.withOpacity(0.7),
        centerTitle: true,
        title: Text("İçtihat Arama Motoru", style: TextStyle(color: Colors.yellow.shade400, fontWeight: FontWeight.bold),),
      ),
      body: Container(
        color: Colors.white60,
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
                  if(_fasttext){
                    getDataFasttext(searchQuery);
                  }else if(_bert){
                    getDataBert(searchQuery);
                  }

                  print("onsubmit: " + searchQuery);
                },
              ),
              SwitchListTile(
                  dense: false,
                  title: Text("Fasttext Model"),
                  value: _fasttext,
                  onChanged: (bool value){
                setState(() {
                  if(value && _bert){
                    _fasttext = value;
                    _bert = false;
                  }else if(!value && !_bert){
                    _fasttext = false;
                    _bert = true;
                  }
                });
              }),
              SwitchListTile(
                  title: Text("Bert Model"),
                  value: _bert,
                  onChanged: (bool value){
                setState(() {
                  if(value && _fasttext){
                    _bert = value;
                    _fasttext = false;
                  }else if(!value && !_fasttext){
                    _bert = false;
                    _fasttext = true;
                  }
                });
              }),
              Visibility(
                visible: isLoaded,
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: ictihats?.length,
                    itemBuilder: (context, index){
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        margin: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.star, color: Colors.yellow.shade400,),
                                Text((index + 1).toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow.shade400),),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric( vertical: 5),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text(ictihats![index].ictihat.length > 250 ? "${ictihats![index].ictihat.substring(0, 250)}...": ictihats![index].ictihat,
                                style: TextStyle(fontWeight: FontWeight.w400, ),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow.shade400)
                              ),
                              onPressed: () async{
                                await showDialog(context: context, builder: (_) => Container(
                                  color: Colors.white,
                                  child: DataTable(
                                    columns: [
                                      DataColumn(
                                        label: Text(
                                          'Daire',
                                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Hüküm',
                                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Esas',
                                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Mahkeme',
                                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'İçtihat',
                                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                    rows: [
                                      DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text(ictihats![index].daire)),
                                          DataCell(Text(ictihats![index].hukum)),
                                          DataCell(Text(ictihats![index].esas)),
                                          DataCell(Text(ictihats![index].mahkeme)),
                                          DataCell(Text(ictihats![index].ictihat)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ) );

                              },
                              child: Text("içtihat...", style: TextStyle(color: Colors.black),),

                            ),
                          ]
                        ),
                      );
                    }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 4,
                ),),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
