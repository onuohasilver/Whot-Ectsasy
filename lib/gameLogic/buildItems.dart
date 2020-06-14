import 'package:flutter/material.dart';
import 'package:whot/collection/cards.dart';
import 'package:whot/components/cardBuilder.dart';

import 'appProvider.dart';

/// builds the widget in a ListView
Widget buildCurrentPlayerCards(
    BuildContext context,
    double height,
    double width,
    int index,
    List<CardDetail> currentPlayerCards,
    List<CardDetail> playedCards,
    Data appData,
    List<CardDetail> deckOfCards,
    List<CardDetail> opponentPlayerCards,
    ScrollController scrollController,
    AnimationController animation) {
  List<int> playable = appData.playableIndexes;
  CardDetail currentCard = appData.currentCard;

  return LongPressDraggable(
    data: currentPlayerCards[index],
    feedback: SizedBox(
        height: height * .3,
        width: width * .1,
        child: CardBuilder(
            height: height,
            width: width,
            number: currentPlayerCards[index].number,
            shape: currentPlayerCards[index].shape)),
    childWhenDragging: Container(),
    onDragCompleted: () {
      //TODO: Add  a drag completed function.
    },
    child: DragTarget(
      onWillAccept: (CardDetail cardDetail) {
        print(cardDetail.shape);
        if (cardDetail.shape == deckOfCards.first.shape ||
            cardDetail.number == deckOfCards.first.number) {
          return true;
        } else {
          return false;
        }
      },
      onAccept: (CardDetail cardDetail) {
        appData.addCardToPlayer(deckOfCards, false);
        scrollController.jumpTo(0);
      },
      builder: (context, listOne, listTwo) {
        return CardBuilder(
          height: height,
          width: width,
          number: currentPlayerCards[index].number,
          shape: currentPlayerCards[index].shape,
          onTap: () async {
            if (currentCard.number == currentPlayerCards[index].number ||
                currentCard.shape == currentPlayerCards[index].shape) {
              appData.updateCurrentCard(currentPlayerCards[index]);
              print(
                  'PlayedCard:${currentPlayerCards[index].shape} ${currentPlayerCards[index].number}');
              appData.playSelectedCard(currentPlayerCards[index]);
              currentCard = currentPlayerCards[index];

              currentPlayerCards.removeAt(index);

              Future.delayed(Duration(seconds: 1), () {
                appData.specialCardCheck(context, height, width, true,
                    animation, opponentPlayerCards.length);
              });

              Future.delayed(
                Duration(seconds: 2),
                () async {
                  appData.checkOpponentsCards();
                  if (playable.isNotEmpty) {
                    appData.playCards(context, height, width, appData,
                        deckOfCards, animation);
                    appData.specialCardCheck(context, height, width, false,
                        animation, currentPlayerCards.length);
                  } else {
                    appData.addCardToPlayer(deckOfCards, true);
                  }
                },
              );
            }
          },
        );
      },
    ),
  );
}

Widget buildOpponentPlayerCards(
    double height,
    double width,
    int index,
    List<CardDetail> opponentPlayerCards,
    List<CardDetail> playedCards,
    Data appData,
    CardDetail currentCard,
    List<CardDetail> deckOfCards) {
  return DummyCard(
    height: height,
    width: width,
    number: opponentPlayerCards[index].number,
    shape: opponentPlayerCards[index].shape,
    onTap: () {},
  );
}
