import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../AdsHelper/adshelper.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({required this.value});
  final int value;

  @override
  State<StatefulWidget> createState() { return new _TableScreenState();}

}

class _TableScreenState extends State<TableScreen> {

  final table = List<String>.generate(10, (i) => 'Product $i');
  late BannerAd _bannerAd;

  bool _isBannerAdReady = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitIdOfTabelScreen,
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
          // Padding(
          //   padding: const EdgeInsets.only(top:45.0),
          //   child: Align(
          //     alignment: Alignment.topCenter,
          //     child: Column(
          //       children: [
          //         Text(
          //           'Table ${widget.value}',
          //           style: GoogleFonts.frederickaTheGreat(textStyle: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.w300,
          //           )),textAlign: TextAlign.center,
          //
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(14),
                    child:
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        '${widget.value} X ${index+1} = ${(widget.value)*(index+1)}',
                        style: GoogleFonts.frederickaTheGreat(textStyle: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.w300)),textAlign: TextAlign.center
                        ,
                      ),
                    ) );


              }),
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

