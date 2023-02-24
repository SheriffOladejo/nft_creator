import 'dart:ui';
import 'package:on_image_matrix/on_image_matrix.dart';

class NFTArt {
  int id = -1;
  ColorFilter filter;
  int filter_index;
  String image;
  String from;
  String color = "#AA8BCD";
  double exposure = 0.0;
  double saturation = 1.0;
  double visibility = 1.0;
  double contrast = 0.0;


  NFTArt({
    this.id,
    this.filter,
    this.filter_index,
    this.image,
    this.color,
  });

}