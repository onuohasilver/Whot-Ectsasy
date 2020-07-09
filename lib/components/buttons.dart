import 'package:flutter/material.dart';
import 'package:whot/gameLogic/appProvider.dart';

//Returns a Brown Inkwell material Button
class LongMenuButton extends StatelessWidget {
  const LongMenuButton({
    Key key,
    @required this.height,
    @required this.width,
    @required this.appData,
    @required this.onTap,
    @required this.label,
    this.color
  }) : super(key: key);

  final double height;
  final double width;
  final dynamic appData;
  final Color color;
  final Function onTap;
  final String label;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height * .12,
        width: width * .30,
        child: Material(
          elevation: 25,
          borderRadius: BorderRadius.circular(15),
          color: color??Colors.brown[900],
          child: InkWell(
              borderRadius: BorderRadius.circular(15),
              splashColor: Colors.yellow[800],
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: height*.035,
                      fontWeight: FontWeight.w600),
                ),
              ),
              onTap: onTap),
        ),
      ),
    );
  }
}

///A small white button with an Icon as a child
///recieves tap gestures
class SmallMenuButton extends StatelessWidget {
  const SmallMenuButton({
    Key key,
    @required this.height,
    @required this.width,
    @required this.onTap,
    @required this.icon,
  }) : super(key: key);

  final double height;
  final double width;
  final Function onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height * .1,
        width: width * .06,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            splashColor: Colors.brown,
            borderRadius: BorderRadius.circular(10),
            child: Icon(icon),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
