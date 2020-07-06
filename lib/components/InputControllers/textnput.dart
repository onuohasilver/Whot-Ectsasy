import 'package:flutter/material.dart';
import 'package:whot/gameLogic/appProvider.dart';
import 'package:provider/provider.dart';

class TextInputContainer extends StatelessWidget {
  const TextInputContainer({
    Key key,
    @required this.width,
    @required this.hint,
    @required this.email,
  }) : super(key: key);

  final double width;
  final String hint;
  final bool email;

  @override
  Widget build(BuildContext context) {
    Data appData = Provider.of<Data>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: width * .01),
        width: width * .4,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
        child: TextField(
          textAlign: TextAlign.center,
          obscureText: !email,
          maxLength: email?null:8,
          maxLengthEnforced: !email,
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(),
              fillColor: Colors.white.withOpacity(.4),
              filled: true,
              focusColor: Colors.blue,
              border: InputBorder.none),
          onChanged: (entry) {
            email ? appData.updateEmail(entry) : appData.updatePassword(entry);
          },
        ),
      ),
    );
  }
}
