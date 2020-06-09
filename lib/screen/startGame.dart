import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:whot/collection/cards.dart';
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
                color: Colors.brown ,
                child: Text(
                  'Play!',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  appData.createPlayerCards();
                  appData
                      .playSelectedCard(getSingleCard(appData.entireCardDeck));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return GameScreen();
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
