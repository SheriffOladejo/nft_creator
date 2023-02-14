import 'package:flutter/material.dart';
import 'package:nft_creator/models/nft_art.dart';
import 'package:nft_creator/utils/hex_color.dart';

class DashboardNFTAdapter extends StatefulWidget {

  NFTArt art;
  DashboardNFTAdapter({
    this.art,
  });

  @override
  State<DashboardNFTAdapter> createState() => _DashboardNFTAdapterState();

}

class _DashboardNFTAdapterState extends State<DashboardNFTAdapter> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg_dashboard_nft.png")
        ),
      ),
      child: Column(
        children: [
          Container(height: 15,),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 32, right: 30, top: 15),
                color: HexColor(widget.art.color),
                child: Image.asset(widget.art.image, height: 130,)
              ),
              Container(
                height: 130,
                alignment: Alignment.topRight,
                width: 140,
                child: Image.asset("assets/images/edit_nft.png"),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            alignment: Alignment.center,
            child: MaterialButton(
              onPressed: () {

              },
              color: HexColor("#8051B4"),
              child:
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Export",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'solata-bold'
                    ),
                  ),
                  Container(width: 5,),
                  Image.asset("assets/images/export_btn.png", width: 20, height: 20,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}
