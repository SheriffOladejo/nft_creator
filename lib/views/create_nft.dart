import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nft_creator/adapters/nft_adapter.dart';
import 'package:nft_creator/models/nft_art.dart';

class CreateNFT extends StatefulWidget {
  const CreateNFT({Key key}) : super(key: key);

  @override
  State<CreateNFT> createState() => _CreateNFTState();

}

class _CreateNFTState extends State<CreateNFT> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
            "Create an NFT from scratch or\nchoose from the templates",
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

}
