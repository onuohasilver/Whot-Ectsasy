import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    Data appData = Provider.of<Data>(context);
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
                        onTap: () {},
                        label: 'Play Random'),
                    LongMenuButton(
                        height: height * 1.2,
                        width: width * 1.2,
                        appData: appData,
                        onTap: () {},
                        label: 'View Previous Games'),
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
