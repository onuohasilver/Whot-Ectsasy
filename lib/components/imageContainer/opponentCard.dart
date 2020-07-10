import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whot/components/buttons.dart';
import 'package:whot/components/popups/gameLoading.dart';

import 'package:whot/gameLogic/multiPlayerProvider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

///Returns a container with the Opponent details containing the username
///the opponent avatar and a call to action button 
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
                      appData.setGameIDs(
                          '${opponentID.substring(10)}${appData.currentUser.substring(10)}',
                          opponentID);

                      appData.reloadEntireDeck();
                      appData.createPlayerCards(opponentID);
                      gameLoading(context, height, width, appData, firestore,
                          opponentID);
                    },
                label: label ?? 'Challenge'),
          ],
        ),
      ),
    );
  }
}
