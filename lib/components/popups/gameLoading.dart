import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whot/gameLogic/multiPlayerProvider.dart';
import 'package:whot/screen/MultiPlayer.dart';

gameLoading(BuildContext context, double height, double width,
    MultiPlayerData appData, Firestore firestore, opponentID) {
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
                    gameID: appData.gameID,
                    appData: appData,
                  )
                ],
              )),
        );
      });
}

///Listens for accepted game challenges
///GameID(firestore,opponentID,gameID,appData)
///firestore: firestore instance initiated app wide
///opponentID: unique identifier of the opponent on firebase
///gameID: a combination of the substrings of the opponentID and the currentUserID
///appData: the provider data for multiplayer game play
class GameChallengeStream extends StatelessWidget {
  const GameChallengeStream({
    Key key,
    @required this.firestore,
    @required this.opponentID,
    @required this.gameID,
    @required this.appData,
  }) : super(key: key);

  final Firestore firestore;
  final String opponentID;
  final String gameID;
  final MultiPlayerData appData;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: firestore.collection('users').document(opponentID).snapshots(),
      builder: (context, snapshot) {
        final initialChallenges = snapshot.data['challenges'];

        ///adds the current users challengeID to the opponent users
        ///challenge array on firebase
        if (!initialChallenges.contains(appData.currentUser)) {
          initialChallenges.add(appData.currentUser);
          firestore.collection('users').document(opponentID).setData(
            {'challenges': initialChallenges},
            merge: true,
          );
        }

        if (snapshot.hasData) {
          /// Checks to see if the opponent has added the challenge ID to their
          /// activeGame array and navigates to the MultiPlayer
          /// game screen if the condition has been satisfied
          final data = snapshot.data['activeGames'];
          if (data.contains(gameID)) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                Navigator.pop(context);

                Navigator.pushReplacement(
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
