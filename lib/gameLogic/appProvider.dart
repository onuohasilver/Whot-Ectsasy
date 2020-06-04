import 'package:flutter/material.dart';
import 'package:whot/collection/cards.dart';

class Data extends ChangeNotifier {
  List<CardDetail> entireCardDeck;

  List<CardDetail> currentPlayerCards;

  List<CardDetail> opponentPlayerCards;

  List<CardDetail> playedCards = [];
  CardDetail currentCard;

  void createDeckOfCards() {
    entireCardDeck =
        getCards(['star', 'triangle', 'square', 'circle', 'cross']);
    notifyListeners();
  }

  createPlayerCards(List<CardDetail> cardDeck) {
    currentPlayerCards = getRandomCards(cardDeck);
    opponentPlayerCards = getRandomCards(cardDeck);
    notifyListeners();
  }

  addCardToPlayer(List<CardDetail> cardDeck, bool opponent) {
    CardDetail singleCard = getSingleCard(cardDeck);
    opponent
        ? opponentPlayerCards.insert(1, singleCard)
        : currentPlayerCards.insert(1, singleCard);
    notifyListeners();
  }

  playSelectedCard(CardDetail selectedCard) {
    playedCards.add(selectedCard);
  }
}
