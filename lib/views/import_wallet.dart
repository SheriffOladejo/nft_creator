import 'package:flutter/material.dart';
import 'package:nft_creator/utils/hex_color.dart';
import 'package:nft_creator/utils/methods.dart';

class ImportWallet extends StatefulWidget {

  const ImportWallet({Key key}) : super(key: key);

  @override
  State<ImportWallet> createState() => _ImportWalletState();

}

class _ImportWalletState extends State<ImportWallet> {

  String selected_option = "12_words";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Import a wallet to hold your NFTs",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'solata-bold'
              )
            ),
            Container(height: 20,),
            Container(
              margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: HexColor("#E6DCF0"),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected_option = "12_words";
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected_option == "12_words" ? HexColor("#8051B4") : HexColor("#E6DCF0"),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text("12 words", style: TextStyle(
                        color: selected_option == "12_words" ? Colors.white : Colors.grey
                      ),),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected_option = "24_words";
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected_option == "24_words" ? HexColor("#8051B4") : HexColor("#E6DCF0"),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text("24 words", style: TextStyle(
                          color: selected_option == "24_words" ? Colors.white : Colors.grey
                      ),),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected_option = "private_key";
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected_option == "private_key" ? HexColor("#8051B4") : HexColor("#E6DCF0"),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text("Private key", style: TextStyle(
                          color: selected_option == "private_key" ? Colors.white : Colors.grey
                      ),),
                    ),
                  ),
                ],
              )
            ),
            Container(height: 20,),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                selected_option == "12_words" || selected_option == "24_words" ? "Seed" : "Private key",
                style: const TextStyle(color: Colors.black, fontFamily: 'solata-regular', fontSize: 14),
              ),
            ),
            Container(height: 10,),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                color: HexColor("#E6DCF0"),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  focusedBorder: focusedBorder(),
                  errorBorder: errorBorder(),
                  enabledBorder: enabledBorder(),
                  disabledBorder: disabledBorder(),
                ),
                minLines: 5,
                maxLines: 6,
              ),
            ),
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
                      "Connect wallet",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'solata-bold'
                      ),
                    ),
                    Container(width: 5,),
                    Image.asset("assets/images/link.png", width: 20, height: 20,),
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
