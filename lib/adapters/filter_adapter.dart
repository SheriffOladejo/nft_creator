import 'package:flutter/material.dart';
import 'package:nft_creator/models/nft_art.dart';
import 'package:nft_creator/utilities/hex_color.dart';
import 'package:on_image_matrix/on_image_matrix.dart';

class FilterAdapter extends StatefulWidget {

  Function callback;
  ColorFilter filter;
  String filter_name;
  NFTArt art;
  FilterAdapter({
    this.filter,
    this.filter_name,
    this.art,
    this.callback,
  });

  @override
  State<FilterAdapter> createState() => _FilterAdapterState();

}

class _FilterAdapterState extends State<FilterAdapter> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.callback(widget.filter);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.filter_name, style: const TextStyle(
              color: Colors.black,
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
                  child: Image.asset(widget.art.image, fit: BoxFit.fitHeight, height: 135)
              ),
            )
          ],
        ),
      ),
    );
  }

}
