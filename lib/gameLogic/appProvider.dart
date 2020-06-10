import 'package:flutter/material.dart';
import 'package:whot/collection/cards.dart';
import 'package:whot/components/dialogBox.dart';
import 'buildItems.dart';

class Data extends ChangeNotifier {
  List<CardDetail> entireCardDeck = getCards(
    [
      'star',
      'triangle',
      'square',
      'circle',
      'cross',
    ],
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

  void playSelectedCard(CardDetail selectedCard) {
    currentCard = selectedCard;
    playedCards.add(selectedCard);
    notifyListeners();
  }

  void updateCurrentCard(CardDetail selectedCard) {
    currentCard = selectedCard;
    notifyListeners();
  }

  void getPlayable(CardDetail playableCard, int playableIndex) {
    playableCards.add(playableCard);
    playableIndexes.add(playableIndex);
    notifyListeners();
  }

  void clearPlayable() {
    playableIndexes = [];
    notifyListeners();
  }

  void specialCardCheck(BuildContext context, double height, double width) {
    if (currentCard.number == 14) {
      addCardToPlayer(entireCardDeck, true);
    }
    if (currentCard.number == 2) {
      for (int count = 0; count < 2; count++) {
        addCardToPlayer(entireCardDeck, true);
      }
    }
    if (currentCard.number == 20) {
      showCardDialog(context, height, width);
    }
  }

  void checkOpponentsCards() {
    for (CardDetail card in opponentPlayerCards) {
      if (currentCard.number == card.number ||
          currentCard.shape == card.shape) {
        getPlayable(card, opponentPlayerCards.indexOf(card));
      }
    }
  }

  void playCards(BuildContext context, double height, double width,
      Data appData, List<CardDetail> deckOfCards) {
    List<int> playable = playableIndexes;

    Future.delayed(
      Duration(seconds: 2),
      () {
        playSelectedCard(opponentPlayerCards[playable.last]);
        opponentPlayerCards.removeAt(playable.last);

        clearPlayable();
        appData.specialCardCheck(context, height, width);
      },
    );
  }

  opponentGotoMarket(List<CardDetail> deckOfCards) {
    addCardToPlayer(deckOfCards, true);
  }
}
