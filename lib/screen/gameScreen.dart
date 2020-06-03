import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whot/components/cardBuilder.dart';
import 'package:whot/collection/cards.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  int currentCard = 2;
  String currentShape = 'square';
  ScrollController scrollController=ScrollController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
              DummyCard(
                height: height * 3.5,
                width: width * 1.5,
                onTap: () {
                  setState(() {
                    scrollController.jumpTo(2.0);
                    cardsInPlay.insert(
                      2,
                      CardDetail('star', 4),
                    );
                  });
                },
              ),
              SizedBox(width: width * .1),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment:CrossAxisAlignment.center,
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
                  Container(
                    height: height * .3,
                    color: Colors.transparent,
                    width: width * .13,
                    child: Material(
                        borderRadius: BorderRadius.circular(12),
                        child: CardBuilder(
                            height: height,
                            width: width,
                            number: currentCard,
                            shape: currentShape)),
                  ),
                  Container(
                    height: height * .3,
                    width: width * .5,
                    child: ListView.builder(
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
