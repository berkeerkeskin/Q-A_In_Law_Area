import 'package:flutter/material.dart';
import 'package:q_a_in_law_area/home_page.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.yellow.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                "Search Judicial Data".toUpperCase(),
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40,),
            ),
            Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit,\nsed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi \nut aliquip ex ea commodo consequat.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            FittedBox(
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      color: Colors.yellow,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
                      },
                      child: Text("İçtihatlarda Ara", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),)
                  ),
                ),
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Color(0xFF372930),
                  borderRadius: BorderRadius.circular(34)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
