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

  
  createPlayerCards() {
    currentPlayerCards = getRandomCards(entireCardDeck);
    opponentPlayerCards = getRandomCards(entireCardDeck);
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
    playedCards.add(selectedCard);
    currentCard = selectedCard;

    notifyListeners();
  }
}
