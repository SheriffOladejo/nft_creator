import 'package:flutter/material.dart';
import 'package:nft_creator/utils/hex_color.dart';
import 'package:nft_creator/views/create_nft.dart';
import 'package:nft_creator/views/crypto_news.dart';
import 'package:nft_creator/views/dashboard.dart';
import 'package:nft_creator/views/game.dart';
import 'package:nft_creator/views/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  static const List<Widget> widgetOptions = [
    DashBoard(),
    CryptoNews(),
    CreateNFT(),
    Game(),
    Settings()
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        backgroundColor: HexColor("#AA8BCD"),
        selectedItemColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: HexColor("#AA8BCD"),
            icon: IconButton(
              icon: Image.asset("assets/images/dashboard.png", color: Colors.white,),
              onPressed: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
            ),
            label: 'Dashboard'
          ),
          BottomNavigationBarItem(
              backgroundColor: HexColor("#AA8BCD"),
              icon: IconButton(
                icon: Image.asset("assets/images/news.png", color: Colors.white,),
                onPressed: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
              ),
              label: 'Crypto news'
          ),
          BottomNavigationBarItem(
              backgroundColor: HexColor("#AA8BCD"),
              icon: IconButton(
                icon: Image.asset("assets/images/create.png", color: Colors.white,),
                onPressed: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                },
              ),
              label: 'Create'
          ),
          BottomNavigationBarItem(
              backgroundColor: HexColor("#AA8BCD"),
              icon: IconButton(
                icon: Image.asset("assets/images/game.png", color: Colors.white,),
                onPressed: () {
                  setState(() {
                    selectedIndex = 3;
                  });
                },
              ),
              label: 'Games'
          ),
          BottomNavigationBarItem(
              backgroundColor: HexColor("#AA8BCD"),
              icon: IconButton(
                icon: Image.asset("assets/images/settings.png", color: Colors.white,),
                onPressed: () {
                  setState(() {
                    selectedIndex = 4;
                  });
                },
              ),
              label: 'Settings'
          ),
        ],
      ),
    );
  }

}
