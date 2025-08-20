import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBannerWidget extends StatefulWidget {
  final bool showOnlyAfterContent;
  final String? customSlot;

  const AdBannerWidget({
    super.key,
    this.showOnlyAfterContent = true,
    this.customSlot,
  });

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    // Solo cargar anuncios en móvil - Web usa Auto Ads
    if (!kIsWeb) {
      _loadMobileAd();
    }
  }

  void _loadMobileAd() {
    _bannerAd = BannerAd(
      adUnitId: kDebugMode
          ? 'ca-app-pub-3940256099942544/6300978111' // ID de prueba
          : widget.customSlot ?? 'ca-app-pub-3765163856747312/1558214931',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => setState(() {}),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // En web, no mostrar nada - Auto Ads se encarga
    if (kIsWeb) return const SizedBox.shrink();

    // Para móvil, mostrar banner real si está cargado
    final bannerAd = _bannerAd;
    if (bannerAd == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: bannerAd.size.width.toDouble(),
        height: bannerAd.size.height.toDouble(),
        child: AdWidget(ad: bannerAd),
      ),
    );
  }
}
