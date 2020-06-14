import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whot/components/cardBuilder.dart';
import 'package:whot/constants.dart';
import 'package:whot/gameLogic/appProvider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Data appData = Provider.of<Data>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: kBackgroundImage,
          height: height,
          width: width,
          child: Row(
            children: <Widget>[
              Container(
                width: width * .4,
                height: height,
                color: Colors.white.withOpacity(.4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: [
                        CircleAvatar(
                          minRadius: height * .15,
                          backgroundColor: Colors.brown[800].withOpacity(.3),
                        ),
                        Positioned.fill(
                          top: 14,
                          bottom: 5,
                          child: CircleAvatar(
                            minRadius: height * .14,
                            backgroundColor: Colors.white.withOpacity(.7),
                            child: Icon(Icons.person, size: 60),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Silver KetchUp',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  width: width * .6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildWhotCenter(
                          Colors.white, height * 6, width * 3, false),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: width * .4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40)),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Enter Email',
                                hintStyle: TextStyle(),
                                fillColor: Colors.white.withOpacity(.4),
                                filled: true,
                                focusColor: Colors.blue,
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
