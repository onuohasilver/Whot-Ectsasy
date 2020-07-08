import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:whot/components/cardBuilder.dart';
import 'package:whot/collection/cards.dart';
import 'package:whot/components/customWidgets.dart';
import 'package:whot/gameLogic/appProvider.dart';
import 'package:whot/gameLogic/buildItems.dart';
import 'package:whot/constants.dart';
import 'dart:ui' as ui;

class MultiPlayer extends StatefulWidget {
  @override
  _MultiPlayerState createState() => _MultiPlayerState();
}

class _MultiPlayerState extends State<MultiPlayer>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animation = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(animationController)
          ..addListener(() {
            setState(() {});
          });
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
    );
  }

  Data appData;
  AnimationController animationController;
  Animation _animation;
  List<CardDetail> currentPlayerCards;
  List<CardDetail> opponentPlayerCards;
  List<CardDetail> playedCards;
  List<CardDetail> deckOfCards;
  CardDetail currentCard;

  int code;

  ScrollController scrollController = ScrollController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final GlobalKey<AnimatedListState> _listKeyOpponent = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    appData = Provider.of<Data>(context);
    bool opponentTurn = appData.opponentTurn;
    currentPlayerCards = appData.currentPlayerCards;
    
    opponentPlayerCards = appData.opponentPlayerCards;
    deckOfCards = appData.entireCardDeck;
    currentCard = appData.currentCard;
    playedCards = appData.playedCards;

    return SafeArea(
      child: Scaffold(
        //Total Game Background Base
        body: Container(
          height: height,
          width: width,
          decoration: kBackgroundImage,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //Stack of Unplayed Cards
              BackdropFilter(
                filter:ui.ImageFilter.blur(sigmaX:5.0,sigmaY:4.0),
                              child: Container(
                  //Animate Border Color when there is a go to market call
                  decoration: BoxDecoration(
                      border: Border.all(width: 6, color: _animation.value),
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    overflow: Overflow.visible,
                    fit: StackFit.loose,
                    children: [
                      DummyCard(
                        height: height * 3.5,
                        width: width * 1.5,
                        large: true,
                        color: Colors.red.withOpacity(.7),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0, top: 5),
                        child: DummyCard(
                          height: height * 3.5,
                          width: width * 1.5,
                          large: true,
                          color: Colors.red[800],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 10),
                        child: Draggable(
                          data: CardDetail(
                              deckOfCards.first.shape, deckOfCards.first.number),
                          feedback: SizedBox(
                            height: height * .3,
                            width: width * .12,
                            child: CardBuilder(
                                height: height,
                                width: width,
                                number: deckOfCards.first.number,
                                shape: deckOfCards.first.shape),
                          ),
                          onDragCompleted: () {
                            appData.cardsPicked++;
                            if (appData.cardsPicked ==
                                appData.cardsPickedTarget) {
                              animationController.reset();
                              appData.resetCardsPicked();
                            }
                          },
                          child: DummyCard(
                            height: height * 3.5,
                            width: width * 1.5,
                            color: Colors.red[900].withOpacity(.5),
                            large: true,
                            onTap: () {
                              scrollController.jumpTo(0.0);
                              appData.addCardToPlayer(deckOfCards, false);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: width * .03),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //Opponent Unplayed Cards Deck
                        Container(
                          height: height * .2,
                          width: width * .5,
                          child: ListView.builder(
                            key: _listKeyOpponent,
                            physics: BouncingScrollPhysics(),
                            controller: scrollController,
                            itemCount: opponentPlayerCards.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return buildOpponentPlayerCards(
                                height,
                                width,
                                index,
                                opponentPlayerCards,
                                playedCards,
                                appData,
                                currentCard,
                                deckOfCards,
                              );
                            },
                          ),
                        ),
                        SizedBox(width: width * .03),
                        //Opponent Avatar Image
                        Avatar(width: width),
                      ],
                    ),
                  ),
                  Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        height: height * .3,
                        width: width * .13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 5, top: 1, right: width * .1),
                        child: DragTarget(
                          onAccept: (CardDetail cardDetail) {
                            ///Handle CurrentPlayer Card Playing task
                            appData.playSelectedCard(cardDetail);
                            currentPlayerCards.removeAt(
                                currentPlayerCards.indexOf(cardDetail));
                            appData.specialCardCheck(
                                context,
                                height,
                                width,
                                true,
                                animationController,
                                opponentPlayerCards.length);

                            appData.changeTurn(true);

                            ///Handle Opponent Card Playing task
                            print('Checking Opponents');
                            appData.checkOpponentsCards();
                            print('Opponents Turn?? $opponentTurn');
                            if (appData.playableIndexes.isEmpty) {
                              print('non playable');
                              appData.opponentGotoMarket(deckOfCards);
                              appData.changeTurn(false);
                            }

                            if (appData.playableCards.isNotEmpty) {
                              print('found playable');
                              appData.playCards(context, height, width, appData,
                                  deckOfCards, animationController);
                              appData.changeTurn(false);
                            }

                            print('never entered Loop $opponentTurn');
                          },
                          onWillAccept: (CardDetail cardDetail) {
                            if (!opponentTurn &
                                (cardDetail.shape == currentCard.shape ||
                                    cardDetail.number == currentCard.number ||
                                    cardDetail.number == 20)) {
                              return true;
                            } else {
                              return false;
                            }
                          },
                          builder: (context, cardOne, cardTwo) {
                            return Container(
                              height: height * .3,
                              width: width * .11,
                              child: Material(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.pink,
                                child: CardBuilder(
                                    height: height,
                                    width: width,
                                    number: currentCard.number,
                                    shape: currentCard.shape),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            height: height * .3,
                            width: width * .5,
                            child: ListView.builder(
                              key: _listKey,
                              physics: BouncingScrollPhysics(),
                              controller: scrollController,
                              itemCount: currentPlayerCards.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (
                                BuildContext context,
                                int index,
                              ) {
                                return buildCurrentPlayerCards(
                                    context,
                                    height,
                                    width,
                                    index,
                                    currentPlayerCards,
                                    playedCards,
                                    appData,
                                    deckOfCards,
                                    opponentPlayerCards,
                                    scrollController,
                                    animationController);
                              },
                            )),
                        SizedBox(width: width * .03),
                        Avatar(
                          width: width,
                          
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
