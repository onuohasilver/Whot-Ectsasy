import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whot/components/cardBuilder.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          color: Colors.purple[100],
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CardBuilder(
                      height: height,
                      width: width,
                      number:7,
                      shape: Icon(Icons.brightness_1),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
