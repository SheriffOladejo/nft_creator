import 'dart:ui';

import 'package:on_image_matrix/on_image_matrix.dart';

class Constants {
  static final List<ColorFilter> filters = [
    OnImageFilters.normal,
    OnImageFilters.blueSky,
    OnImageFilters.gray,
    OnImageFilters.grayHighBrightness,
    OnImageFilters.grayHighExposure,
    OnImageFilters.grayLowBrightness,
    OnImageFilters.hueRotateWith2,
    OnImageFilters.invert,
    OnImageFilters.kodachrome,
    OnImageFilters.protanomaly,
    OnImageFilters.random,
    OnImageFilters.sepia,
    OnImageFilters.sepium,
    OnImageFilters.technicolor,
    OnImageFilters.vintage,
  ];

  static final List<String> filtersNames = [
    'normal',
    'blueSky',
    'gray',
    'grayHighBrightness',
    'grayHighExposure',
    'grayLowBrightness',
    'hueRotateWith2',
    'invert',
    'kodachrome',
    'protanomaly',
    'random',
    'sepia',
    'sepium',
    'technicolor',
    'vintage',
  ];

  static const String newsai_key = "6b24784a7c07473b9b06baf6a95967a6";
}