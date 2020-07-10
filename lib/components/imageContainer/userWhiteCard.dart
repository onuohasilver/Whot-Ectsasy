import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whot/gameLogic/multiPlayerProvider.dart';

///Creates a white transparent container with the current users
///details and a routing to the profile page
class UserWhiteCard extends StatelessWidget {
  const UserWhiteCard({
    Key key,
    @required this.width,
    @required this.height,
    @required this.appData,
  }) : super(key: key);

  final double width;
  final double height;
  final MultiPlayerData appData;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width * .4,
        height: height,
        color: Colors.white.withOpacity(.4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Material(
                color: Colors.transparent,
                shape: CircleBorder(),
                elevation: 14,
                child: CircleAvatar(
                  minRadius: width * .09,
                  maxRadius: width * .09,
                  backgroundColor: Colors.brown,
                  backgroundImage:
                      AssetImage('assets/profile${appData.avatar}.png'),
                ),
              ),
            ),
            SizedBox(height: height * .05),
            Text(
              'Hi!',
              style: GoogleFonts.poppins(
                  fontSize: width * .02, fontWeight: FontWeight.w600),
            ),
            Text(
              appData.userName,
              style: GoogleFonts.poppins(
                  fontSize: width * .03, fontWeight: FontWeight.w600),
            )
          ],
        ));
  }
}
