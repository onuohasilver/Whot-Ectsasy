import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

///builds a card Object with the specified shape
///using Icons gotten from FontAwesome Icons as reference
///for the shape images
class CardBuilder extends StatelessWidget {
  const CardBuilder(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.number,
      @required this.shape,
      this.onTap,
      this.animation})
      : super(key: key);

  final double height;
  final double width;
  final int number;
  final String shape;
  final Function onTap;
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> shapes = {
      'square': FontAwesomeIcons.squareFull,
      'cross': FontAwesomeIcons.cross,
      'star': Icons.star,
      'triangle': FontAwesomeIcons.angleUp,
      'circle': Icons.brightness_1,
      'joker': buildWhotCenter(
        Colors.red[900],
        height * 2.5,
        width,
        false,
      ),
    };

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: height * .2,
        width: width * .12,
        child: Material(
          elevation: 18,
          borderOnForeground: true,
          borderRadius: BorderRadius.circular(12),
          color: Colors.brown[100],
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.red[800],
            borderRadius: BorderRadius.circular(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MiniColumn(
                  height: height,
                  top: true,
                  shape: shape,
                  number: number ?? '',
                ),
                shape == 'joker'
                    ? shapes[shape]
                    : FaIcon(shapes[shape],
                        size: height * .10, color: Colors.red[800]),
                MiniColumn(
                  height: height,
                  top: false,
                  shape: shape,
                  number: number ?? '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Creates a miniColumn of a number and Shape of the parsed card detail
class MiniColumn extends StatelessWidget {
  const MiniColumn(
      {Key key,
      @required this.height,
      @required this.top,
      @required this.number,
      @required this.shape,
      this.shapes})
      : super(key: key);

  final double height;
  final bool top;
  final String shape;
  final Map shapes;
  final int number;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> shapes = {
      'square': FontAwesomeIcons.squareFull,
      'cross': FontAwesomeIcons.cross,
      'star': Icons.star,
      'triangle': FontAwesomeIcons.angleUp,
      'circle': Icons.brightness_1,
      'joker': ''
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
                number?.toString() ?? '',
                style: GoogleFonts.tienne(
                    fontSize: height * .03,
                    fontWeight: FontWeight.bold,
                    color: number != 0 ? Colors.red[900] : Colors.transparent),
              ),
              shape == 'joker'
                  ? Container()
                  : FaIcon(shapes[shape],
                      size: height * .02,
                      color:
                          number != 0 ? Colors.red[900] : Colors.transparent),
            ],
          )
        ],
      ),
    );
  }
}

/// returns the back of a whot Card
class DummyCard extends StatelessWidget {
  final double height;
  final double width;
  final Function onTap;
  final int number;
  final String shape;
  final bool large;
  final Color color;

  const DummyCard(
      {Key key,
      this.height,
      this.width,
      this.onTap,
      this.large,
      this.color,
      this.number,
      this.shape})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: height * .1,
        width: width * .08,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
                colorFilter: ColorFilter.srgbToLinearGamma(),
                image: AssetImage('assets/bg.jpg'),
                fit: BoxFit.cover)),
        child: Material(
          elevation: (large ?? false) ? 8 : 15,
          borderRadius: BorderRadius.circular(12),
          color: (large ?? false) ? color : Colors.red[900].withOpacity(.6),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            splashColor: Colors.white,
            onTap: onTap,
            child: buildWhotCenter(Colors.white, height, width, large),
          ),
        ),
      ),
    );
  }
}

/// Create a Centered Whot Text
Center buildWhotCenter(
  Color color,
  double height,
  double width,
  bool large,
) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Whot',
          style: GoogleFonts.cookie(
              shadows:
                  large ? null : [Shadow(blurRadius: 23.0, color: Colors.black)],
              color: color,
              fontSize: large ? height * .03 : height * .034),
        ),
        Transform.rotate(
          angle: pi,
          child: Text(
            'Whot',
            style: GoogleFonts.cookie(
                shadows:
                    large ? null : [Shadow(blurRadius: 23.0, color: Colors.black)],
                color: color,
                fontSize: large ? height * .03 : height * .04),
          ),
        ),
      ],
    ),
  );
}
