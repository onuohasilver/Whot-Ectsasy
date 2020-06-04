import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whot/gameLogic/appProvider.dart';
import 'package:whot/screen/gameScreen.dart';

class StartGame extends StatefulWidget {
  @override
  _StartGameState createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {
  @override
  Widget build(BuildContext context) {
    Data appData = Provider.of<Data>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: RaisedButton(
              child: Text('Andrew'),
              onPressed: () {
                appData.createPlayerCards();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return GameScreen();
                    },
                  ),
                );
              }),
        ),
      ),
    );
  }
}
