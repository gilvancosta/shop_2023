import 'package:flutter/material.dart';

sealed class ConstantsFonts {
  static const String fontFamilyTheme = 'lato';
  static const String fontFamilyText = 'Anton';
}

sealed class ConstantsColors {
  static const primaryColor = Colors.purple;
  static const secondaryColor = Colors.deepOrange;
  static const brow = Color(0xFFB07B01);
  static const grey = Color(0xFF999999);
  static const greyLight = Color(0xFFE9E2E9);
  static const red = Color(0xFFEB1212);

  static const myCanvasColor = Color.fromRGBO(255, 254, 229, 1);
}

sealed class ConstantsImages {
  static const backgroundChair = 'assets/images/background_image_chair.jpg';
  static const imageLogo = 'assets/images/imgLogo.png';
  static const avatar = 'assets/images/avatar.png';
}
