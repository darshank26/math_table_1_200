import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

import 'Screens/HomeScreen.dart';
import 'utils/constants.dart';
import 'utils/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());

  MobileAds.instance.initialize(); // here

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _debugLabelString = "";

  late String _emailAddress;

  late String _externalUserId;

  bool _enableConsentButton = false;

  bool _requireConsent = true;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _handleConsent();
    // _handleSendNotification();

  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setRequiresUserPrivacyConsent(_requireConsent);
    var settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.promptBeforeOpeningPushUrl: true
    };

    // OneSignal.shared
    //     .setNotificationReceivedHandler((OSNotification notification) {
    //   this.setState(() {
    //     _debugLabelString =
    //     "Received notification: \n${notification.jsonRepresentation().replaceAll("\\n", "\n")}";
    //   });
    // });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      this.setState(() {
        _debugLabelString =
        "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setInAppMessageClickedHandler((OSInAppMessageAction action) {
      this.setState(() {
        _debugLabelString =
        "In App Message Clicked: \n${action.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setEmailSubscriptionObserver(
            (OSEmailSubscriptionStateChanges changes) {
          // print("EMAIL SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
        });

    // NOTE: Replace with your own app ID from https://www.onesignal.com
    await OneSignal.shared
        .setAppId("297e2f45-5c9b-47f3-b8d6-55cb32148b75");

    // OneSignal.shared
    //     .setInFocusDisplayType(OSNotificationDisplayType.notification);
  }

  void _handleConsent() {
    print("Setting consent to true");
    OneSignal.shared.consentGranted(true);
  }

  // void _handleSendNotification() async {
  //   var status = await OneSignal.shared.getPermissionSubscriptionState();
  //   var playerId = status.subscriptionStatus.userId;
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Math Table 1 to 200',
      theme : ThemeData(
        brightness: Brightness.light,
        primaryColor: kprimarycolor,
        primaryTextTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
          subtitle1: TextStyle(),
        ).apply(
          bodyColor:kprimarycolor,
          displayColor: kprimarycolor,
          decorationColor: kprimarycolor,
        ),
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

      ),

      home: IntroSplashScreen(),
    );
  }
}

class IntroSplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<IntroSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), ()=>
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen())));
  }
  @override
  Widget build(BuildContext context) {
       return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Math Table 1 to 200',
          home: Scaffold(
              body: Stack(
                children: [
                  Image.asset('assets/images/background.jpg',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100.0,),
                      Center(child:Text(
                        'Math Table',
                        style: GoogleFonts.frederickaTheGreat(textStyle: TextStyle(fontSize: 100,color: Colors.white,fontWeight: FontWeight.w300)),textAlign: TextAlign.center
                        ,
                      )),
                      const SizedBox(height: 100.0,),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Center(
                          child: CircularProgressIndicator(
                              color: Colors.white
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                          "Designed and Developed By - Darshan Komu",
                          style: GoogleFonts.frederickaTheGreat(textStyle: TextStyle(fontSize: 14,color: Colors.white))

                      ),
                    ),
                  ),
                ],
              ),

          ),

        );
      }
  }

