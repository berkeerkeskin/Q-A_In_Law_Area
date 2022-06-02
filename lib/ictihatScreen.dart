import 'package:flutter/material.dart';

class IctihatScreen extends StatelessWidget {
  final String ictihat;
  const IctihatScreen({Key? key, required this.ictihat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10),
      color: Color(0xff4B4B4B),
      width: size.width,
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DefaultTextStyle(child: Text("İçtihat:"), style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, color: Colors.yellow.shade400, height: 1.5, fontSize: 15 ),),
            Divider(color: Colors.yellow.shade400,),
            DefaultTextStyle(style: TextStyle(color: Colors.white, fontSize: 15), child: SelectableText(ictihat))
          ],
        ),
      ),
    );
  }
}
