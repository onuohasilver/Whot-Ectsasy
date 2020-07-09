import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whot/gameLogic/multiPlayerProvider.dart';
import 'package:whot/screen/allUsers.dart';
import 'package:whot/screen/gameChallenges.dart';
import 'package:whot/screen/playFriend.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whot/components/buttons.dart';
import 'package:whot/components/imageContainer/userWhiteCard.dart';
import 'package:whot/gameLogic/appProvider.dart';
import 'package:whot/handler/routeHandler.dart';
import 'package:whot/constants.dart';
import 'dart:ui' as ui;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  FirebaseAuth auth = FirebaseAuth.instance;
  Firestore firestore = Firestore.instance;
  Animation animation;
  AnimationController animationController;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation = Tween(begin: 0, end: 1).animate(CurvedAnimation(
        curve: Curves.bounceInOut, parent: animationController));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    MultiPlayerData appData = Provider.of<MultiPlayerData>(context);
    // animationController.forward();
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: kBackgroundImage,
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Row(
            children: <Widget>[
              UserWhiteCard(width: width, height: height, appData: appData),
              Container(
                width: width * .6,
                height: height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LongMenuButton(
                        height: height * 1.2,
                        width: width * 1.2,
                        appData: appData,
                        onTap: () {
                          // createRoute(PlayFriend());
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => PlayFriend()));
                        },
                        label: 'Play a Friend'),
                    LongMenuButton(
                        height: height * 1.2,
                        width: width * 1.2,
                        appData: appData,
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => AllUsers()));
                        },
                        label: 'View All Users'),
                    Stack(children: [
                      LongMenuButton(
                          height: height * 1.2,
                          width: width * 1.2,
                          appData: appData,
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => GameChallenges()));
                          },
                          label: 'Game Challenges'),
                      StreamBuilder<DocumentSnapshot>(
                          stream: firestore
                              .collection('users')
                              .document(appData.currentUser)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                final challenges = snapshot.data['activeGames'];
                                appData.updateChallenges(challenges.length);
                              });
                              return Container(height: 0, width: 0);
                            } else {
                              return Container(height: 0, width: 0);
                            }
                          }),
                      Positioned.fill(
                        right: width * .04,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: (appData.challenges > 0)
                              ? Container(
                                  height: height * .05,
                                  width: width * .05,
                                  child: Material(
                                      shape: CircleBorder(),
                                      child: Center(
                                        child: Text(
                                            appData.challenges.toString(),
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                      color: Colors.red),
                                )
                              : Container(),
                        ),
                      ),
                    ]),
                    LongMenuButton(
                        height: height * 1.2,
                        width: width * 1.2,
                        appData: appData,
                        onTap: () {},
                        color: Colors.grey[600],
                        label: 'Account Settings')
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
