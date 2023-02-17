import 'package:flutter/material.dart';
import 'package:nft_creator/tictactoe/constants.dart';

class MyTextButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const MyTextButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 13.0),
        elevation: 2.0,
        primary: kTextColor,
        textStyle: const TextStyle(
          fontSize: 16.0,
          fontFamily: 'Paytone',
        ),
      ),
      child: Text(text),
      onPressed: onPressed,
    );
  }
}
