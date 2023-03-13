import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nft_creator/adapters/nft_adapter.dart';
import 'package:nft_creator/models/nft_art.dart';
import 'package:nft_creator/tictactoe/utilities/audio_player.dart';
import 'package:nft_creator/utilities/hex_color.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:nft_creator/utilities/methods.dart';
import 'package:nft_creator/views/art_board.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CreateNFT extends StatefulWidget {
  const CreateNFT({Key key}) : super(key: key);

  @override
  State<CreateNFT> createState() => _CreateNFTState();

}

class _CreateNFTState extends State<CreateNFT> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
          overlayOpacity: 0.0,
          backgroundColor: HexColor("#8051B4"),
          children: [
            SpeedDialChild(
              child: const Icon(Icons.camera_alt),
              label: 'Camera',
              backgroundColor: Colors.white,
              onTap: () async {
                final ImagePicker _picker = ImagePicker();
                final XFile image = await _picker.pickImage(source: ImageSource.camera);
                File file = File(image.path);
                openArtBoard(file, context);
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.image),
              label: 'Gallery',
              backgroundColor: Colors.white,
              onTap: () async {
                final ImagePicker _picker = ImagePicker();
                final XFile image = await _picker.pickImage(source: ImageSource.gallery);
                File file = File(image.path);
                print("create_nft.build selectImage: path is ${file.path}");
                openArtBoard(file, context);
              },
            ),
          ],
          child: const Icon(Icons.add, color: Colors.white,)),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        leadingWidth: 0,
        title: const Text(
            "Create an NFT from scratch or choose\nfrom the templates",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'solata-bold'
            )
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Tribute NFTs", style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'solata-bold',
              ),),
              Container(height: 10,),
              CarouselSlider(
                items: tributeNfts(),
                options: CarouselOptions(
                  viewportFraction: 0.45,
                  padEnds: false,
                  enableInfiniteScroll: false,
                ),
              ),
              Container(height: 10,),
              const Text("The bull society", style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'solata-bold',
              ),),
              Container(height: 10,),
              CarouselSlider(
                items: bullSociety(),
                options: CarouselOptions(
                  viewportFraction: 0.45,
                  padEnds: false,
                  enableInfiniteScroll: false,
                ),
              ),
              Container(height: 10,),
              const Text("Bored apes", style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'solata-bold',
              ),),
              Container(height: 10,),
              CarouselSlider(
                items: boredApes(),
                options: CarouselOptions(
                  viewportFraction: 0.45,
                  padEnds: false,
                  enableInfiniteScroll: false,
                ),
              ),
              Container(height: 10,),
            ],
          ),
        ),
      ),
    );
  }

  void openArtBoard(File image, BuildContext context) async {
    if (image == null) return;

    String path = await getStorageDirectory();

    DateTime date = DateTime.now();
    String datetime = DateFormat("dd-MM-yyyy HH:mm:ss").format(date);

    await image.copy('$path/$datetime.png');
    String image_path = '$path/$datetime.png';

    NFTArt art = NFTArt(
      image: image_path,
      color: "#E88BD4",
    );
    Navigator.push(context, MaterialPageRoute(builder: (context) => ArtBoard(art: art, from: "user", isUpdating: false,)));
  }

  List<Widget> tributeNfts() {

    return [
      NFTAdapter(
        art: NFTArt(
          image: "assets/images/tribute1.png",
          color: "#E88BD4"
        ),
      ),
      NFTAdapter(
        art: NFTArt(
            image: "assets/images/tribute2.png",
            color: "#BDEBE8"
        ),
      ),
      NFTAdapter(
        art: NFTArt(
            image: "assets/images/tribute3.png",
            color: "#00FF57"
        ),
      ),
      NFTAdapter(
        art: NFTArt(
            image: "assets/images/tribute4.png",
            color: "#E8A78B"
        ),
      ),
    ];
  }

  List<Widget> boredApes() {

    return [
      NFTAdapter(
        art: NFTArt(
            image: "assets/images/ape1.png",
            color: "#006881"
        ),
      ),
      NFTAdapter(
        art: NFTArt(
            image: "assets/images/ape2.png",
            color: "#810000"
        ),
      ),
      NFTAdapter(
        art: NFTArt(
            image: "assets/images/ape3.png",
            color: "#BFB6B6"
        ),
      ),
      NFTAdapter(
        art: NFTArt(
            image: "assets/images/ape4.png",
            color: "#211F89"
        ),
      ),
    ];
  }

  List<Widget> bullSociety() {

    return [
      NFTAdapter(
        art: NFTArt(
            image: "assets/images/bull1.png",
            color: "#000000"
        ),
      ),
      NFTAdapter(
        art: NFTArt(
            image: "assets/images/bull2.png",
            color: "#A027EA"
        ),
      ),
      NFTAdapter(
        art: NFTArt(
            image: "assets/images/bull3.png",
            color: "#369C26"
        ),
      ),
      NFTAdapter(
        art: NFTArt(
            image: "assets/images/bull4.png",
            color: "#E6EA27"
        ),
      ),
    ];
  }

  @override
  void initState() {
    AudioPlayer.toggleLoop();
    AudioPlayer.stopMusic();
    super.initState();
  }

}
