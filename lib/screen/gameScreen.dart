import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:whot/components/cardBuilder.dart';
import 'package:whot/collection/cards.dart';
import 'package:whot/gameLogic/appProvider.dart';

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
    animationColor = ColorTween(begin: Colors.red, end: Colors.green)
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

  int currentCard = 2;
  String currentShape = 'square';
  ScrollController scrollController = ScrollController();

  Color deckColor = Colors.white;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    appData = Provider.of<Data>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    appData.createDeckOfCards();

    appData.createPlayerCards(appData.entireCardDeck);
    print(appData.opponentPlayerCards.first);
    print(appData.currentPlayerCards.first);

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          color: Colors.brown[100],
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
                      onTap: () {
                        setState(() {
                          animationController.forward();

                          scrollController.jumpTo(1.0);
                          appData.currentPlayerCards
                              .insert(1, getSingleCard(appData.entireCardDeck));
                          _listKey.currentState.insertItem(1);
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(width: width * .1),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: height * .2,
                    width: width * .5,
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: dummyIntegers.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return DummyCard(
                          height: height,
                          width: width,
                        );
                      },
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
                        padding: EdgeInsets.only(left: 5, top: 1),
                        child: Container(
                          height: height * .3,
                          width: width * .13,
                          child: Material(
                              borderRadius: BorderRadius.circular(12),
                              child: CardBuilder(
                                  height: height,
                                  width: width,
                                  number: currentCard,
                                  shape: currentShape)),
                        ),
                      )
                    ],
                  ),
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
                        return buildItem(animation, height, width, index);
                      },
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

  Widget buildItem(
      Animation<double> animation, double height, double width, int index) {
    return ScaleTransition(
      scale: animation,
      child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return CardBuilder(
              height: height,
              width: width,
              number: appData.currentPlayerCards[index].number,
              shape: appData.currentPlayerCards[index].shape,
              onTap: () {
                if (currentCard == appData.currentPlayerCards[index].number ||
                    currentShape == appData.currentPlayerCards[index].shape) {
                  currentCard = appData.currentPlayerCards[index].number;
                  currentShape = appData.currentPlayerCards[index].shape;
                  appData.currentPlayerCards.removeAt(index);
                  _listKey.currentState.removeItem(
                      index,
                      (context, animation) =>
                          buildItem(animation, height, width, index));
                  Future.delayed(Duration(seconds: 13), () {
                    appData.currentPlayerCards
                        .insert(1, getSingleCard(appData.entireCardDeck));
                    _listKey.currentState.insertItem(1);
                  });
                }
              },
            );
          }),
    );
  }
}
