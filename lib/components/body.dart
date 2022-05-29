import 'package:flutter/material.dart';
import 'package:q_a_in_law_area/home_page.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: size.width / 3),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
                "İÇTİHATLARDA ARAYIN!".toUpperCase(),
                style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold, fontSize: 40,),
            ),
            Text(
                "Bu projemizde, 200.000'den fazla içtihat verilerinde hukuk öğrencilerinin arama yapabileceği ve bu sayede istedikleri verilere daha kolay ulaşabilecekleri bir arama motoru geliştirdik.",
              style: TextStyle(
                color: Colors.white,
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
