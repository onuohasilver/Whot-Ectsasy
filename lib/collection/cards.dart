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

List<CardDetail> getRandomCards(List<CardDetail> cardStack) {
  List<CardDetail> cardsInPlay = [];
  for (var index = 0; index < 6; index++) {
    int randomIndex = Random().nextInt(cardStack.length);
    cardsInPlay.add(cardStack[randomIndex]);
    cardStack.removeAt(randomIndex);
  }
  return cardsInPlay;
}

getSingleCard(List<CardDetail> cardStack) {
  int randomIndex = Random().nextInt(cardStack.length);
  CardDetail singleCard = cardStack[randomIndex];
  cardStack.removeAt(randomIndex);
  return singleCard;
}

List<CardDetail> cardsInPlay = getRandomCards(cardStack);

List<int> dummyIntegers = [
  1,
  2,
  3,
  4,
  5,
  6,
  7
];
