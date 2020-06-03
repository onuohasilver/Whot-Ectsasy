import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whot/components/cardBuilder.dart';
import 'package:whot/collection/cards.dart';

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
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationOffset =
        Tween<Offset>(begin: Offset.zero, end: Offset(0.1, 0.1)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.bounceInOut,
      ),
    );
    animationController.repeat();

    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
    );
  }

  AnimationController animationController;
  Animation animation;
  Animation<Offset> animationOffset;
  int currentCard = 2;
  String currentShape = 'square';
  ScrollController scrollController = ScrollController();
  double animateValue = 0.0;
  Color deckColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print(animationOffset);
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
                          print('The new animation: $animationOffset');
                          scrollController.jumpTo(1.0);
                          cardsInPlay.insert(
                            1,
                            CardDetail('star', 4),
                          );
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
                          color: deckColor,
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
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      controller: scrollController,
                      itemCount: cardsInPlay.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return CardBuilder(
                          height: height,
                          width: width,
                          number: cardsInPlay[index].number,
                          shape: cardsInPlay[index].shape,
                          onTap: () {
                            setState(
                              () {
                                currentCard = cardsInPlay[index].number;
                                currentShape = cardsInPlay[index].shape;
                                cardsInPlay.removeAt(index);
                                if (deckColor == Colors.white) {
                                  deckColor = Colors.red[900];
                                } else {
                                  deckColor = Colors.white;
                                }
                              },
                            );
                          },
                        );
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
}
