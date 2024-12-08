import 'package:flutter/material.dart';

//global colors
class GColors {
  //main bg color
  static Color whiteShade3 = const Color(0xFFF1F6FF);

  //for buttons and exposed texts mostly
  static Color royalBlue = const Color(0xFF306BDD);

  //inactive nav bar
  static Color poloBlue = const Color(0xFF88a1c8);

  //for stand alone buttons
  static Color white = const Color(0xFFFDFDFD);

  //navigation bar
  static Color navBar = whiteShade3;

  //for rating
  static Color emptyRate = const Color(0xFF808080);
  static Color fullRate = Colors.yellow.shade700;

  //highlighted text when on royalBlue bg (used for price mostly)
  static Color black = const Color.fromARGB(255, 0, 0, 0);

  static Color cyan = const Color(0xFF00BCD4);
  static Color cyanShade6 = const Color(0xFF00ACC1);

  static Color approveColor = const Color(0xFF3dbe96);
  static Color denyColor = const Color(0xFF007afa);
  static Color suspendColor = const Color(0xFFffb630);

  //----------------------------------------------------------------

  //main logo gradient
  static List<Color> logoGradientColors = [
    const Color(0xFF4430DD),
    const Color(0xFF306BDD),
    const Color(0xFF308CDD),
    const Color(0xFF30B2DD)
  ];

  static LinearGradient logoGradient = LinearGradient(
    begin: Alignment.topLeft,
    colors: logoGradientColors,
  );

  static LinearGradient disabledLogoGradient = LinearGradient(
    begin: Alignment.topLeft,
    colors: [
      GColors.poloBlue,
      GColors.poloBlue,
    ],
  );

  static LinearGradient logoGradientReversed = LinearGradient(
    begin: Alignment.topLeft,
    colors: logoGradientColors.reversed.toList(),
  );

  //----------------------------------------------------------------

  //gradient for admin page
  static List<Color> adminGradientColors = [
    const Color.fromARGB(255, 79, 234, 255),
    Colors.cyan,
    Colors.cyan.shade600,
  ];

  static LinearGradient adminGradient = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: adminGradientColors,
  );

  static LinearGradient adminGradientReversed = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: adminGradientColors.reversed.toList(),
  );

  //----------------------------------------------------------------

  static List<Color> weddingCardGradient = const [
    Color(0xFFff758c),
    Color.fromARGB(255, 255, 65, 112),
    Color.fromARGB(255, 238, 28, 81),
    Color(0xFFff758c),
  ];

  static List<Color> personalCardGradient = const [
    Color(0xFFff7443),
    Color.fromARGB(255, 239, 134, 96),
    Color.fromARGB(255, 239, 94, 41),
    Color.fromARGB(255, 235, 104, 57),
  ];

  static List<Color> farmCardGradient = const [
    Color(0xFF1ab0b0),
    Color.fromARGB(255, 25, 172, 172),
    Color.fromARGB(255, 45, 195, 195),
    Color.fromARGB(255, 32, 148, 148),
  ];

  static List<Color> footballCardGradient = const [
    Color(0xFF8676fe),
    Color.fromARGB(255, 98, 83, 211),
    Color.fromARGB(255, 120, 108, 213),
    Color.fromARGB(255, 117, 103, 223),
  ];

  static List<Color> imageCardGradient = const [
    Colors.white,
    const Color.fromRGBO(245, 245, 245, 1),
    const Color.fromRGBO(238, 238, 238, 1),
  ];

  //scaffold, appbar and logo
  static Color scaffoldBg = const Color.fromARGB(255, 241, 246, 255);
  static Color appBarBg = const Color.fromARGB(255, 241, 246, 255);

  //for availability
  static Color greenShade3 = Colors.green.shade300;
  static Color redShade3 = Colors.red.shade300;
}
