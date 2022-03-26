//categories folder
import 'package:flutter/material.dart';

// String thinking = "assets/videos/Thinking";
// String daily = "assets/videos/Daily";
// String education = "assets/videos/Education";
// String movement = "assets/videos/Movement";
// String seated = "assets/videos/Seated";
String logo = "assets/images/logo.png";
// String thinking1stVid = "$thinking/Self Value.mp4";
// "Conscious calming connecting mediation.mp4"
// "Quick wealth.mp4"
// "Empowering mediation.mp4"
// "Overcoming struggles.mp4"
// "Confident can do.mp4"

// String movement1stVid = "$movement/Movement_Running_Meditation.mp4";
// String seated1stVid = "$seated/Charkra_Clearing_Meditation.mp4";
// String education1stVid = "$education/Letting_go_of_Negativity.mp4";
// String daily1stVid = "$daily/Evening_mediation.mp4";

TextStyle titleTextStyle(
    {double fontSize = 25,
    Color color = Colors.black,
    required BuildContext context}) {
  return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).textTheme.bodyText1!.color,
      letterSpacing: 1.8);
}

bool playInBackground = true;
bool downloadOnlyOverWifi = false;
