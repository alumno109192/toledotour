import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'editorial_content_guard.dart';

class AdBannerWidget extends StatefulWidget {
  final bool showOnlyAfterContent;
  final String? customSlot;
  final String pageName;
  final String pageContent;

  const AdBannerWidget({
    super.key,
    this.showOnlyAfterContent = true,
    this.customSlot,
    this.pageName = 'unknown',
    this.pageContent = '',
  });

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    // Solo cargar anuncios en móvil - WEB COMPLETAMENTE DESHABILITADO
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
    // VERIFICACIÓN DE CONTENIDO EDITORIAL
    final canShowAds = EditorialContentGuard.canShowAdsOnPage(
      widget.pageName,
      widget.pageContent,
    );

    EditorialContentGuard.logContentCheck(
      widget.pageName,
      widget.pageContent,
      canShowAds,
    );

    if (!canShowAds) {
      if (kDebugMode) {
        print(
          '🚫 AdBanner bloqueado: ${EditorialContentGuard.getBlockingReason(widget.pageName, widget.pageContent)}',
        );
      }
      return const SizedBox.shrink();
    }

    // Para móvil, mostrar banner real si está cargado Y hay contenido editorial suficiente
    final bannerAd = _bannerAd;
    if (bannerAd == null) return const SizedBox.shrink();

    // Solo mostrar después del contenido principal (no en páginas vacías)
    if (widget.showOnlyAfterContent) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            // Indicador de que hay contenido editorial antes del anuncio
            if (kDebugMode)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '📄 Anuncio tras contenido editorial válido (${widget.pageContent.length} chars)',
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ),
            SizedBox(
              width: bannerAd.size.width.toDouble(),
              height: bannerAd.size.height.toDouble(),
              child: AdWidget(ad: bannerAd),
            ),
          ],
        ),
      );
    }

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
