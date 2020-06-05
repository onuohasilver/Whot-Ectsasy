import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:whot/collection/cards.dart';
import 'package:whot/components/cardBuilder.dart';

import 'appProvider.dart';

Widget buildItem(
    Animation<double> animation,
    double height,
    double width,
    int index,
    AnimationController animationController,
    List<CardDetail> currentPlayerCards,
    List<CardDetail> playedCards,
    Data appData,
    _listKey,
    CardDetail currentCard,
    List<CardDetail> deckOfCards,
    List<CardDetail> opponentPlayerCards,
    opponentListKey) {
  return ScaleTransition(
      scale: animation,
      child: CardBuilder(
          height: height,
          width: width,
          number: currentPlayerCards[index].number,
          shape: currentPlayerCards[index].shape,
          onTap: () async {
            await appData.playSelectedCard(currentPlayerCards[index]);
            currentPlayerCards.removeAt(index);
            await _listKey.currentState.removeItem(
              index,
              (context, animation) => buildItem(
                  animation,
                  height,
                  width,
                  index,
                  animationController,
                  currentPlayerCards,
                  playedCards,
                  appData,
                  _listKey,
                  currentCard,
                  deckOfCards,
                  opponentPlayerCards,
                  opponentListKey),
            );

            Future.delayed(
              Duration(seconds: 2),
              () async {
                List<int> playable = [];
                print('tough');
                for (CardDetail card in opponentPlayerCards) {
                  if (currentCard.number == card.number ||
                      currentCard.shape == card.shape) {
                    playable.add(opponentPlayerCards
                        .indexWhere((element) => element == card));
                  }
                }


                if (playable.isNotEmpty) {
                  log(playable.toString());
                  await appData
                      .playSelectedCard(opponentPlayerCards[playable[0]]);
                  opponentPlayerCards.removeAt(playable[0]);
                  await opponentListKey.currentState.removeItem(
                    playable[0],
                    (context, animation) => buildItemOpponent(
                      animation,
                      height,
                      width,
                      playable[0],
                      animationController,
                      opponentPlayerCards,
                      playedCards,
                      appData,
                      opponentListKey,
                      currentCard,
                      deckOfCards,
                    ),
                  );
                } else {
                  appData.addCardToPlayer(deckOfCards, true);
                  opponentListKey.currentState.insertItem(0);
                }
              },
            );
          }));
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
