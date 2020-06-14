import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:whot/collection/cards.dart';
import 'package:whot/components/buttons.dart';
import 'package:whot/gameLogic/appProvider.dart';
import 'package:whot/screen/SinglePlayer.dart';
import 'package:whot/components/cardBuilder.dart';
import 'package:whot/screen/loginPage.dart';

class StartGame extends StatefulWidget {
  @override
  _StartGameState createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {
  @override
  void initState() {
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
    Data appData = Provider.of<Data>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildWhotCenter(Colors.white, height * 6, width * 3, false),
            LongMenuButton(
                height: height,
                width: width,
                label: 'SINGLE PLAYER',
                appData: appData,
                onTap: () {
                  appData.createPlayerCards();
                  appData
                      .playSelectedCard(getSingleCard(appData.entireCardDeck));

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
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SmallMenuButton(
                  height: height,
                  width: width,
                  icon: Icons.palette,
                  onTap: () {},
                ),
                SmallMenuButton(
              height: height,
              width: width,
              icon: Icons.indeterminate_check_box,
              onTap: () {},
            )
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
