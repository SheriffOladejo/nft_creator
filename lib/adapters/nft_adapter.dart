import 'package:flutter/material.dart';
import 'package:nft_creator/models/nft_art.dart';
import 'package:nft_creator/utils/hex_color.dart';

class NFTAdapter extends StatefulWidget {

  NFTArt art;
  NFTAdapter({
    this.art,
  });

  @override
  State<NFTAdapter> createState() => _NFTAdapterState();

}

class _NFTAdapterState extends State<NFTAdapter> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: HexColor(widget.art.color),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      alignment: Alignment.bottomCenter,
      child: Image.asset(widget.art.image),
    );
  }

}
