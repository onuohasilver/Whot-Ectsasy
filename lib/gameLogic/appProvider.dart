import 'package:flutter/material.dart';
import 'package:whot/collection/cards.dart';
import 'package:whot/components/dialogBox.dart';

import 'buildItems.dart';

class Data extends ChangeNotifier {
  List<CardDetail> entireCardDeck = getCards(
    ['star', 'triangle', 'square', 'circle', 'cross'],
  );

  List<CardDetail> currentPlayerCards = [];

  List<CardDetail> opponentPlayerCards = [];

  List<CardDetail> playedCards = [];

  CardDetail currentCard;

  List<CardDetail> playableCards = [];
  List<int> playableIndexes = [];
  bool opponentTurn = false;

  createPlayerCards() {
    currentPlayerCards = getRandomCards(entireCardDeck);
    opponentPlayerCards = getRandomCards(entireCardDeck);
    notifyListeners();
  }

  changeTurn() {
    opponentTurn = !opponentTurn;
    notifyListeners();
  }

  addCardToPlayer(List<CardDetail> cardStack, bool opponent) {
    CardDetail singleCard = getSingleCard(cardStack);
    opponent
        ? opponentPlayerCards.insert(0, singleCard)
        : currentPlayerCards.insert(0, singleCard);
    notifyListeners();
  }

  playSelectedCard(CardDetail selectedCard) {
    currentCard = selectedCard;
    playedCards.add(selectedCard);
    notifyListeners();
  }

  updateCurrentCard(CardDetail selectedCard) {
    currentCard = selectedCard;
    notifyListeners();
  }

  getPlayable(CardDetail playableCard, int playableIndex) {
    playableCards.add(playableCard);
    playableIndexes.add(playableIndex);
    notifyListeners();
  }

  clearPlayable() {
    playableIndexes = [];
    notifyListeners();
  }

  specialCardCheck(context, listKey, height, width) {
    if (currentCard.number == 14) {
      addCardToPlayer(entireCardDeck, true);
      listKey.currentState.insertItem(0, duration: Duration(milliseconds: 500));
    }
    if (currentCard.number == 2) {
      for (int count = 0; count < 2; count++) {
        addCardToPlayer(entireCardDeck, true);
        listKey.currentState
            .insertItem(0, duration: Duration(milliseconds: 500));
      }
    }
    if (currentCard.number == 20) {
      showCardDialog(context, height, width);
    }
  }

  checkOpponentsCards() {
    for (CardDetail card in opponentPlayerCards) {
      if (currentCard.number == card.number ||
          currentCard.shape == card.shape) {
        print(
          'currentCard ${currentCard.shape} and ${currentCard.number}',
        );

        getPlayable(
            card, opponentPlayerCards.indexWhere((element) => element == card));
      }
    }
  }

  playCards(opponentListKey, _listKey, height, width, animationController,
      appData, deckOfCards) {
    List<int> playable = playableIndexes;

    Future.delayed(
      Duration(seconds: 2),
      () {
        playSelectedCard(opponentPlayerCards[playable.last]);
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
        clearPlayable();
        appData.specialCardCheck(_listKey);
      },
    );
  }

  opponentGotoMarket(deckOfCards, _listKeyOpponent) {
    addCardToPlayer(deckOfCards, true);
    _listKeyOpponent.currentState
        .insertItem(0, duration: Duration(milliseconds: 500));
  }
}
