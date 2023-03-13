import 'dart:io';

import 'package:nft_creator/models/nft_art.dart';
import 'package:nft_creator/models/wallet.dart';
import 'package:nft_creator/utilities/methods.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  DbHelper._createInstance();

  String db_name = "com.khunju.nft_creator.db";

  static Database _database;
  static DbHelper helper;

  String art_table = "art_table";
  String col_art_id = "id";
  String col_filter_index = "filter_index";
  String col_image = "image";
  String col_color = "color";
  String col_saturation = "saturation";
  String col_exposure = "exposure";
  String col_visibility = "visibility";
  String col_contrast = "contrast";
  String col_source = "source";

  String wallet_table = "wallet_table";
  String col_wallet_id = "id";
  String col_wallet_address = "address";
  String col_wallet_password = "password";
  String col_wallet_seed = "seed";

  Future createDb(Database db, int version) async {
    String create_art_table = "create table $art_table ("
        "$col_art_id integer primary key autoincrement, "
        "$col_filter_index integer, "
        "$col_source text, "
        "$col_image text, "
        "$col_color text, "
        "$col_saturation double, "
        "$col_exposure double, "
        "$col_visibility double, "
        "$col_contrast double)";

    String create_wallet_table = "create table $wallet_table ("
        "$col_wallet_id integer primary key autoincrement,"
        "$col_wallet_address text,"
        "$col_wallet_password text,"
        "$col_wallet_seed text)";

    await db.execute(create_wallet_table);
    await db.execute(create_art_table);
  }

  factory DbHelper(){
    helper ??= DbHelper._createInstance();
    return helper;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async{
    final db_path = await getDatabasesPath();
    final path = join(db_path, db_name);
    return await openDatabase(path, version: 1, onCreate: createDb);
  }

  // Art and NFT operations

  Future<bool> saveArt(NFTArt art) async {
    // if (art.from == 'user') {
    //   File file = File(art.image);
    //   var newFile = await file.writeAsBytes(/* image bytes*/);
    //   await newFile.create();
    // }

    Database db = await database;
    String query = "insert into $art_table ($col_filter_index, $col_image, $col_color, "
        "$col_saturation, $col_exposure, $col_visibility, $col_contrast, $col_source) values ("
        "'${art.filter_index}', '${art.image}', '${art.color}', '${art.saturation}', "
        "'${art.exposure}', '${art.visibility}', '${art.contrast}', '${art.from}')";
    try {
      print("db_helper.saveArt query: $query");
      await db.execute(query);
      return true;
    }
    catch (e) {
      print("db_helper.saveArt error: ${e.toString()}");
      return false;
    }
  }

  Future<bool> deleteArt(NFTArt art) async {
    Database db = await database;
    String query = "delete from $art_table where $col_art_id = ${art.id}";
    try {
      await db.execute(query);
      return true;
    }
    catch (e) {
      print("db_helper.deleteArt error: ${e.toString()}");
      return false;
    }
  }

  Future<bool> updateArt(NFTArt art) async {
    Database db = await database;
    String query = "update $art_table set "
        "$col_filter_index = ${art.filter_index}, "
        "$col_image = '${art.image}', "
        "$col_color = '${art.color}', "
        "$col_saturation = ${art.saturation}, "
        "$col_exposure = ${art.exposure}, "
        "$col_visibility = ${art.visibility}, "
        "$col_contrast = ${art.contrast} where $col_art_id = ${art.id}";
    try {
      print("db_helper.updateArt query: ${query.toString()}");
      await db.execute(query);
      return true;
    }
    catch (e) {
      print("db_helper.updateArt error: ${e.toString()}");
      return false;
    }
  }

  Future<List<NFTArt>> getArts() async {
    List<NFTArt> arts = [];
    Database db = await database;
    String query = "select * from $art_table";
    List<Map<String, Object>> result = await db.rawQuery(query);
    for (int i = 0; i < result.length; i++) {
      NFTArt art = NFTArt(
          id: int.parse(result[i][col_art_id].toString()),
          filter_index: result[i][col_filter_index].toString() == "null" ? 0 : int.parse(result[i][col_filter_index].toString()),
          image: result[i][col_image],
          color: result[i][col_color]
      );
      art.from = result[i][col_source].toString();
      art.contrast = double.parse(result[i][col_contrast].toString());
      art.visibility = double.parse(result[i][col_visibility].toString());
      art.saturation = double.parse(result[i][col_saturation].toString());
      art.exposure = double.parse(result[i][col_exposure].toString());
      arts.add(art);
    }
    return arts;
  }

  // Wallet opertations
  Future<bool> saveWallet(Wallet wallet) async {
    Database db = await database;
    String query = "insert into $wallet_table ($col_wallet_address, $col_wallet_password, "
        "$col_wallet_seed) values ('${wallet.address}', '${wallet.password}', "
        "'${wallet.seed}')";
    try {
      await db.execute(query);
      return true;
    }
    catch(e) {
      print("db_helper.saveWallet error: ${e.toString()}");
      showToast("Wallet not saved");
      return false;
    }
  }

  Future<bool> deleteWallet(Wallet wallet) async {
    Database db = await database;
    String query = "delete from $wallet_table where $col_wallet_id = ${wallet.id}";
    try {
      await db.execute(query);
      return true;
    }
    catch(e) {
      print("db_helper.deleteWallet error: ${e.toString()}");
      showToast("Wallet not deleted");
      return false;
    }
  }

  Future<List<Wallet>> getWallets() async {
    List<Wallet> wallets = [];
    Database db = await database;
    String query = "select * from $wallet_table";
    List<Map<String, Object>> result = await db.rawQuery(query);
    for (int i = 0; i < result.length; i++) {
      wallets.add(
          Wallet(
              id: int.parse(result[i][col_wallet_id].toString()),
              seed: result[i][col_wallet_seed].toString(),
              password: result[i][col_wallet_password].toString(),
              address: result[i][col_wallet_address].toString()
          )
      );
    }
    return wallets;
  }

  // Future<void> backupWallets() async {
  //   List<Wallet> wallets = await getWallets();
  //   for (int i = 0; i < wallets.length; i++) {
  //     DatabaseReference ref = FirebaseDatabase.instance.ref().child("backups/${wallets[i].address}");
  //     await ref.set({
  //       "id": wallets[i].id,
  //       "address": wallets[i].address,
  //       "seed": wallets[i].seed,
  //       "password": wallets[i].password,
  //     });
  //   }
  // }
  //
  // Future<bool> recoverWallet(Wallet wallet) async {
  //   final snapshot = await FirebaseDatabase.instance.ref().child('backups/${wallet.address}').get();
  //   print("db_helper.recoverWallet result: ${snapshot.value.toString()}");
  //   final map = snapshot.value;
  //
  //   if (map == null) {
  //     showToast("Wallet not found");
  //     return false;
  //   }
  //   else {
  //     Wallet w;
  //     Map<Object, Object> m = map;
  //     w = Wallet(
  //       id: m["id"],
  //       address: m["address"],
  //       seed: m["seed"],
  //       password: m["password"],
  //     );
  //     if (w.password != wallet.password) {
  //       showToast("Incorrect wallet password");
  //       return false;
  //     }
  //     else {
  //       await saveWallet(w);
  //       //showToast("Wallet saved");
  //       return true;
  //     }
  //   }
  // }

}