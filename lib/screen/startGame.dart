import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:whot/collection/cards.dart';
import 'package:whot/components/buttons.dart';
import 'package:whot/gameLogic/appProvider.dart';
import 'package:whot/screen/SinglePlayer.dart';
import 'package:whot/components/cardBuilder.dart';
import 'package:whot/screen/loginPage.dart';
import 'dart:ui' as ui;
import 'dart:math';

class StartGame extends StatefulWidget {
  @override
  _StartGameState createState() => _StartGameState();
}

class _StartGameState extends State<StartGame>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 7));
    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        curve: Curves.bounceInOut, parent: animationController));
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
    animationController.repeat(reverse: true);
    Data appData = Provider.of<Data>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
          animation: animation,
          builder: (context, widget) {
            return Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover)),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Transform.rotate(
                        angle: pi / 3 * animation.value,
                        child: Hero(
                          tag:'logo',
                          child: buildWhotCenter(
                              Colors.white, height * 6, width * 3, false),
                        )),
                    LongMenuButton(
                        height: height,
                        width: width,
                        label: 'SINGLE PLAYER',
                        appData: appData,
                        onTap: () {
                          appData.createPlayerCards();
                          appData.playSelectedCard(
                              getSingleCard(appData.entireCardDeck));

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return GameScreen();
                              },
                            ),
                          );
                        }),
                    LongMenuButton(
                      height: height,
                      width: width,
                      label: 'MULTIPLAYER',
                      appData: appData,
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
