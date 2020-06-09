import 'package:flutter/material.dart';
import 'package:whot/collection/cards.dart';
import 'package:whot/components/cardBuilder.dart';
import 'package:whot/components/dialogBox.dart';

import 'appProvider.dart';

Widget buildItem(
    BuildContext context,
    Animation<double> animation,
    double height,
    double width,
    int index,
    AnimationController animationController,
    List<CardDetail> currentPlayerCards,
    List<CardDetail> playedCards,
    Data appData,
    _listKey,
    List<CardDetail> deckOfCards,
    List<CardDetail> opponentPlayerCards,
    opponentListKey) {
  List<int> playable = appData.playableIndexes;
  CardDetail currentCard = appData.currentCard;

  return ScaleTransition(
    scale: animation,
    child: LongPressDraggable(
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
      child: CardBuilder(
        height: height,
        width: width,
        number: currentPlayerCards[index].number,
        shape: currentPlayerCards[index].shape,
        onTap: () async {
          if (currentCard.number == currentPlayerCards[index].number ||
              currentCard.shape == currentPlayerCards[index].shape) {
            animationController.forward();
            appData.updateCurrentCard(currentPlayerCards[index]);
            print(
                'PlayedCard:${currentPlayerCards[index].shape} ${currentPlayerCards[index].number}');
            appData.playSelectedCard(currentPlayerCards[index]);
            currentCard = currentPlayerCards[index];

            _listKey.currentState.removeItem(
                index,
                (context, animation) => buildItem(
                    context,
                    animation,
                    height,
                    width,
                    index,
                    animationController,
                    currentPlayerCards,
                    playedCards,
                    appData,
                    _listKey,
                    deckOfCards,
                    opponentPlayerCards,
                    opponentListKey),
                duration: Duration(milliseconds: 500));
            currentPlayerCards.removeAt(index);
            if (currentCard.number == 20) {
              showCardDialog(context, height, width);
            }
            Future.delayed(Duration(seconds: 1), () {
              appData.specialCardCheck(opponentListKey);
            });

            Future.delayed(
              Duration(seconds: 2),
              () async {
                appData.checkOpponentsCards();
                if (playable.isNotEmpty) {
                  appData.playCards(opponentListKey, _listKey, height, width,
                      animationController, appData, deckOfCards);
                } else {
                  appData.addCardToPlayer(deckOfCards, false);
                  opponentListKey.currentState
                      .insertItem(0, duration: Duration(milliseconds: 500));
                }
              },
            );
          }
        },
      ),
    ),
  );
}

Widget buildItemOpponent(
    Animation<double> animation,
    double height,
    double width,
    int index,
    AnimationController animationController,
    List<CardDetail> opponentPlayerCards,
    List<CardDetail> playedCards,
    Data appData,
    opponentListKey,
    CardDetail currentCard,
    List<CardDetail> deckOfCards) {
  return ScaleTransition(
    scale: animation,
    child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return CardBuilder(
            height: height,
            width: width,
            number: opponentPlayerCards[index].number,
            shape: opponentPlayerCards[index].shape,
            onTap: () {},
          );
        }),
  );
}
