import 'dart:math';

///model for the card items
///initialized as CardDetail(shape,number)
///shape: The shape of the card
/// number: the number value attached to the card
class CardDetail {
  CardDetail(this.shape, this.number);
  String shape;
  int number;
}

/// generate all the  cards needed to make a stack of cards
/// and also shuffle the list of generated cards
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
  for (var number = 0; number < 5; number++) {
    generatedCards.add(CardDetail('joker', 20));
  }
  generatedCards.shuffle(Random());
  return generatedCards;
}

///variable to hold the generated cardStack from getCards() function
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

///returns a single card from the playable card deck
///and removes it from the deck
CardDetail getSingleCard(List<CardDetail> cardStack) {
  CardDetail singleCard = cardStack.first;
  cardStack.removeAt(0);
  return singleCard;
}

///bleeds out the shapes and numbers contained in
///each cardStack in and ordered manner
Map<String, Map> bleedCards(List<CardDetail> stackOfCards) {
  Map<String, Map> bledCards = {
    'square': {'cardNumber': [], 'cardIndex': []},
    'circle': {'cardNumber': [], 'cardIndex': []},
    'cross': {'cardNumber': [], 'cardIndex': []},
    'triangle': {'cardNumber': [], 'cardIndex': []},
    'star': {'cardNumber': [], 'cardIndex': []},
    'joker': {'cardNumber': [], 'cardIndex': []}
  };
  for (int index = 0; index < stackOfCards.length; index++) {
    switch (stackOfCards[index].shape) {
      case 'square':
        bledCards['square']['cardNumber'].add(stackOfCards[index].number);
        bledCards['square']['cardIndex'].add(index);
        break;
      case 'circle':
        bledCards['circle']['cardNumber'].add(stackOfCards[index].number);
        bledCards['circle']['cardIndex'].add(index);
        break;
      case 'cross':
        bledCards['cross']['cardNumber'].add(stackOfCards[index].number);
        bledCards['cross']['cardIndex'].add(index);
        break;
      case 'triangle':
        bledCards['triangle']['cardNumber'].add(stackOfCards[index].number);
        bledCards['triangle']['cardIndex'].add(index);
        break;
      case 'star':
        bledCards['star']['cardNumber'].add(stackOfCards[index].number);
        bledCards['star']['cardIndex'].add(index);
        break;
      case 'joker':
        bledCards['joker']['cardNumber'].add(stackOfCards[index].number);
        bledCards['joker']['cardIndex'].add(index);
        break;

      default:
    }
  }
  return bledCards;
}

///bleeds a single Card and returns a
///compact list containing the shape and number of the card
List bleedSingleCard(singleCard) {
  List bledCard;
  bledCard = [singleCard.shape, singleCard.number];
  return bledCard;
}

List<CardDetail> cardsInPlay = getRandomCards(cardStack);

List<int> dummyIntegers = [1, 2, 3, 4, 5, 6, 7];
