import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdHelper {
  InterstitialAd? _interstitialAd;
  bool _isLoaded = false;

  void loadAd({Function()? onLoaded}) {
    // No cargar anuncios en web
    if (kIsWeb) {
      _isLoaded = false;
      onLoaded?.call();
      return;
    }

    InterstitialAd.load(
      adUnitId: kDebugMode
          ? 'ca-app-pub-3940256099942544/1033173712' // ID de prueba intersticial
          : 'ca-app-pub-3765163856747312/1642809566', // ID real intersticial
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isLoaded = true;
          onLoaded?.call();
        },
        onAdFailedToLoad: (error) {
          _isLoaded = false;
        },
      ),
    );
  }

  void showAd({required VoidCallback onAdClosed}) {
    // En web, simplemente ejecutar el callback sin mostrar anuncio
    if (kIsWeb) {
      onAdClosed();
      return;
    }

    if (_isLoaded && _interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _isLoaded = false;
          loadAd(); // Prepara el siguiente
          onAdClosed();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _isLoaded = false;
          loadAd();
          onAdClosed();
        },
      );
      _interstitialAd!.show();
    } else {
      onAdClosed();
    }
  }
}
