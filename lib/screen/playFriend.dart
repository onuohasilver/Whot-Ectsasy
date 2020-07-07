import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whot/components/buttons.dart';
import 'package:whot/components/imageContainer/userWhiteCard.dart';
import 'package:whot/constants.dart';
import 'package:whot/gameLogic/appProvider.dart';

class PlayFriend extends StatefulWidget {
  @override
  _PlayFriendState createState() => _PlayFriendState();
}

class _PlayFriendState extends State<PlayFriend> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Data appData = Provider.of<Data>(context);
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
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        height: height * .6,
                        width: width * .2,
                        padding: EdgeInsets.symmetric(horizontal:width*.025),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(.5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                              
                                                          children:[ CircleAvatar(
                                maxRadius: width * .07,
                                 backgroundColor: Colors.brown
                              ),Align(alignment:Alignment.topRight,child: Container(height:height*.03,width:width*.02,child:Material(shape:CircleBorder(),color:Colors.green)))]
                            ),
                            SizedBox(height: height * .04),
                            Text('UserName'),
                            LongMenuButton(
                                height: height,
                                width: width,
                                appData: appData,
                                onTap: () {},
                                label: 'Challenge')
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
