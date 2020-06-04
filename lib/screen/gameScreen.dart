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
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animationColor = ColorTween(begin: Colors.red, end: Colors.red)
        .animate(animationController);
    animation = Tween(begin: 0.0, end: 2.0).animate(animationController);

    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
    );
  }

  Animation animation;
  AnimationController animationController;
  Animation<Color> animationColor;
  Data appData;
  ScrollController scrollController = ScrollController();
  List<CardDetail> currentPlayerCards;
  List<CardDetail> opponentPlayerCards;
  List<CardDetail> playedCards;
  List<CardDetail> deckOfCards;
  CardDetail currentCard;
  Color deckColor = Colors.white;
  int code;
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

    print(deckOfCards);

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
              Text('PC:${playedCards.length} '),
              Text('DC:${deckOfCards.length} '),
              Stack(
                overflow: Overflow.visible,
                fit: StackFit.loose,
                children: [
                  DummyCard(
                    height: height * 3.5,
                    width: width * 1.5,
                    large: true,
                    color: Colors.black,
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
                    child: DummyCard(
                      height: height * 3.5,
                      width: width * 1.5,
                      color: Colors.red[900].withOpacity(.7),
                      large: true,
                      onTap: () {
                        animationController.forward();
                        scrollController.jumpTo(1.0);
                        appData.addCardToPlayer(deckOfCards, false);
                        _listKey.currentState.insertItem(1);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(width: width * .03),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: height * .2,
                          width: width * .5,
                          child: AnimatedList(
                            key: _listKeyOpponent,
                            physics: BouncingScrollPhysics(),
                            controller: scrollController,
                            initialItemCount: appData.opponentPlayerCards.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder:
                                (BuildContext context, int index, animation) {
                              return buildItemOpponent(
                                  animation,
                                  height,
                                  width,
                                  index,
                                  animationController,
                                  opponentPlayerCards,
                                  playedCards,
                                  appData,
                                  _listKeyOpponent,
                                  currentCard,
                                  deckOfCards);
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
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        height: height * .3,
                        width: width * .13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: animationColor.value,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 5, top: 1, right: width * .1),
                        child: Container(
                          height: height * .3,
                          width: width * .13,
                          child: Material(
                            borderRadius: BorderRadius.circular(12),
                            child: CardBuilder(
                                height: height,
                                width: width,
                                number: currentCard?.number ?? 0,
                                shape: currentCard?.shape ?? 'start'),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: height * .3,
                          width: width * .5,
                          child: AnimatedList(
                            key: _listKey,
                            physics: BouncingScrollPhysics(),
                            controller: scrollController,
                            initialItemCount: appData.currentPlayerCards.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder:
                                (BuildContext context, int index, animation) {
                              return buildItem(
                                  animation,
                                  height,
                                  width,
                                  index,
                                  animationController,
                                  currentPlayerCards,
                                  playedCards,
                                  appData,
                                  _listKey,
                                  currentCard,
                                  deckOfCards);
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
