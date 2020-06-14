import 'package:flutter/material.dart';
import 'package:whot/collection/cards.dart';
import 'package:whot/components/dialogBox.dart';

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
  int cardsPicked = 0;
  int cardsPickedTarget = 0;
  CardDetail currentCard;
  bool opponentTurn=false;
  List<CardDetail> playableCards = [];
  List<int> playableIndexes = [];

  ///test and dummify
  //TODO: delete this function
  dummyCards(){
    // for(int x = 0;x<10;x++){
    // opponentPlayerCards.insert(0, CardDetail('cross', 2));   
    // }
   
  }

  ///Assigns six cards apiece to each player
  ///from the card deck and removes the assigned cards
  ///from the unplayed deck.
  ///this is randomly done
  
  createPlayerCards() {
    currentPlayerCards = getRandomCards(entireCardDeck);
    opponentPlayerCards = getRandomCards(entireCardDeck);
    notifyListeners();
  }

  ///adds a single randomly selected card to a specified player's
  ///unplayed card stack
  void addCardToPlayer(List<CardDetail> cardStack, bool opponent) {
    CardDetail singleCard = getSingleCard(cardStack);
    opponent
        ? opponentPlayerCards.insert(0, singleCard)
        : currentPlayerCards.insert(0, singleCard);
    notifyListeners();
  }

  ///plays the selected card by adding it to the deck of played cards
  ///and changing the currentCard to the card that was last played
  void playSelectedCard(CardDetail selectedCard) {
    currentCard = selectedCard;
    playedCards.add(selectedCard);
    notifyListeners();
  }

  ///Changes the currentCard to the selected card
  ///this is commonly used in the case of a selection
  ///when the Joker 20 card has been played
  void updateCurrentCard(CardDetail selectedCard) {
    currentCard = selectedCard;
    notifyListeners();
  }

  ///Generates a list of the playable cards owned by the opponent
  void getPlayable(CardDetail playableCard, int playableIndex) {
    playableCards.add(playableCard);
    playableIndexes.add(playableIndex);
    notifyListeners();
  }

  ///clears the generated list of opponnent playable cards and
  ///gets ready for a new round
  void clearPlayable() {
    playableIndexes = [];
    notifyListeners();
  }

  ///check if the played card is a special Card
  ///and carries out attached special action if
  ///it is one.
  ///A card 20 triggers a popUp to select current card of choice
  ///A card 14 prompts the player to add a Card to his UnplayedStack
  ///A card 2 prompts the player to add two cards to his Unpla
  //TODO: Resolve Special Card Checking
  void specialCardCheck(BuildContext context, double height, double width,
      bool opponent, AnimationController animation, int length) {
    if (currentCard.number == 14) {
      animation.repeat(); 
      cardsPicked=0;
      cardsPickedTarget=1;
      changeTurn(opponent);
    }
    
    if (currentCard.number == 2) {
      animation.repeat();
      cardsPicked=0;
      cardsPickedTarget=2;
      changeTurn(opponent);
    }
    if (currentCard.number == 20) {
      showJokerSelectionContent(context, height, width, currentCard);
    }
    notifyListeners();
  }

  void changeTurn(bool opponent){
    opponent?opponentTurn=true:opponentTurn=false;
    print('Changed Turn to :$opponentTurn');
    notifyListeners();
  }

  ///Check if the opponent has any card to play
  /// by iterating through the cards and keeping
  /// track of all available playable cards
  void checkOpponentsCards() {
    for (CardDetail card in opponentPlayerCards) {
      if (currentCard.number == card.number ||
          currentCard.shape == card.shape) {
        getPlayable(card, opponentPlayerCards.indexOf(card));
      }
    }
    notifyListeners();
  }

  void resetCardsPicked(){
    cardsPicked=0;
    cardsPickedTarget=0;
    notifyListeners();
  }
  ///initiates the sequence required to play a card and
  ///remove it from the appropriate deck
  void playCards(BuildContext context, double height, double width,
      Data appData, List<CardDetail> deckOfCards, animation) {
    List<int> playable = playableIndexes;

    Future.delayed(
      Duration(seconds: 2),
      () {
        playSelectedCard(opponentPlayerCards[playable.last]);
        opponentPlayerCards.removeAt(playable.last);
        appData.specialCardCheck(context, height, width, false, animation,
            currentPlayerCards.length);
        clearPlayable();
      },
    );
    notifyListeners();
  }

  ///Adds a card from the unplayed deck of cards
  ///to the stack of the opponents cards
  void opponentGotoMarket(List<CardDetail> deckOfCards) {
    addCardToPlayer(deckOfCards, true);
    notifyListeners();
  }
}
