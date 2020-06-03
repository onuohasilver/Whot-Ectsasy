import 'package:flutter/material.dart';

class CardBuilder extends StatelessWidget {
  const CardBuilder({
    Key key,
    @required this.height,
    @required this.width,
    @required this.number,
    @required this.shape
  }) : super(key: key);

  final double height;
  final double width;
  final int number;
  final Widget shape;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * .4,
      width: width * .14,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MiniColumn(height: height,top:true,shape:shape,number: number,),
              Icon(Icons.brightness_1,
                  color: Colors.red[900], size: height * .16),
              MiniColumn(height: height,top:false,shape: shape,number: number,),
            ],
          ),
        ),
      ),
    );
  }
}

class MiniColumn extends StatelessWidget {
  const MiniColumn({
    Key key,
    @required this.height,
    @required this.top,
    @required this.number,
    @required this.shape
  }) : super(key: key);

  final double height;
  final bool top;
  final Widget shape;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: top?EdgeInsets.fromLTRB(3,3,0,0):EdgeInsets.fromLTRB(0,0,3,3),
      child: Row(
        mainAxisAlignment:top?MainAxisAlignment.start:MainAxisAlignment.end,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                number.toString(),
                style: TextStyle(
                    fontSize: height * .04,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[900]),
              ),
              Icon(
                Icons.brightness_1,
                size: height * .05,
                color: Colors.red[900],
              ),
            ],
          )
        ],
      ),
    );
  }
}
