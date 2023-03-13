import 'package:flutter/material.dart';
import 'package:nft_creator/models/wallet.dart';
import 'package:nft_creator/tictactoe/utilities/audio_player.dart';
import 'package:nft_creator/utilities/db_helper.dart';
import 'package:nft_creator/utilities/hex_color.dart';
import 'package:nft_creator/views/get_started.dart';
import 'package:nft_creator/views/home_screen.dart';

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
        color: Colors.black,
        child: Center(
          child: Image.asset("assets/images/logo.png", width: 100, height: 100,)
        ),
      ),
    );
  }

  Future init() async {
    AudioPlayer.toggleLoop();
    AudioPlayer.stopMusic();

    final db_helper = DbHelper();
    final List<Wallet> list = await db_helper.getWallets();
    if (list.isEmpty) {
      Future.delayed(const Duration(seconds: 2), () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const GetStarted()));
      });
    }
    else {
      Future.delayed(const Duration(seconds: 2), () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      });
    }
  }

  @override
  void initState(){
    super.initState();
    init();
  }

}

