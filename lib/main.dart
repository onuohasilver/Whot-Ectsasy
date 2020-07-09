import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whot/screen/startGame.dart';
import 'package:whot/screen/profilePage.dart';
import 'package:whot/screen/playFriend.dart';
import 'gameLogic/appProvider.dart';
import 'gameLogic/multiPlayerProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Data>(create: (_) => Data()),
         ChangeNotifierProvider<MultiPlayerData>(create: (_) => MultiPlayerData()),
      ],
      child: MaterialApp(
          initialRoute: 'Landing Screen',
          debugShowCheckedModeBanner: false,
          routes: {
            'Landing Screen': (context) => StartGame(),
            'Profile Screen': (context) => ProfilePage(),
            'Play A Friend': (context) => PlayFriend()
          }),
    ),
  );
}
