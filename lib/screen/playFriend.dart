import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whot/components/imageContainer/opponentCard.dart';
import 'package:whot/constants.dart';
import 'package:whot/gameLogic/multiPlayerProvider.dart';

class PlayFriend extends StatefulWidget {
  @override
  _PlayFriendState createState() => _PlayFriendState();
}

class _PlayFriendState extends State<PlayFriend> {
  Firestore firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    MultiPlayerData appData = Provider.of<MultiPlayerData>(context);

    return Scaffold(
      body: Container(
          height: height,
          decoration: kBackgroundImage,
          width: width,
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Row(
              children: <Widget>[
                Container(
                  height: height * .7,
                  width: width,
                  padding: EdgeInsets.all(height * .02),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: firestore.collection('users').snapshots(),
                      builder: (context, snapshot) {
                        List<Widget> friendsCards = [Text('')];

                        if (snapshot.hasData) {
                          final users = snapshot.data.documents;
                          dynamic friendList;

                          ///Go through the users and find the currentUserDocument
                          ///access the list of friends and build a list of widgets from it
                          for (var user in users) {
                            (user['userid'] == appData.currentUser)
                                ? friendList = user['friends']
                                : Container();
                          }
                          for (String friend in friendList.keys) {
                            friendsCards.add(
                              OpponentCard(
                                  name: friendList[friend]['name'],
                                  avatar: friendList[friend]['avatar'],
                                  opponentID: friendList[friend]['userid'],
                                  height: height,
                                  width: width,
                                  appData: appData),
                            );
                            Container();
                          }
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            children: friendsCards,
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                )
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
