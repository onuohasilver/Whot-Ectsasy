import 'package:flutter/material.dart';
import 'package:whot/collection/cards.dart';
import 'cardBuilder.dart';


///display the parsed joker Content popUp
showJokerSelectionContent(
    BuildContext context, double height, double width, CardDetail currentCard) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: jokerSelectionContent(context, height, width, currentCard),
      );
    },
  );
}
/// A dialog Content pop-up triggered when the Whot 20
/// has been played. Reveals all the available shapes in a card deck
jokerSelectionContent(
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

/// return a selectable Card that changes the value of the
/// current card shape

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
