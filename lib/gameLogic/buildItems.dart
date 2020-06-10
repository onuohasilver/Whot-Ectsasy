import 'package:flutter/material.dart';
import 'package:whot/collection/cards.dart';
import 'package:whot/components/cardBuilder.dart';

import 'appProvider.dart';

Widget buildItem(
    BuildContext context,
    double height,
    double width,
    int index,
    List<CardDetail> currentPlayerCards,
    List<CardDetail> playedCards,
    Data appData,
    _listKey,
    List<CardDetail> deckOfCards,
    List<CardDetail> opponentPlayerCards,
    ScrollController scrollController,
    opponentListKey) {
  List<int> playable = appData.playableIndexes;
  CardDetail currentCard = appData.currentCard;

  return LongPressDraggable(
    hapticFeedbackOnStart: true,
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
    child: DragTarget(
      onWillAccept: (CardDetail cardDetail) {
        print(cardDetail.shape);
        if (cardDetail.shape == 'circle' || cardDetail.number == 3) {
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
                appData.specialCardCheck(context, height, width, true);
              });

              Future.delayed(
                Duration(seconds: 2),
                () async {
                  appData.checkOpponentsCards();
                  if (playable.isNotEmpty) {
                    appData.playCards(
                        context, height, width, appData, deckOfCards);
                    appData.specialCardCheck(context, height, width, false);
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

Widget buildItemOpponent(
    double height,
    double width,
    int index,
    List<CardDetail> opponentPlayerCards,
    List<CardDetail> playedCards,
    Data appData,
    opponentListKey,
    CardDetail currentCard,
    List<CardDetail> deckOfCards) {
  return CardBuilder(
    height: height,
    width: width,
    number: opponentPlayerCards[index].number,
    shape: opponentPlayerCards[index].shape,
    onTap: () {},
  );
}
