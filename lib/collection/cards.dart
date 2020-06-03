import 'dart:math';

class CardDetail {
  CardDetail(this.shape, this.number);
  String shape;
  int number;
}

List<CardDetail> getCards(List<String> shape) {
  List<CardDetail> generatedCards = [];

  for (var index = 0; index < shape.length; index++) {
    for (var number = 1; number < 9; number++) {
      generatedCards.add(CardDetail(shape[index], number));
    }
    for (var number = 10; number < 15; number++) {
      generatedCards.add(CardDetail(shape[index], number));
    }
  }

  return generatedCards;
}

List<CardDetail> cardStack =
    getCards(['triangle', 'star', 'square', 'cross', 'circle']);

List<CardDetail> getRandomCards() {
  List<CardDetail>cardsInPlay=[];
  for(var index=0;index<5;index++){
    cardsInPlay.add(cardStack[Random().nextInt(cardStack.length)]);
  }
  return cardsInPlay;
}

List<CardDetail>cardsInPlay=getRandomCards();

List<int> dummyIntegers = [
  1,
  2,
  3,
  4,
  5,
];
