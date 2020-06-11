import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:whot/components/cardBuilder.dart';
import 'package:whot/collection/cards.dart';
import 'package:whot/gameLogic/appProvider.dart';
import 'package:whot/gameLogic/buildItems.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
    );
  }

  Data appData;

  List<CardDetail> currentPlayerCards;
  List<CardDetail> opponentPlayerCards;
  List<CardDetail> playedCards;
  List<CardDetail> deckOfCards;
  CardDetail currentCard;
  int rangeLength = 6;
  int code;
  bool opponentTurn = false;
  ScrollController scrollController = ScrollController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final GlobalKey<AnimatedListState> _listKeyOpponent = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    appData = Provider.of<Data>(context);
    currentPlayerCards = appData.currentPlayerCards;
    currentPlayerCards.isEmpty ? appData.createPlayerCards() : code = 1;
    opponentPlayerCards = appData.opponentPlayerCards;
    deckOfCards = appData.entireCardDeck;
    currentCard = appData.currentCard;
    playedCards = appData.playedCards;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
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
                      data: CardDetail('circle', 3),
                      feedback: SizedBox(
                        height: height * .3,
                        width: width * .12,
                        child: CardBuilder(
                            height: height,
                            width: width,
                            number: deckOfCards.first.number,
                            shape: deckOfCards.first.shape),
                      ),
                      child: DummyCard(
                        height: height * 3.5,
                        width: width * 1.5,
                        color: Colors.red[900].withOpacity(.5),
                        large: true,
                        onTap: () {
                          scrollController.jumpTo(0.0);
                          appData.addCardToPlayer(deckOfCards, true);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: width * .03),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('$opponentTurn'),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
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
                              return buildItemOpponent(
                                height,
                                width,
                                index,
                                opponentPlayerCards,
                                playedCards,
                                appData,
                                _listKeyOpponent,
                                currentCard,
                                deckOfCards,
                              );
                            },
                          ),
                        ),
                        SizedBox(width: width * .03),
                        Material(
                          elevation: 15,
                          color: Colors.transparent,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            minRadius: width * .035,
                            child: Icon(Icons.person),
                            backgroundColor: Colors.green[900].withOpacity(.8),
                          ),
                        )
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
                                context, height, width, true);
                            setState(() {
                              opponentTurn = true;
                            });

                            ///Handle Opponent Card Playing task
                            print('Checking Opponents');
                            appData.checkOpponentsCards();

                            if (appData.playableIndexes.isEmpty &&
                                opponentTurn) {
                              print('non playable');
                              appData.opponentGotoMarket(deckOfCards);
                              setState(() {
                                opponentTurn = false;
                              });
                            }

                            if (appData.playableCards.isNotEmpty &&
                                opponentTurn) {
                              print('found playable');
                              appData.playCards(
                                  context, height, width, appData, deckOfCards);
                              appData.specialCardCheck(
                                  context, height, width, false);
                              setState(() {
                                opponentTurn = false;
                              });
                            }
                            print('never entered Loop');
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
                          child: DragTarget(
                            builder: (context, listOne, listTwo) {
                              return ListView.builder(
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
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(width: width * .03),
                        Material(
                          elevation: 15,
                          color: Colors.transparent,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                              minRadius: width * .035,
                              child: Icon(Icons.person),
                              backgroundColor: Colors.blue[900].withOpacity(1)),
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
