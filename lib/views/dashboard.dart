import 'package:flutter/material.dart';
import 'package:nft_creator/adapters/dashboard_nft_adapter.dart';
import 'package:nft_creator/adapters/nft_adapter.dart';
import 'package:nft_creator/models/nft_art.dart';
import 'package:nft_creator/utils/hex_color.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();

}

class _DashBoardState extends State<DashBoard> {

  List<NFTArt> projects = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: HexColor("#BFA8DA"),
            child: Row(
              children: [
                Image.asset("assets/images/account_icon.png"),
                Container(width: 15,),
                const Text("Account", style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'solata-bold',
                    fontSize: 16
                ),),
              ],
            )
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: const Text("My projects", style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'solata-bold'),
            ),
          ),
          Expanded(child: GridView.count(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 0.76,
            children: List.generate(projects.length, (index) {
              return DashboardNFTAdapter(art: projects[index]);
            }),
          ))
        ],
      ),
    );
  }

  void init() {
    for (int i = 0; i <= 5; i++) {
      projects.add(
        NFTArt(
          image: "assets/images/ape1.png",
          color: "#00FF57",
        )
      );
    }
    setState(() {

    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

}
