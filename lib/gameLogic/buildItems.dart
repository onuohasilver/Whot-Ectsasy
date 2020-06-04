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
    List<CardDetail> deckOfCards) {
  return ScaleTransition(
    scale: animation,
    child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return CardBuilder(
            height: height,
            width: width,
            number: currentPlayerCards[index].number,
            shape: currentPlayerCards[index].shape,
            onTap: () {
              if (playedCards.isEmpty) {
                appData.playSelectedCard(currentPlayerCards[index]);
                currentPlayerCards.removeAt(index);
                _listKey.currentState.removeItem(
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
                      deckOfCards),
                );
              }

              if (currentCard.number == currentPlayerCards[index].number ||
                  currentCard.shape == currentPlayerCards[index].shape) {
                appData.playSelectedCard(currentPlayerCards[index]);
                currentPlayerCards.removeAt(index);
                _listKey.currentState.removeItem(
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
                      deckOfCards),
                );
                Future.delayed(Duration(seconds: 13), () {
                  currentPlayerCards.insert(1, getSingleCard(deckOfCards));
                  _listKey.currentState.insertItem(1);
                });
              }
            },
          );
        }),
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
    _listKey,
    CardDetail currentCard,
    List<CardDetail> deckOfCards) {
  return ScaleTransition(
    scale: animation,
    child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return DummyCard(
            height: height,
            width: width,
            number: opponentPlayerCards[index].number,
            shape: opponentPlayerCards[index].shape,
            onTap: () {
              if (playedCards.isEmpty) {
                appData.playSelectedCard(opponentPlayerCards[index]);
                opponentPlayerCards.removeAt(index);
                _listKey.currentState.removeItem(
                  index,
                  (context, animation) => buildItem(
                      animation,
                      height,
                      width,
                      index,
                      animationController,
                      opponentPlayerCards,
                      playedCards,
                      appData,
                      _listKey,
                      currentCard,
                      deckOfCards),
                );
              }

              if (currentCard.number == opponentPlayerCards[index].number ||
                  currentCard.shape == opponentPlayerCards[index].shape) {
                appData.playSelectedCard(opponentPlayerCards[index]);
                opponentPlayerCards.removeAt(index);
                _listKey.currentState.removeItem(
                  index,
                  (context, animation) => buildItem(
                      animation,
                      height,
                      width,
                      index,
                      animationController,
                      opponentPlayerCards,
                      playedCards,
                      appData,
                      _listKey,
                      currentCard,
                      deckOfCards),
                );
                Future.delayed(Duration(seconds: 13), () {
                  opponentPlayerCards.insert(1, getSingleCard(deckOfCards));
                  _listKey.currentState.insertItem(1);
                });
              }
            },
          );
        }),
  );
}
