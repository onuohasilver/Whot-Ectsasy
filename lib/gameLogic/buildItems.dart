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
              height: height, width: width, number: 2, shape: 'star')),
      childWhenDragging: Container(),
      child: CardBuilder(
        height: height,
        width: width,
        number: currentPlayerCards[index].number,
        shape: currentPlayerCards[index].shape,
        onTap: () async {
          print(
              'CurrentCard:${appData.currentCard.shape} ${appData.currentCard.number}');

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
            Future.delayed(Duration(seconds: 3), () {
              /// adds Card to opponent Player if the played card value equals (2 or 14)
              if (currentCard.number == 14) {
                appData.addCardToPlayer(deckOfCards, true);
                opponentListKey.currentState
                    .insertItem(0, duration: Duration(milliseconds: 500));
              }
              if (currentCard.number == 2) {
                for (int count = 0; count < 2; count++) {
                  appData.addCardToPlayer(deckOfCards, true);
                  opponentListKey.currentState
                      .insertItem(0, duration: Duration(milliseconds: 500));
                }
              }
            });

            Future.delayed(
              Duration(seconds: 5),
              () async {
                for (CardDetail card in opponentPlayerCards) {
                  print(
                      'currentCard: ${currentCard.number}${currentCard.shape}');

                  print('opponentCard: ${card.number}${card.shape}');
                  if (currentCard.number == card.number ||
                      currentCard.shape == card.shape) {
                    print(
                        'MatchcurrentCard: ${currentCard.number}${currentCard.shape}');

                    print('Match opponentCard: ${card.number}${card.shape}');
                    appData.getPlayable(
                        card,
                        opponentPlayerCards
                            .indexWhere((element) => element == card));
                  }
                }

                /// play opponent card if there is any available playable card
                if (playable.isNotEmpty) {
                  for (int indexx = 0; indexx < playable.length; indexx++) {
                    print(
                        'This is playable ${appData.playableCards[indexx].shape}  ${appData.playableCards[indexx].number} ');
                  }
                  appData.playSelectedCard(opponentPlayerCards[playable.last]);
                  opponentPlayerCards.removeAt(playable.last);
                  opponentListKey.currentState.removeItem(
                    playable.last,
                    (context, animation) => buildItemOpponent(
                      animation,
                      height,
                      width,
                      playable.last,
                      animationController,
                      opponentPlayerCards,
                      playedCards,
                      appData,
                      opponentListKey,
                      currentCard,
                      deckOfCards,
                    ),
                  );
                  appData.clearPlayable();
                  if (currentCard.number == 14) {
                    appData.addCardToPlayer(deckOfCards, true);
                    _listKey.currentState
                        .insertItem(0, duration: Duration(milliseconds: 500));
                  }
                  if (currentCard.number == 2) {
                    for (int count = 0; count < 2; count++) {
                      appData.addCardToPlayer(deckOfCards, false);
                      _listKey.currentState
                          .insertItem(0, duration: Duration(milliseconds: 500));
                    }
                  }
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
          return DummyCard(
            height: height,
            width: width,
            number: opponentPlayerCards[index].number,
            shape: opponentPlayerCards[index].shape,
            onTap: () {},
          );
        }),
  );
}
