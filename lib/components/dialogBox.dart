import 'package:flutter/material.dart';
import 'package:whot/collection/cards.dart';
import 'cardBuilder.dart';

showCardDialog(
    BuildContext context, double height, double width, CardDetail currentCard) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: dialogContentJoker(context, height, width, currentCard),
      );
    },
  );
}

dialogContentJoker(
    BuildContext context, double height, double width, CardDetail currentCard) {
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
              showCard(context, height, width, 'circle', currentCard),
              showCard(context, height, width, 'square', currentCard),
              showCard(context, height, width, 'cross', currentCard),
              showCard(context, height, width, 'triangle', currentCard),
              showCard(context, height, width, 'star', currentCard),
            ],
          ),
        ],
      ),
    ),
  );
}

Padding showCard(BuildContext context, double height, double width,
    String shape, CardDetail currentCard) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: height * .3,
      width: width * .1,
      child: CardBuilder(
        onTap: () {
          currentCard.shape = shape;
          currentCard.number = 20;
          Navigator.pop(context);
        },
        shape: shape,
        number: 0,
        width: width * 1.3,
        height: height,
      ),
    ),
  );
}
