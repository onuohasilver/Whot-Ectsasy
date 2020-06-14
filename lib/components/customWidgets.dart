import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key key,
    @required this.width, this.onTap,
  }) : super(key: key);

  final double width;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15,
      color: Colors.transparent,
      shape: CircleBorder(),
      child: Material(
        child: InkWell(
          onTap:onTap,
          child: CircleAvatar(
              minRadius: width * .035,
              child: Icon(Icons.person),
              backgroundColor: Colors.blue[900].withOpacity(1)),
        ),
      ),
    );
  }
}
