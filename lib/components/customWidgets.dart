import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key key,
    @required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15,
      color: Colors.transparent,
      shape: CircleBorder(),
      child: CircleAvatar(
          minRadius: width * .035,
          child: Icon(Icons.person),
          backgroundColor: Colors.blue[900].withOpacity(1)),
    );
  }
}
