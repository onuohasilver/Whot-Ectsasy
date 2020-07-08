import 'package:flutter/material.dart';
import 'package:whot/components/InputControllers/textnput.dart';
import 'package:whot/components/buttons.dart';
import 'package:whot/gameLogic/appProvider.dart';
import 'package:whot/handler/signInHandlers/emailSignInHandler.dart';
import 'package:whot/handler/signInHandlers/googleSignInHandler.dart';

showProfileSetup(BuildContext context, double height, double width,
    Data appData, bool google) {
  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              width: width * .5,
              height: height * .8,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: height * .02,
                    ),
                    TextInputContainer(
                      email: true,
                      width: width,
                      hint: 'Enter Username',
                      onChanged: (entry) {
                        appData.setUserName(entry);
                      },
                      color: Colors.grey[350],
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            minRadius: width * .09,
                            maxRadius: width * .09,
                            backgroundColor: Colors.brown,
                            backgroundImage: AssetImage(
                                'assets/profile${appData.avatar}.png'),
                          ),
                        ),
                        Positioned.fill(
                          left: width * .04,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: width * .18,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  child:
                                      Icon(Icons.arrow_left, size: width * .18),
                                  onTap: () {
                                    setState(() {
                                      appData.changeAvatar();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          right: width * .04,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        appData.changeAvatar();
                                      });
                                    },
                                    child: Icon(Icons.arrow_right,
                                        size: width * .18))),
                          ),
                        )
                      ],
                    ),
                    LongMenuButton(
                      height: height,
                      width: width,
                      appData: appData,
                      onTap: () {
                        (google
                                ? signInWithGoogle(appData)
                                : signUpWithEmail(appData))
                            .then((value) =>
                                Navigator.pushNamed(context, 'Profile Screen'));
                      },
                      label: 'Continue >>',
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      });
}
