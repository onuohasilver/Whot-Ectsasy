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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: height * .2,
                width: width * .5,
                child: ListView.builder(
                  itemCount: cardStack.length,
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
                  child:Center(child: Text('deck'))
                ),
              ),
              Container(
                height: height * .3,
                width: width * .5,
                child: ListView.builder(
                  itemCount: cardStack.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return CardBuilder(
                        height: height,
                        width: width,
                        number: cardStack[index].number,
                        shape: cardStack[index].shape);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
