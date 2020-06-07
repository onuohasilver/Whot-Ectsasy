import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:whot/collection/cards.dart';
import 'package:whot/components/cardBuilder.dart';
import 'package:whot/gameLogic/appProvider.dart';
import 'package:whot/screen/gameScreen.dart';

class StartGame extends StatefulWidget {
  @override
  _StartGameState createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Data appData = Provider.of<Data>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                color: Colors.brown,
                child: Text(
                  'Play!',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: dialogContent(context, height, width),
                      );
                    },
                  );

                  // appData.createPlayerCards();
                  // appData
                  //     .playSelectedCard(getSingleCard(appData.entireCardDeck));

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return GameScreen();
                  //     },
                  //   ),
                  // );
                }),
          ],
        ),
      ),
    );
  }
}

dialogContent(BuildContext context, height, width) {
  return Container(
    height: height * .5,
    width: width * .7,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white.withOpacity(.5),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Choose Shape:'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getCards(height, width, 'circle'),
            getCards(height, width, 'square'),
            getCards(height, width, 'cross'),
            getCards(height, width, 'triangle'),
            getCards(height, width, 'star'),
          ],
        ),
      ],
    ),
  );
}

Padding getCards(double height, double width, String shape) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: height * .3,
      width: width * .1,
      child: CardBuilder(
        onTap: (){},
        shape: shape,
        number: 0,
        width: width * 1.3,
        height: height,
      ),
    ),
  );
}
