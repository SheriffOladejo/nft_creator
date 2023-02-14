import 'package:flutter/material.dart';
import 'package:nft_creator/utils/hex_color.dart';
import 'package:nft_creator/utils/methods.dart';
import 'package:nft_creator/views/import_wallet.dart';

class GetStarted extends StatefulWidget {
  
  const GetStarted({Key key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
  
}

class _GetStartedState extends State<GetStarted> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_get_started.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 120,),
            const Text("Become a creator", style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontFamily: 'solata-bold',
            ),),
            Container(height: 20,),
            const Padding(
              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
              child: Text("Create artistic NFT works using the best templates from "
                  "amazing creators",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'solata-medium',
                  fontSize: 14
                ),
                textAlign: TextAlign.center
              ),
            ),
            Image.asset("assets/images/monkey.gif"),
            const Spacer(),
            Container(
              width: 220,
              margin: const EdgeInsets.only(bottom: 40,),
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(slideLeft(const ImportWallet()));
                },
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                color: HexColor("#8051B4"),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Get started",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'solata-bold'
                      ),
                    ),
                    Container(width: 5,),
                    Image.asset("assets/images/login.png", width: 20, height: 20,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  
}
