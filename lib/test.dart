import 'package:flutter/cupertino.dart';

class Test extends StatelessWidget {
  final String s;
  const Test({Key? key, required this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(s);
  }
}
