import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whot/screen/gameScreen.dart';

import 'gameLogic/appProvider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Data(),
      child: MaterialApp(
        home: GameScreen(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
