import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      body: Container(
        decoration:kBackgroundImage,
        height:height,
        width: width,
        
      ),
    );
  }
}
