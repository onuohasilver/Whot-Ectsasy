import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class CardBuilder extends StatelessWidget {
  const CardBuilder(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.number,
      @required this.shape})
      : super(key: key);

  final double height;
  final double width;
  final int number;
  final String shape;

  @override
  Widget build(BuildContext context) {
    Map<String, IconData> shapes = {
      'square': FontAwesomeIcons.squareFull,
      'cross': FontAwesomeIcons.cross,
      'star': Icons.star,
      'triangle': FontAwesomeIcons.angleUp,
      'circle': Icons.brightness_1
    };
    

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: height * .2,
        width: width * .1,
        child: Material(
          elevation: 8,
          borderOnForeground: true,
          borderRadius: BorderRadius.circular(12),
          color: Colors.purple[50],
          child: InkWell(
            onTap: () {},
            splashColor: Colors.red[800],
            borderRadius: BorderRadius.circular(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MiniColumn(
                  height: height,
                  top: true,
                  shape: shape,
                  number: number,
                ),
                FaIcon(shapes[shape],size: height*.12,color:Colors.red[800]),
                MiniColumn(
                  height: height,
                  top: false,
                  shape: shape,
                  number: number,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MiniColumn extends StatelessWidget {
  const MiniColumn(
      {Key key,
      @required this.height,
      @required this.top,
      @required this.number,
      @required this.shape, this.shapes})
      : super(key: key);

  final double height;
  final bool top;
  final String shape;
  final Map shapes;
  final int number;

  @override
  Widget build(BuildContext context) {
    Map<String, IconData> shapes = {
      'square': FontAwesomeIcons.squareFull,
      'cross': FontAwesomeIcons.cross,
      'star': Icons.star,
      'triangle': FontAwesomeIcons.angleUp,
      'circle': Icons.brightness_1
    };
    return Padding(
      padding: top
          ? EdgeInsets.fromLTRB(5, 3, 0, 0)
          : EdgeInsets.fromLTRB(0, 0, 5, 3),
      child: Row(
        mainAxisAlignment:
            top ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                number.toString(),
                style: GoogleFonts.tienne(
                    fontSize: height * .03,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[900]),
              ),
              FaIcon(
                shapes[shape],
                size: height * .02,
                color: Colors.red[900],
              ),
            ],
          )
        ],
      ),
    );
  }
}
