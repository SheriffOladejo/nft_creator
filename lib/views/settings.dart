import 'package:flutter/material.dart';
import 'package:nft_creator/tictactoe/utilities/audio_player.dart';
import 'package:nft_creator/utilities/methods.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();

}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
            "Settings",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'solata-bold'
            )
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                var url = "https://docs.google.com/document/d/e/2PACX-1vSJW_wy46dVo8Trpr_-u4zH8gcU95hu1XKeLSJ6SzdC_Gh7nuwYneels8tKkNDIk36FB4nUOlmjHKu8/pub";
                if(await canLaunch(url)){
                  await launch(url);
                }
                else{
                  showToast("Cannot launch URL");
                }
              },
              child: Row(
                children: [
                  Container(width: 10,),
                  Image.asset("assets/images/privacy_policy.png", color: Colors.black,),
                  Container(width: 10,),
                  const Text("Privacy policy", style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'solata-regular',
                      fontSize: 14
                  ),),
                  const Spacer(),
                  Image.asset("assets/images/export.png", color: Colors.black)
                ],
              ),
            ),
            Container(height: 3,),
            const Divider(
              color: Colors.white,
            ),
            Container(height: 3,),
            GestureDetector(
              onTap: () async {
                var url = "https://docs.google.com/document/d/e/2PACX-1vSxrzCTwZK95SYQWeu3mbJW5EDDBAVUmsfOunmJPbmqBF1aSU-9xJG7zi6q4gl25ECQDooZ6I3UQcqP/pub";
                if(await canLaunch(url)){
                  await launch(url);
                }
                else{
                  showToast("Cannot launch URL");
                }
              },
              child: Row(
                children: [
                  Container(width: 10,),
                  Image.asset("assets/images/terms_of_use.png", color: Colors.black,),
                  Container(width: 10,),
                  const Text("Terms of use", style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'solata-regular',
                      fontSize: 14
                  ),),
                  const Spacer(),
                  Image.asset("assets/images/export.png", color: Colors.black)
                ],
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    AudioPlayer.toggleLoop();
    AudioPlayer.stopMusic();
    super.initState();
  }

}
