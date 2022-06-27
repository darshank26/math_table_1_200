import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: kprimarycolor,
    // primaryTextTheme: TextTheme(
    //   bodyText1: TextStyle(),
    //   bodyText2: TextStyle(),
    //   subtitle1: TextStyle(),
    // ).apply(
    //   bodyColor:kprimarycolor,
    //   displayColor: kprimarycolor,
    //   decorationColor: kprimarycolor,
    // ),
  scaffoldBackgroundColor: ksecondcolor,
    primaryIconTheme: IconThemeData(
      color:const Color(0xfffB2EBF2),
    ),
    primarySwatch: Colors.blue,
    accentColor: Colors.yellow,

  tabBarTheme: TabBarTheme(
    labelColor: Color(0xfffB2EBF2),
    unselectedLabelColor: Color(0xfffB2EBF2),
  ),
  appBarTheme: AppBarTheme(
  color: kprimarycolor,
  ),
 buttonTheme: ButtonThemeData(),
  textTheme: TextTheme(
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
    subtitle1: TextStyle(),
  ).apply(
    bodyColor: Colors.blue[700],
    displayColor: Colors.blue[700],
    decorationColor: Color(0xff247188),
  ),
  iconTheme: IconThemeData(color: Color(0xff2a77a0),),
  buttonColor: Color(0xff2a77a0),

);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.indigo,
  buttonColor:Colors.grey,
  bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.grey,
      modalBackgroundColor: Colors.grey,
      modalElevation: 10

  ),

  textTheme: TextTheme(
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
    subtitle1: TextStyle(),
  ).apply(
      bodyColor: Colors.black54,
      displayColor: Colors.black54,
      decorationColor: Colors.black54
  ),

);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  final String key_language = "language";

  SharedPreferences? _prefs;
  bool? _darkTheme;
  String? _language;

  bool? get darkTheme => _darkTheme;
  String? get language => _language;

  ThemeNotifier() {
    _darkTheme = true;
    _language = '0';
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme!;
    _saveToPrefs();
    notifyListeners();
  }

  radioLanguage() {

    _language = "1";

    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if(_prefs == null)
      {
        _prefs = await SharedPreferences.getInstance();
      }
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs?.getBool(key) ?? true;
    _language = _prefs?.getString(key_language) ?? '0';

    notifyListeners();
  }

  _saveToPrefs()async {
    await _initPrefs();
    _prefs?.setBool(key, _darkTheme!);
    _prefs?.setString(key_language, _language!);

  }

}