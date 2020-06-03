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
          color: Colors.brown[100],
          child: Column(
            children: <Widget>[
              Container(
                height: height * .3,
                width: width*.5,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    CardBuilder(
                      height: height,
                      width: width,
                      number: 7,
                      shape: 'star',
                    ),
                     CardBuilder(
                      height: height,
                      width: width,
                      number: 7,
                      shape: 'square',
                    ),
                     CardBuilder(
                      height: height,
                      width: width,
                      number: 7,
                      shape: 'circle',
                    ),
                     CardBuilder(
                      height: height,
                      width: width,
                      number: 14,
                      shape: 'cross',
                    ),
                    
                    CardBuilder(
                      height: height,
                      width: width,
                      number: 7,
                      shape: 'triangle',
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
