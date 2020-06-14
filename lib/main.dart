import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:whot/screen/startGame.dart';

import 'gameLogic/appProvider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Data(),
      child: MaterialApp(
        home: StartGame(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
