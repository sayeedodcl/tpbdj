import 'package:flutter/material.dart';

class Styles {
  Color bg = Color(0XFFF1F9FF);
  Color warning = Color(0XFFFF0000);
  Color success = Color(0XFF008000);
  Color wait = Color(0XFFFFFF00);
  Color buttoncolor = Color(0XFF016338);
  var historyjson;
  String demotext =
      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using , making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).';
  List<String> visitorss = ['1', '2', '3', '4', '5'];
  // ................Textstyle.............
  String apibarieartoken = '';
  String? numbers;
  String? relativename;
  int? relativesId;

  TextStyle normal(Color c) {
    return TextStyle(
        fontSize: 14, fontFamily: 'sf', fontWeight: FontWeight.w500, color: c);
  }

  TextStyle normal1(Color c) {
    return TextStyle(
        fontSize: 14, fontFamily: 'sf', fontWeight: FontWeight.w400, color: c);
  }

  TextStyle meduim(Color c) {
    return TextStyle(
        fontSize: 16, fontFamily: 'sf', fontWeight: FontWeight.w600, color: c);
  }

  TextStyle meduimbold(Color c) {
    return TextStyle(
        fontSize: 16, fontFamily: 'sf', fontWeight: FontWeight.w800, color: c);
  }

  TextStyle meduimbold1(Color c) {
    return TextStyle(
        fontSize: 16, fontFamily: 'sf', fontWeight: FontWeight.w500, color: c);
  }

  TextStyle title(Color c) {
    return TextStyle(
        fontSize: 20, fontFamily: 'sf', fontWeight: FontWeight.w700, color: c);
  }

  TextStyle titleultra(Color c) {
    return TextStyle(
        fontSize: 26, fontFamily: 'sf', fontWeight: FontWeight.w400, color: c);
  }

  TextStyle appbartitleultra(Color c) {
    return TextStyle(
        fontSize: 24, fontFamily: 'sf', fontWeight: FontWeight.w400, color: c);
  }

  TextStyle signupText(Color c) {
    return TextStyle(
        fontSize: 32, fontFamily: 'sf', fontWeight: FontWeight.w400, color: c);
  }

  TextStyle signupTextBold(Color c) {
    return TextStyle(
        fontSize: 35, fontFamily: 'sf', fontWeight: FontWeight.w700, color: c);
  }

  TextStyle placeholderstyle() {
    return TextStyle(
        fontSize: 16,
        fontFamily: 'sf',
        fontWeight: FontWeight.w400,
        color: Colors.black38);
  }

  TextStyle buttonText(Color c) {
    return TextStyle(
        fontSize: 26, fontFamily: 'sf', fontWeight: FontWeight.w400, color: c);
  }

  TextStyle newbutton(Color c, double d) {
    return TextStyle(
        fontSize: 18,
        fontFamily: 'sf',
        fontWeight: FontWeight.w600,
        color: c,
        letterSpacing: 1.5);
  }

  TextStyle lodingText(Color c) {
    return TextStyle(
        fontSize: 22,
        fontFamily: 'sf',
        fontWeight: FontWeight.w400,
        color: c,
        decoration: TextDecoration.none,
        letterSpacing: 1.5);
  }

  // ................color.............

  Color inputfieldcolor() {
    return Color(0XFFFFFFF);
  }

  Color buttontile() {
    return Color(0XFF079992);
  }

  Color buttongreen() {
    return Color(0XFF78E08F);
  }
// ............iconsize................

  double appbariconSize = 30;

// ................Decoration.............

  BoxDecoration decinputfield() {
    return BoxDecoration(
        border: Border.all(
            color: Colors.black12, style: BorderStyle.solid, width: .2));
  }

  BoxDecoration appbardec() {
    return BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: Colors.black38, style: BorderStyle.solid, width: .2));
  }

  BoxDecoration indec() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            color: Colors.black38, style: BorderStyle.solid, width: .2));
  }

  ShapeBorder cardborder() {
    return RoundedRectangleBorder(
      side: BorderSide(color: Colors.black26, width: .1),
      borderRadius: BorderRadius.circular(5),
    );
  }

  BoxDecoration inputdec() {
    return BoxDecoration(
        color: inputfieldcolor(), borderRadius: BorderRadius.circular(5));
  }

  BoxDecoration inputdecborder() {
    return BoxDecoration(
        color: inputfieldcolor(),
        border: Border.all(
            color: Colors.black38, style: BorderStyle.solid, width: .2),
        borderRadius: BorderRadius.circular(5));
  }

  BoxDecoration inputdecborder1(Color c) {
    return BoxDecoration(
        color: c,
        border: Border.all(
            color: Colors.black38, style: BorderStyle.solid, width: .2),
        borderRadius: BorderRadius.circular(0));
  }

  InputDecoration inputform(Color c, Widget pref, String hint) {
    return InputDecoration(
        prefix: Container(child: pref),
        prefixStyle: TextStyle(fontSize: 30),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.greenAccent)));
  }

  BoxDecoration dashboardDec(String img) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(image: AssetImage(img), fit: BoxFit.contain));
  }

// ....paddin.....

  EdgeInsets pads(double h, double v) {
    return EdgeInsets.symmetric(horizontal: h, vertical: v);
  }
}
