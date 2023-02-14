import 'package:flutter/material.dart';
import 'package:nft_creator/adapters/dashboard_nft_adapter.dart';
import 'package:nft_creator/adapters/news_adapter.dart';
import 'package:nft_creator/models/news.dart';
import 'package:nft_creator/models/nft_art.dart';
import 'package:nft_creator/utils/hex_color.dart';

class CryptoNews extends StatefulWidget {
  const CryptoNews({Key key}) : super(key: key);

  @override
  State<CryptoNews> createState() => _CryptoNewsState();
}

class _CryptoNewsState extends State<CryptoNews> {

  List<News> news_list = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: const Text("Crypto news", style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'solata-bold'),
            ),
          ),
          Expanded(child: ListView.builder(
            shrinkWrap: true,
            controller: ScrollController(),
            itemBuilder: (context, index) {
              News article = news_list[index];
              return NewsAdapter(news: article);
            },
            itemCount: news_list.length,
          )),
        ],
      ),
    );
  }

  void init() {
    for (int i = 0; i <= 5; i++) {
      news_list.add(
        News(
          image: "assets/images/news_sample.png",
          title: "Bank of China ex-advisor calls Beijing to reconsider crypto ban",
          text: "Huang Yiping, a former PBoC monetary policy adviser,"
              " believes that China should consider whether the"
              " ban on crypto trading is sustainable.",
          source_name: "FTX Street",
          url: "https://www.google.com",
          date: "13 Feb, 2023"
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
