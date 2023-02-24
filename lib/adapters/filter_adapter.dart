import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nft_creator/models/nft_art.dart';
import 'package:nft_creator/utilities/hex_color.dart';
import 'package:on_image_matrix/on_image_matrix.dart';

class FilterAdapter extends StatefulWidget {

  Function callback;
  ColorFilter filter;
  int filter_index;
  String filter_name;
  NFTArt art;
  String from;
  FilterAdapter({
    this.filter,
    this.filter_index,
    this.filter_name,
    this.art,
    this.callback,
    this.from,
  });

  @override
  State<FilterAdapter> createState() => _FilterAdapterState();

}

class _FilterAdapterState extends State<FilterAdapter> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.callback(widget.filter, widget.filter_index);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.filter_name, style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontFamily: 'solata-bold',
            ),),
            Container(height: 5,),
            Container(
              width: 115,
              height: 135,
              decoration: BoxDecoration(
                color: HexColor(widget.art.color),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              alignment: Alignment.bottomCenter,
              child: OnImageMatrixWidget(
                  colorFilter: widget.filter,
                  child: widget.from == "user" ?
                  Image.file(File(widget.art.image), height: 325, width: 325, fit: BoxFit.fitHeight,) :
                  Image.asset(widget.art.image, fit: BoxFit.fitHeight, height: 325, width: 325,)
              ),
            )
          ],
        ),
      ),
    );
  }

}
