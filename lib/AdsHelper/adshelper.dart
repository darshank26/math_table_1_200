import 'dart:io';

class AdHelper {

  static String get bannerAdUnitIdOfHomeScreen {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
      // return  'ca-app-pub-2180535035689124/7129320790';
    }  else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get bannerAdUnitIdOfTabelScreen {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
      // return  'ca-app-pub-2180535035689124/6746177418';
    }  else {
      throw UnsupportedError('Unsupported platform');
    }
  }

}