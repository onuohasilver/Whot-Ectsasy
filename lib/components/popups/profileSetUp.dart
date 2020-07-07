import 'package:flutter/material.dart';
import 'package:whot/components/InputControllers/textnput.dart';
import 'package:whot/gameLogic/appProvider.dart';

showProfileSetup(
    BuildContext context, double height, double width, Data appData) {
  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: width * .5,
                height: height * .7,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height * .05),
                        child: Text('Choose An Avatar'),
                      ),
                      Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              minRadius: width * .09,
                              maxRadius: width * .09,
                              backgroundColor: Colors.brown,
                              backgroundImage: AssetImage(
                                  'assets/profile${appData.avatar}.png'),
                            ),
                          ),
                          Positioned.fill(
                            left: width * .04,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: width * .18,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    child: Icon(Icons.arrow_left,
                                        size: width * .18),
                                    onTap: () {
                                      setState(() {
                                        appData.changeAvatar();
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            right: width * .04,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Material(
                                color: Colors.transparent,
                                  child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          appData.changeAvatar();
                                        });
                                      },
                                      child: Icon(Icons.arrow_right,
                                          size: width * .18))),
                            ),
                          )
                        ],
                      ),
                      TextInputContainer(
                          width: width, hint: 'Enter Username', email: true),
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      });
}
