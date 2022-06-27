import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:math_table_1_200/Screens/TableScreen.dart';

import '../AdsHelper/adshelper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BannerAd _bannerAd;

  bool _isBannerAdReady = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitIdOfHomeScreen,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();

  }


  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/background.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top:45.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Math Table 1 to 200',
                style: GoogleFonts.frederickaTheGreat(textStyle: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.w300)),textAlign: TextAlign.center
                ,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:75.0),
            child: GridView.count(
                crossAxisCount: 4,
                children:  List<Widget>.generate(200, (index) {
                  return  GridTile(
                    child:  GestureDetector(
                      onTap:() {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TableScreen(value:(index+1))));
                        },
                      child: Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white70,width: 0.5)
                        ),
                        child: Center(
                          child: Text(
                            '${index+1}',
                            style: GoogleFonts.frederickaTheGreat(textStyle: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w300)),textAlign: TextAlign.center,),),
              ),
                    ),
            );
        })),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isBannerAdReady)
              Container(
                width: _bannerAd.size.width.toDouble(),
                height: _bannerAd.size.height.toDouble(),
                child: Center(child: AdWidget(ad: _bannerAd)),
              ),
          ],
        ),
      ),

    );
  }
}

