import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whot/gameLogic/multiPlayerProvider.dart';
import 'package:whot/screen/MultiPlayer.dart';

gameLoading(BuildContext context, double height, double width,
    MultiPlayerData appData, Firestore firestore, opponentID, gameID) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              width: width * .3,
              height: height * .4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Waiting for Opponent!'),
                  CircularProgressIndicator(),
                  GameChallengeStream(
                      firestore: firestore,
                      opponentID: opponentID,
                      gameID: gameID)
                ],
              )),
        );
      });
}

class GameChallengeStream extends StatelessWidget {
  const GameChallengeStream({
    Key key,
    @required this.firestore,
    @required this.opponentID,
    @required this.gameID,
  }) : super(key: key);

  final Firestore firestore;
  final String opponentID;
  final String gameID;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: firestore.collection('users').document(opponentID).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data['activeGames'];
          if (data.contains(gameID)) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => MultiPlayer(),
                  ),
                );
              },
            );
          }
        } else {
          return CircularProgressIndicator();
        }
        return Container();
      },
    );
  }
}
