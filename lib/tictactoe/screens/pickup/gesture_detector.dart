import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nft_creator/tictactoe/constants.dart';
import 'package:nft_creator/tictactoe/models/responsive_ui.dart';

class MyGestureDetector extends StatelessWidget {
  final Color containerColor;
  final String text;
  final Function() onTapFunction;

  const MyGestureDetector({this.onTapFunction, this.containerColor, this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTapFunction,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(28.0),
            ),
            child: _buildContainerText(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContainerText(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: text == 'X'
            ? kXTextStyle.copyWith(fontSize: ResponsiveUI.getFontSize(170.0))
            : kOTextStyle.copyWith(
                fontSize: ResponsiveUI.getFontSize(170.0),
              ),
      ),
    );
  }
}
