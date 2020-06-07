import 'package:flutter/material.dart';

class dialogBox extends StatelessWidget {
  const dialogBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:100,
      width:100,
      color:Colors.red,
      child: Text('Great'),
    );
  }
}