import 'package:flutter/material.dart';

class TextInputContainer extends StatelessWidget {
  const TextInputContainer({
    Key key,
    @required this.width,@required this.hint,
  }) : super(key: key);

  final double width;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(vertical:width*.01),
        width: width * .4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40)),
        child: TextField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(),
              fillColor: Colors.white.withOpacity(.4),
              filled: true,
              focusColor: Colors.blue,
              border: InputBorder.none),
        ),
      ),
    );
  }
}
