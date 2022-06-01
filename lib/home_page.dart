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
  String dropdownvalue = 'Bert';

  var items = [
    'Bert',
    'Fasttext'
  ];
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
    if(ictihats != null){
      setState(() {
        isLoaded = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  setState(() {
                    print(dropdownvalue);
                    if(dropdownvalue.compareTo("Bert") == 0){
                      getDataBert(searchQuery);
                    }else{
                      getDataFasttext(searchQuery);
                    }
                    print("onsubmit: " + searchQuery);
                  });
                },
              ),
              DropdownButton(
                value: dropdownvalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                }
              ),
              Visibility(
                visible: isLoaded,
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: ictihats?.length,
                    itemBuilder: (context, index){
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
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
                              height: 100,
                              margin: EdgeInsets.symmetric( vertical: 5),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text(ictihats![index].ictihat.length > 100 ? "${ictihats![index].ictihat.substring(0, 100)}..." : ictihats![index].ictihat,
                                style: TextStyle(fontWeight: FontWeight.w400, ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow.shade400)
                              ),
                              onPressed: () async{
                                await showDialog(context: context, builder: (_) => Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xff4B4B4B),
                                  ),
                                  width: size.width,
                                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                  alignment: Alignment.topLeft,

                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Wrap(
                                          children: [
                                            Text("İçtihat:", style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, color: Colors.yellow.shade400, height: 1.5 ),),
                                            Divider(color: Colors.yellow.shade400,),
                                            SelectableText(ictihats![index].ictihat, style: TextStyle(color: Colors.white, height: 1.4),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ) );

                              },
                              child: Text("İÇTİHAT İÇİN TIKLA", style: TextStyle(color: Colors.black),),

                            ),
                            SizedBox(height: 30,)
                          ]
                        ),
                      );
                    }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 0,
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
