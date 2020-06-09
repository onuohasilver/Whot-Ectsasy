import 'package:flutter/material.dart';
import 'cardBuilder.dart';

showCardDialog(context, height, width) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: dialogContentJoker(context, height, width),
      );
    },
  );
}

dialogContentJoker(BuildContext context, height, width) {
  return Material(
    elevation: 150,
    color: Colors.transparent,
    child: Container(
      height: height * .5,
      width: width * .7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.brown[200],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Choose Shape:'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              showCard(height, width, 'circle'),
              showCard(height, width, 'square'),
              showCard(height, width, 'cross'),
              showCard(height, width, 'triangle'),
              showCard(height, width, 'star'),
            ],
          ),
        ],
      ),
    ),
  );
}

Padding showCard(double height, double width, String shape) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: height * .3,
      width: width * .1,
      child: CardBuilder(
        onTap: () {},
        shape: shape,
        number: 0,
        width: width * 1.3,
        height: height,
      ),
    ),
  );
}
