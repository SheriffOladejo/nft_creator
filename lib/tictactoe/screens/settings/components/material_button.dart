import 'package:flutter/material.dart';
import 'package:nft_creator/tictactoe/constants.dart';

class MyMaterialButton extends StatelessWidget {
  final int index;
  final Icon icon;
  final Function() onPressed;

  const MyMaterialButton({this.index, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 24.0,
      shape: const CircleBorder(),
      color: kBackgroundColor,
      disabledColor: const Color(0xFF5d5e60),
      disabledTextColor: kTextColor,
      child: icon,
      onPressed: onPressed,
    );
  }
}
