import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:nft_creator/utilities/constants.dart';
import 'package:nft_creator/utilities/methods.dart';
import 'package:nft_creator/views/art_board.dart' as art_board;
import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';
import 'package:nft_creator/models/nft_art.dart';
import 'package:nft_creator/utilities/hex_color.dart';
import 'package:on_image_matrix/on_image_matrix.dart';

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
                child: OnImageMatrixWidget(
                    colorFilter: widget.art.filter ?? OnImageMatrix.matrix(
                      exposure: widget.art.exposure,
                      brightnessAndContrast: widget.art.contrast,
                      saturation: widget.art.saturation,
                      visibility: widget.art.visibility,
                    ),
                    child: widget.art.from == "user" ?
                    Image.file(File(widget.art.image), height: 130, fit: BoxFit.fitHeight,) :
                    Image.asset(widget.art.image, fit: BoxFit.fitHeight, height: 130)
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => art_board.ArtBoard(art: widget.art, from: widget.art.from, isUpdating: true,)));
                },
                child: Container(
                  height: 130,
                  alignment: Alignment.topRight,
                  width: 140,
                  child: Image.asset("assets/images/edit_nft.png"),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            alignment: Alignment.center,
            child: MaterialButton(
              onPressed: () async {
                ScreenshotController controller = ScreenshotController();

                controller.captureFromWidget(toExport()).then((value) async {
                  final result = await ImageGallerySaver.saveImage(
                      value,
                      quality: 100,
                      name: "${DateTime.now()}.png");
                  print(result);
                  showToast("Image saved");
                });
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

  void init() {
    // print("from:  " + widget.art.from.toString());
    // print("exposure:  " + widget.art.exposure.toString());
    // print("visibility:  " + widget.art.visibility.toString());
    // print("saturation:  " + widget.art.saturation.toString());
    // print("contrast:  " + widget.art.contrast.toString());
    // print("background:  " + widget.art.color.toString());
    // print("filter_index:  " + widget.art.filter_index.toString());
    // print("filter:  " + widget.art.filter.toString());
    if (widget.art.filter_index != 0) {
      widget.art.filter = Constants.filters[widget.art.filter_index];
    }
    setState(() {

    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  Widget toExport() {
    return Container(
      width: 325,
      height: 325,
      decoration: BoxDecoration(
        color: HexColor(widget.art.color),
      ),
      alignment: Alignment.bottomCenter,
      child: OnImageMatrixWidget(
          colorFilter: widget.art.filter ?? OnImageMatrix.matrix(
            exposure: widget.art.exposure,
            brightnessAndContrast: widget.art.contrast,
            saturation: widget.art.saturation,
            visibility: widget.art.visibility,
          ),
          child: widget.art.from == "user" ?
          Image.file(File(widget.art.image), height: 325, width: 325, fit: BoxFit.fitHeight,) :
          Image.asset(widget.art.image, fit: BoxFit.fitHeight, height: 325, width: 325,)
      ),
    );
  }

}
