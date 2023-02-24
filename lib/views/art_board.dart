import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nft_creator/adapters/filter_adapter.dart';
import 'package:nft_creator/models/nft_art.dart';
import 'package:nft_creator/tictactoe/utilities/audio_player.dart';
import 'package:nft_creator/utilities/constants.dart';
import 'package:nft_creator/utilities/db_helper.dart';
import 'package:nft_creator/utilities/hex_color.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:nft_creator/utilities/methods.dart';
import 'package:nft_creator/views/home_screen.dart';
import 'package:on_image_matrix/on_image_matrix.dart';

class Stack<E> {
  final _list = <E>[];

  int size = 0;

  void push(E value) {
    size++;
    _list.add(value);
  }

  E pop(){
    size--;
    return _list.removeLast();
  }

  int getSize() {
    return size;
  }

  E get peek => _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}

class ArtBoard extends StatefulWidget {

  NFTArt art;
  String from;
  bool isUpdating;
  ArtBoard({
    this.art,
    this.from,
    this.isUpdating
  });

  @override
  State<ArtBoard> createState() => _ArtBoardState();

}

class _ArtBoardState extends State<ArtBoard> {

  int selected_widget = 0;

  Stack<NFTArt> backStack = Stack();
  Stack<NFTArt> forwardStack = Stack();


  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () async {
        DbHelper db_helper = DbHelper();
        await db_helper.deleteArt(widget.art);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Info"),
      content: const Text("This action is not reversible, do you want to delete this art?"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Colors.black,),
        ),
        title: const Text(
            "Art board",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'solata-bold'
            )
        ),
        actions: [
          widget.isUpdating ? GestureDetector(
            onTap: () {
              showAlertDialog(context);
            },
            child: const Icon(
              Icons.delete,
              color: Colors.black,
            ),
          ) : Container(),
          Container(width: 15,)
        ],
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
                          onTap: () {
                            forwardStack.push(widget.art);
                            if (backStack.isNotEmpty) {
                              NFTArt art = backStack.pop();
                              setState(() {
                                if (art != null) {
                                  widget.art = art;
                                  forwardStack.push(art);
                                }
                              });
                            }
                          },
                          child: Image.asset("assets/images/undo.png")
                        ),
                        Container(width: 10,),
                        GestureDetector(
                          onTap: () {
                            backStack.push(widget.art);
                            if (forwardStack.isNotEmpty) {
                              NFTArt art = forwardStack.pop();
                              if (forwardStack.isNotEmpty) {
                                art = forwardStack.pop();
                              }
                              if (art != null) {
                                widget.art = art;
                                backStack.push(art);
                              }
                              setState(() {

                              });
                            }
                          },
                          child: Image.asset("assets/images/redo.png")
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            DbHelper db_helper = DbHelper();
                            widget.art.from = widget.from;
                            if (widget.isUpdating) {
                              print("db_helper.getArts art id is ${widget.art.id}");
                              bool result = await db_helper.updateArt(widget.art);
                              if (result) {
                                showToast("Art updated");
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                              }
                            }
                            else {
                              bool result = await db_helper.saveArt(widget.art);
                              if (result) {
                                showToast("Art saved");
                                Navigator.pop(context);
                              }
                            }
                          },
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
                        colorFilter: widget.art.filter ?? OnImageMatrix.matrix(
                          exposure: widget.art.exposure,
                          brightnessAndContrast: widget.art.contrast,
                          saturation: widget.art.saturation,
                          visibility: widget.art.visibility,
                        ),
                        child: widget.from == "user" ?
                        Image.file(File(widget.art.image), height: 325, width: 325, fit: BoxFit.fitHeight,) :
                        Image.asset(widget.art.image, fit: BoxFit.fitHeight, height: 325, width: 325,)
                      ),
                    ),
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
                        selected_widget = 0;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selected_widget == 0 ? HexColor("#8051B4") : HexColor("#E6DCF0"),
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
                        selected_widget = 1;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: selected_widget == 1 ? HexColor("#8051B4") : HexColor("#E6DCF0"),
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
                        selected_widget = 2;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: selected_widget == 2 ? HexColor("#8051B4") : HexColor("#E6DCF0"),
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
                        selected_widget = 3;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: selected_widget == 3 ? HexColor("#8051B4") : HexColor("#E6DCF0"),
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
                        selected_widget = 4;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: selected_widget == 4 ? HexColor("#8051B4") : HexColor("#E6DCF0"),
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
                        selected_widget = 5;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: selected_widget == 5 ? HexColor("#8051B4") : HexColor("#E6DCF0"),
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
              const Divider(color: Colors.white,),
              Container(height: 5,),
              editingWidget()
            ],
          ),
        ),
      )
    );
  }

  void callback(ColorFilter filter, int index) {
    backStack.push(widget.art);
    setState(() {
      NFTArt art = NFTArt(
        id: widget.art.id,
        color: widget.art.color,
        image: widget.art.image,
        filter: widget.art.filter,
      );
      art.contrast = widget.art.contrast;
      art.saturation = widget.art.saturation;
      art.exposure = widget.art.exposure;
      art.visibility = widget.art.visibility;
      art.filter_index = index;
      art.filter = filter;
      widget.art = art;
    });
  }

  void changeColor(Color color) {
    backStack.push(widget.art);
    String hex = '#${color.value.toRadixString(16)}';
    setState(() {
      widget.art.filter = null;
      NFTArt art = NFTArt(
        id: widget.art.id,
        color: hex,
        image: widget.art.image,
        filter: widget.art.filter,
      );
      art.contrast = widget.art.contrast;
      art.saturation = widget.art.saturation;
      art.exposure = widget.art.exposure;
      art.visibility = widget.art.visibility;
      widget.art = art;
    });
  }

  Widget editingWidget() {
    switch (selected_widget) {
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
          value: widget.art.contrast,
          max: 5,
          min: -5,
          divisions: 20,
          onChanged: (double value) {
            setState(() {
              backStack.push(widget.art);
              widget.art.filter = null;
              NFTArt art = NFTArt(
                id: widget.art.id,
                color: widget.art.color,
                image: widget.art.image,
                filter: widget.art.filter,
              );
              art.contrast = value;
              art.saturation = widget.art.saturation;
              art.exposure = widget.art.exposure;
              art.visibility = widget.art.visibility;
              widget.art = art;
            });
          },
        );
        break;
      case 3:
        return Slider(
          value: widget.art.exposure,
          max: 5,
          divisions: 50,
          onChanged: (double value) {
            setState(() {
              backStack.push(widget.art);
              widget.art.filter = null;
              NFTArt art = NFTArt(
                id: widget.art.id,
                color: widget.art.color,
                image: widget.art.image,
                filter: widget.art.filter,
              );
              art.contrast = widget.art.contrast;
              art.saturation = widget.art.saturation;
              art.exposure = value;
              art.visibility = widget.art.visibility;
              widget.art = art;
            });
          },
        );
        break;
      case 4:
        return Slider(
          value: widget.art.visibility,
          max: 1,
          divisions: 10,
          onChanged: (double value) {
            setState(() {
              backStack.push(widget.art);
              widget.art.filter = null;
              NFTArt art = NFTArt(
                id: widget.art.id,
                color: widget.art.color,
                image: widget.art.image,
                filter: widget.art.filter,
              );
              art.contrast = widget.art.contrast;
              art.saturation = widget.art.saturation;
              art.exposure = widget.art.exposure;
              art.visibility = value;
              widget.art = art;
            });
          },
        );
        break;
      case 5:
        return Slider(
          value: widget.art.saturation,
          max: 5,
          divisions: 50,
          onChanged: (double value) {
            setState(() {
              backStack.push(widget.art);
              widget.art.filter = null;
              NFTArt art = NFTArt(
                id: widget.art.id,
                color: widget.art.color,
                image: widget.art.image,
                filter: widget.art.filter,
              );
              art.contrast = widget.art.contrast;
              art.saturation = value;
              art.exposure = widget.art.exposure;
              art.visibility = widget.art.visibility;
              widget.art = art;
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
    return SizedBox(
      height: 170,
      child: ListView.builder(
        itemCount: Constants.filters.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return FilterAdapter(
            callback: callback,
            art: widget.art,
            filter_name: Constants.filtersNames[index],
            filter: Constants.filters[index],
            from: widget.from,
            filter_index: index,
          );
      }),
    );
  }

  @override
  void initState() {
    AudioPlayer.toggleLoop();
    AudioPlayer.stopMusic();
    super.initState();
  }

}
