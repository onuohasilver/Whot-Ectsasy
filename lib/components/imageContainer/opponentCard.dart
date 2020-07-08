import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whot/collection/cards.dart';
import 'package:whot/components/buttons.dart';
import 'package:whot/gameLogic/appProvider.dart';
import 'package:whot/screen/MultiPlayer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OpponentCard extends StatelessWidget {
  const OpponentCard({
    Key key,
    @required this.height,
    @required this.width,
    @required this.appData,
    @required this.name,
    @required this.avatar,
    @required this.opponentID,
    this.onTap, this.label,
  }) : super(key: key);

  final double height;
  final double width;
  final String name;
  final String avatar;
  final String opponentID;
  final Data appData;
  final Function onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    Firestore firestore = Firestore.instance;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * .015),
      child: Container(
        height: height * .6,
        width: width * .2,
        padding: EdgeInsets.symmetric(horizontal: width * .025),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: [
                CircleAvatar(
                    maxRadius: width * .07,
                    backgroundColor: Colors.brown,
                    backgroundImage: AssetImage('assets/profile$avatar.png')),
                Positioned.fill(
                  right: width * .01,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: height * .06,
                      width: width * .05,
                      child:
                          Material(shape: CircleBorder(), color: Colors.orange),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * .04),
            Text(
              name,
              style: GoogleFonts.poppins(),
            ),
            LongMenuButton(
                height: height,
                width: width,
                appData: appData,
                onTap: onTap ??
                    () {
                      appData.createPlayerCards();
                      appData.playSelectedCard(
                          getSingleCard(appData.entireCardDeck));
                      firestore
                          .collection('users')
                          .document(appData.currentUser)
                          .setData({
                        'activeGames': {
                          'gameOn': {
                            'entireCardDeck':
                                bleedCards(appData.entireCardDeck),
                            'currentCard': bleedSingleCard(appData.currentCard),
                            'opponentPlayerCards':
                                bleedCards(appData.opponentPlayerCards),
                            'currentPlayerCards':
                                bleedCards(appData.currentPlayerCards)
                          }
                        },
                      }, merge: true);
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => MultiPlayer()));
                    },
                label:label?? 'Challenge')
          ],
        ),
      ),
    );
  }
}
