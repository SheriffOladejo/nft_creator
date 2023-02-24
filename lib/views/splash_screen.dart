import 'package:flutter/material.dart';
import 'package:nft_creator/tictactoe/utilities/audio_player.dart';
import 'package:nft_creator/utilities/hex_color.dart';
import 'package:nft_creator/views/get_started.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        color: Colors.white,
        child: Center(
            child: Text("Logo", style: TextStyle(
              fontFamily: 'solata-bold',
              fontSize: 130,
              color: HexColor("#8051B4"),
            ),)
        ),
      ),
    );
  }

  Future init() async {
    AudioPlayer.toggleLoop();
    AudioPlayer.stopMusic();
    Future.delayed(const Duration(seconds: 2), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const GetStarted()));
    });
  }

  @override
  void initState(){
    super.initState();
    init();
  }

}

