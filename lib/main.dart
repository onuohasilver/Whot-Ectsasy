import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whot/screen/startGame.dart';
import 'package:whot/screen/profilePage.dart';
import 'gameLogic/appProvider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Data(),
      child: MaterialApp(
        initialRoute:'Landing Screen',
        debugShowCheckedModeBanner: false,
        routes:{
          'Landing Screen':(context)=>StartGame(),
          'Profile Screen':(context)=>ProfilePage()

        }
      ),
    ),
  );
}
