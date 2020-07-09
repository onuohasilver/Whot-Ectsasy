import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whot/components/cardBuilder.dart';
import 'package:whot/components/popups/profileSetUp.dart';
import 'package:whot/constants.dart';
import 'package:whot/gameLogic/appProvider.dart';
import 'dart:ui' as ui;
import 'package:whot/components/buttons.dart';
import 'package:flutter/services.dart';
import 'package:whot/components/InputControllers/textnput.dart';
import 'package:whot/gameLogic/multiPlayerProvider.dart';
import 'package:whot/handler/signInHandlers/googleSignInHandler.dart';
import 'package:whot/handler/signInHandlers/emailSignInHandler.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  Animation animation;
  Animation delayedAnimation;
  Animation repeatingAnimation;
  AnimationController animationController;
  AnimationController repeatingAnimationController;

  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    repeatingAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        curve: Curves.bounceInOut, parent: animationController));
    repeatingAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        curve: Curves.bounceInOut, parent: repeatingAnimationController));
    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        curve: Interval(.3, 1.0, curve: Curves.bounceInOut),
        parent: animationController));
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
    );
    super.initState();
  }

@override
  void dispose() {
    animationController.dispose();
    repeatingAnimationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    MultiPlayerData appData = Provider.of<MultiPlayerData>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    repeatingAnimationController.repeat(reverse: true);
    animationController.forward();
    return Scaffold(
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: repeatingAnimationController,
          builder: (context, widget) {
            return Container(
              decoration: kBackgroundImage,
              height: height,
              width: width,
              child: Row(
                children: <Widget>[
                  Container(
                    width: width * .4,
                    height: height,
                    color: Colors.white.withOpacity(.4),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Transform.rotate(
                        angle: pi,
                        child: buildWhotCenter(
                            Colors.white,
                            height * 4 * (repeatingAnimation.value + 1),
                            width * 3 * (repeatingAnimation.value + 1),
                            false),
                      ),
                    ),
                  ),
                  Container(
                      width: width * .6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Transform(
                            transform: Matrix4.translationValues(
                                animation.value * width, 0, 0),
                            child: TextInputContainer(
                                width: width,
                                hint: 'youremail@here.com',
                                email: true),
                          ),
                          Transform(
                            transform: Matrix4.translationValues(
                                0, animation.value * width, 0),
                            child: TextInputContainer(
                              width: width,
                              hint: 'your password here',
                              email: false,
                            ),
                          ),
                          SizedBox(height: height * .03),
                          Transform(
                            transform: Matrix4.translationValues(
                                animation.value * width, 0, 0),
                            child: LongMenuButton(
                              appData: appData,
                              height: height,
                              width: width,
                              label: 'Create Account',
                              onTap: () {
                                showProfileSetup(
                                    context, height, width, appData, false);
                              },
                            ),
                          ),
                          Divider(
                            indent: width * .1,
                            endIndent: width * .1,
                          ),
                          Transform(
                            transform: Matrix4.translationValues(
                                0, animation.value * width, 0),
                            child: LongMenuButton(
                              appData: appData,
                              height: height,
                              width: width,
                              color: Colors.green,
                              //TODO: Add google Image Icon here
                              label: 'Continue With Google',
                              onTap: () async {
                                showProfileSetup(
                                    context, height, width, appData, true);
                              },
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
