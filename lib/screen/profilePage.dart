import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whot/components/buttons.dart';
import 'package:whot/gameLogic/appProvider.dart';
import 'package:whot/constants.dart';
import 'dart:ui' as ui;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Data appData = Provider.of<Data>(context);
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: kBackgroundImage,
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Row(
            children: <Widget>[
              Container(
                  width: width * .4,
                  height: height,
                  color: Colors.white.withOpacity(.4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              minRadius: width * .09,
                              maxRadius: width * .09,
                              backgroundColor: Colors.brown,
                            ),
                          ),
                          Positioned.fill(
                            top: height * .04,
                            left: width * .009,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child:
                                    Icon(Icons.arrow_left, size: width * .15)),
                          ),
                          Positioned.fill(
                            top: height * .04,
                            right: width * .009,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.arrow_right, size: width * .15),
                            ),
                          )
                        ],
                      ),
                      Text(
                        'Hi!',
                        style: GoogleFonts.poppins(
                            fontSize: width * .02, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Onuoha Silver',
                        style: GoogleFonts.poppins(
                            fontSize: width * .03, fontWeight: FontWeight.w600),
                      )
                    ],
                  )),
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
                        onTap: () {},
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
