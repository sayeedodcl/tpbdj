import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefkeys {
  static const String USER = 'USER';
  static const String USERTOKEN = 'TOKEN';
  static const String ISUSERLOGEDIN = 'ISUSERLOGEDIN';
}

class SharedPrefManager {
  static Future<bool?> isUserLogedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getBool(SharedPrefkeys.ISUSERLOGEDIN);
  }

  static Future<bool> setUserLogedIn(bool isuser) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setBool(SharedPrefkeys.ISUSERLOGEDIN, isuser);
  }

  static saveText(String token) async {
    String text = token;
    print('this ..........' + text);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(text);
    return prefs.setString('Ourtoken', text);
  }

  static getText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('Ourtoken');
  }

// ........................................Relative id.......................................................
  static saveRleativeid(String id) async {
    String text = id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('rid', text);
  }

  static getrelativeid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('rid');
  }

//.................................... Relative mobile...........................................................
  static saveRleativemobile(String id) async {
    String text = id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('rphn', text);
  }

  static getrelativemobile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('rphn');
  }

//.................................... Relative name...........................................................
  static saveRleativename(String id) async {
    String text = id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('rname', text);
  }

  static getrelativename() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('rname');
  }

  static removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("Ourtoken");
    //Remove bool
    prefs.remove(SharedPrefkeys.ISUSERLOGEDIN);
    //Remove int
    prefs.remove("rid");
  }
}
