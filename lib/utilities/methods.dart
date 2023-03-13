import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nft_creator/utilities/hex_color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

Widget loadingPage(){
  return const Center(
    child: CircularProgressIndicator(

    ),
  );
}

Route slideLeft(Widget next) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => next,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Future showToast(String message){
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0
  );
}

Future<String> getStorageDirectory() async {
  if (Platform.isAndroid) {

    String dir = (await getExternalStorageDirectory()).path;

    File directory = File(dir);
    bool exists = await directory.exists();
    if (!exists) {
      directory.create();
    }
    return dir;  // OR return "/storage/emulated/0/Download";
  }
  else {
    String dir = (await getApplicationDocumentsDirectory()).path;

    File directory = File(dir);
    bool exists = await directory.exists();
    if (!exists) {
      directory.create();
    }
    return dir;  // O
  }
}

OutlineInputBorder focusedBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: HexColor("#E6DCF0"),
    ),
    borderRadius: BorderRadius.circular(16),
  );
}

OutlineInputBorder disabledBorder() {
  return OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.circular(16),
  );
}

OutlineInputBorder errorBorder() {
  return OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.red,
    ),
    borderRadius: BorderRadius.circular(16),
  );
}

OutlineInputBorder enabledBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: HexColor("#E6DCF0"),
    ),
    borderRadius: BorderRadius.circular(16),
  );
}
