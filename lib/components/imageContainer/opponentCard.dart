import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whot/collection/cards.dart';
import 'package:whot/components/buttons.dart';
import 'package:whot/components/popups/gameLoading.dart';

import 'package:whot/gameLogic/multiPlayerProvider.dart';

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
    this.onTap,
    this.label,
  }) : super(key: key);

  final double height;
  final double width;
  final String name;
  final String avatar;
  final String opponentID;
  final MultiPlayerData appData;
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
                      // String gameID =
                      //     '${opponentID.substring(10)}${appData.currentUser.substring(10)}';
                      print(opponentID);
                      print(appData.currentUser);
                      // appData.reloadEntireDeck();
                      // appData.createPlayerCards(gameID, opponentID);
                      // appData.playSelectedCard(
                      //     getSingleCard(appData.entireCardDeck));

                      // gameLoading(context, height, width, appData, firestore,
                      //     opponentID, gameID);
                    },
                label: label ?? 'Challenge'),
          ],
        ),
      ),
    );
  }
}
