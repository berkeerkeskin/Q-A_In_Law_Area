import 'package:flutter/material.dart';
import 'package:q_a_in_law_area/home_screen.dart';

import '../home_page.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(46),
        boxShadow: [
          BoxShadow(
            offset: Offset(0,-2),
            blurRadius: 30,
            color: Colors.black.withOpacity(0.16),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          AppBarItem(title: "GİrİŞ", press: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()),);
          }),
          AppBarItem(title: "ÜRÜN HAKKINDA", press: (){}),
          ClipRRect(
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
        ],
      ),
    );
  }
}


class AppBarItem extends StatelessWidget {
  final String title;
  final Function press;
  const AppBarItem({Key? key, required this.title, required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){this.press;},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          this.title.toUpperCase(),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
