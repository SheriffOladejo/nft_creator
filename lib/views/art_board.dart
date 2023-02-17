import 'package:flutter/material.dart';
import 'package:nft_creator/adapters/filter_adapter.dart';
import 'package:nft_creator/models/nft_art.dart';
import 'package:nft_creator/utilities/hex_color.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:on_image_matrix/on_image_matrix.dart';
import 'dart:io';
import 'package:image/image.dart' as img;


class ArtBoard extends StatefulWidget {

  NFTArt art;
  ArtBoard({
    this.art
  });

  @override
  State<ArtBoard> createState() => _ArtBoardState();

}

class _ArtBoardState extends State<ArtBoard> {

  int selected = 0;

  double exposureVal = 0.0;
  double saturationVal = 1.0;
  double visibilityVal = 1.0;
  double contrastVal = -0.0;

  ColorFilter selected_filter;

  List<ColorFilter> filters = [
    OnImageFilters.normal,
    OnImageFilters.blueSky,
    OnImageFilters.gray,
    OnImageFilters.grayHighBrightness,
    OnImageFilters.grayHighExposure,
    OnImageFilters.grayLowBrightness,
    OnImageFilters.hueRotateWith2,
    OnImageFilters.invert,
    OnImageFilters.kodachrome,
    OnImageFilters.protanomaly,
    OnImageFilters.random,
    OnImageFilters.sepia,
    OnImageFilters.sepium,
    OnImageFilters.technicolor,
    OnImageFilters.vintage,
  ];

  List<String> filtersNames = [
    'normal',
    'blueSky',
    'gray',
    'grayHighBrightness',
    'grayHighExposure',
    'grayLowBrightness',
    'hueRotateWith2',
    'invert',
    'kodachrome',
    'protanomaly',
    'random',
    'sepia',
    'sepium',
    'technicolor',
    'vintage',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
            "Art board",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'solata-bold'
            )
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: HexColor("#AA8BCD"),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Image.asset("assets/images/undo.png")
                        ),
                        GestureDetector(
                            child: Image.asset("assets/images/save.png")
                        ),
                      ],
                    ),
                    Container(height: 15,),
                    Container(
                      decoration: BoxDecoration(
                        color: HexColor(widget.art.color),
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                      ),
                      alignment: Alignment.bottomCenter,
                      child: OnImageMatrixWidget(
                        colorFilter: selected_filter ?? OnImageMatrix.matrix(
                          exposure: exposureVal,
                          brightnessAndContrast: contrastVal,
                          saturation: saturationVal,
                          visibility: visibilityVal,
                        ),
                        child: Image.asset(widget.art.image, fit: BoxFit.fitHeight, height: 300, )
                      ),
                    )
                  ],
                ),
              ),
              Container(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 0;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selected == 0 ? HexColor("#8051B4") : HexColor("#E6DCF0"),
                        borderRadius: const BorderRadius.all(Radius.circular(5))
                      ),
                      height: 50,
                      width: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/bg.png"),
                          Container(height: 3,),
                          const Text("BG", style: TextStyle(
                            color: Colors.white,
                            fontSize: 8
                          ),)
                        ],
                      ),
                    ),
                  ),
                  Container(width: 5,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 1;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: selected == 1 ? HexColor("#8051B4") : HexColor("#E6DCF0"),
                          borderRadius: const BorderRadius.all(Radius.circular(5))
                      ),
                      height: 50,
                      width: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/filters.png"),
                          Container(height: 3,),
                          const Text("Filters", style: TextStyle(
                              color: Colors.white,
                              fontSize: 8
                          ),)
                        ],
                      ),
                    ),
                  ),
                  Container(width: 5,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 2;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: selected == 2 ? HexColor("#8051B4") : HexColor("#E6DCF0"),
                          borderRadius: const BorderRadius.all(Radius.circular(5))
                      ),
                      height: 50,
                      width: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/contrast.png", color: Colors.white, width: 16, height: 19,),
                          Container(height: 3,),
                          const Text("Contrast", style: TextStyle(
                              color: Colors.white,
                              fontSize: 8
                          ),)
                        ],
                      ),
                    ),
                  ),
                  Container(width: 5,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 3;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: selected == 3 ? HexColor("#8051B4") : HexColor("#E6DCF0"),
                          borderRadius: const BorderRadius.all(Radius.circular(5))
                      ),
                      height: 50,
                      width: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/exposure.png", color: Colors.white, width: 16, height: 19,),
                          Container(height: 3,),
                          const Text("Exposure", style: TextStyle(
                              color: Colors.white,
                              fontSize: 8
                          ),)
                        ],
                      ),
                    ),
                  ),
                  Container(width: 5,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 4;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: selected == 4 ? HexColor("#8051B4") : HexColor("#E6DCF0"),
                          borderRadius: const BorderRadius.all(Radius.circular(5))
                      ),
                      height: 50,
                      width: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/visibility.png", color: Colors.white, width: 16, height: 19,),
                          Container(height: 3,),
                          const Text("Visibility", style: TextStyle(
                              color: Colors.white,
                              fontSize: 8
                          ),)
                        ],
                      ),
                    ),
                  ),
                  Container(width: 5,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 5;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: selected == 5 ? HexColor("#8051B4") : HexColor("#E6DCF0"),
                          borderRadius: const BorderRadius.all(Radius.circular(5))
                      ),
                      height: 50,
                      width: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/saturation.png", color: Colors.white, width: 16, height: 19,),
                          Container(height: 3,),
                          const Text("Saturation", style: TextStyle(
                              color: Colors.white,
                              fontSize: 8
                          ),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(height: 5,),
              const Divider(color: Colors.black,),
              Container(height: 5,),
              editingWidget()
            ],
          ),
        ),
      )
    );
  }

  void callback(ColorFilter filter) {
    setState(() {
      selected_filter = filter;
    });
  }

  void changeColor(Color color) {
    String hex = '#${color.value.toRadixString(16)}';
    setState(() {
      selected_filter = null;
      widget.art.color = hex;
    });
  }

  Widget editingWidget() {
    switch (selected) {
      case 0:
        return ColorPicker(
          pickerColor: HexColor(widget.art.color),
          onColorChanged: changeColor
        );
        break;
      case 1:
        return filterWidget();
        break;
      case 2:
        return Slider(
          value: contrastVal,
          max: 5,
          min: -5,
          divisions: 20,
          onChanged: (double value) {
            setState(() {
              selected_filter = null;
              contrastVal = value;
            });
          },
        );
        break;
      case 3:
        return Slider(
          value: exposureVal,
          max: 5,
          divisions: 50,
          onChanged: (double value) {
            setState(() {
              selected_filter = null;
              exposureVal = value;
            });
          },
        );
        break;
      case 4:
        return Slider(
          value: visibilityVal,
          max: 1,
          divisions: 10,
          onChanged: (double value) {
            setState(() {
              selected_filter = null;
              visibilityVal = value;
            });
          },
        );
        break;
      case 5:
        return Slider(
          value: saturationVal,
          max: 5,
          divisions: 50,
          onChanged: (double value) {
            setState(() {
              selected_filter = null;
              saturationVal = value;
            });
          },
        );
        break;
      default:
        return Container();
        break;
    }
  }

  Widget filterWidget() {
    return Container(
      height: 170,
      child: ListView.builder(
        itemCount: filters.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return FilterAdapter(
            callback: callback,
            art: widget.art,
            filter_name: filtersNames[index],
            filter: filters[index],
          );
      }),
    );
  }

}
