import 'package:flutter/material.dart';
import 'package:whot/collection/cards.dart';

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
        ? opponentPlayerCards.insert(1, singleCard)
        : currentPlayerCards.insert(1, singleCard);
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
}
