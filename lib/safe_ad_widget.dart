import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'editorial_content_guard.dart';
import 'content_quality_validator.dart';
import 'adsense_config.dart';
import 'ad_compliance_monitor.dart';
import 'adsense_policy_validator.dart';

/// Widget de anuncio seguro que cumple 100% con políticas de Google AdSense
class SafeAdWidget extends StatefulWidget {
  final String pageName;
  final String pageContent;
  final String pageType;
  final String position; // 'top', 'content', 'bottom'
  final bool showMetrics; // Para desarrollo y debugging

  const SafeAdWidget({
    super.key,
    required this.pageName,
    required this.pageContent,
    this.pageType = 'general',
    this.position = 'content',
    this.showMetrics = false,
  });

  @override
  State<SafeAdWidget> createState() => _SafeAdWidgetState();
}

class _SafeAdWidgetState extends State<SafeAdWidget> {
  BannerAd? _bannerAd;
  ContentValidationResult? _validationResult;
  bool _adLoadAttempted = false;
  bool _adLoadSuccess = false;

  @override
  void initState() {
    super.initState();
    _validateAndLoadAd();
  }

  Future<void> _validateAndLoadAd() async {
    // 🔐 VALIDACIÓN ESTRICTA DE POLÍTICAS DE ADSENSE (2 nov 2025)
    // Esta validación es CRÍTICA para prevenir violaciones de políticas

    // 1. VALIDACIÓN PRINCIPAL: AdSense Policy Validator
    final policyValidation = AdSensePolicyValidator.validatePage(
      pageName: widget.pageName,
      content: widget.pageContent,
      isWeb: kIsWeb,
    );

    // 2. Validación exhaustiva de contenido (legacy)
    _validationResult = ContentQualityValidator.validateContent(
      content: widget.pageContent,
      pageName: widget.pageName,
      pageType: widget.pageType,
    );

    // 3. Verificación con EditorialContentGuard (legacy)
    final guardApproval = EditorialContentGuard.canShowAdsOnPage(
      widget.pageName,
      widget.pageContent,
    );

    // 4. Registrar métricas de la página
    final metrics = AdMetrics(
      pageName: widget.pageName,
      contentLength: widget.pageContent.length,
      qualityScore: policyValidation.score,
    );
    AdComplianceMonitor.recordPageMetrics(widget.pageName, metrics);

    if (kDebugMode) {
      print('🔍 Validación de anuncio para ${widget.pageName}:');
      print('   📊 Puntuación AdSense: ${policyValidation.score}/100');
      print('   📊 Puntuación de calidad: ${_validationResult!.score}/100');
      print(
        '   🛡️  Guardia de contenido: ${guardApproval ? "APROBADO" : "RECHAZADO"}',
      );
      print(
        '   🔐 Política AdSense: ${policyValidation.canShowAds ? "APROBADO" : "RECHAZADO"}',
      );
      print(
        '   🎯 Apto para anuncios: ${policyValidation.canShowAds && _validationResult!.isValidForAds && guardApproval}',
      );
    }

    // 5. DECISIÓN FINAL: Solo cargar si TODAS las validaciones pasan
    // PRIORIDAD: AdSense Policy Validator es el más importante
    final allValidationsPassed =
        policyValidation.canShowAds &&
        _validationResult!.isValidForAds &&
        guardApproval;

    if (allValidationsPassed) {
      await _loadAd();
      AdComplianceMonitor.recordAdShown(
        widget.pageName,
        kIsWeb ? 'web_manual' : 'mobile_banner',
        'Anuncio mostrado tras validación exitosa de contenido editorial',
      );
    } else {
      // Registrar bloqueo de anuncio con motivo detallado
      String blockReason;
      if (!policyValidation.canShowAds) {
        blockReason =
            'Política AdSense: ${policyValidation.reason} (Violaciones: ${policyValidation.violations.join(", ")})';
      } else if (!guardApproval) {
        blockReason = EditorialContentGuard.getBlockingReason(
          widget.pageName,
          widget.pageContent,
        );
      } else {
        blockReason =
            'Puntuación de calidad insuficiente: ${_validationResult!.score}/100';
      }

      AdComplianceMonitor.recordAdBlocked(widget.pageName, blockReason, {
        'policyScore': policyValidation.score,
        'qualityScore': _validationResult!.score,
        'contentLength': widget.pageContent.length,
        'violations': policyValidation.violations,
        'errors': _validationResult!.errors,
        'warnings': _validationResult!.warnings,
      });

      if (kDebugMode) {
        print('🚫 Anuncio bloqueado por validación de contenido');
        print('   Motivo: $blockReason');
      }
    }

    setState(() {});
  }

  Future<void> _loadAd() async {
    if (_adLoadAttempted) return;
    _adLoadAttempted = true;

    if (kIsWeb) {
      // Para web: usar anuncios manuales de AdSense
      await _loadWebAd();
    } else {
      // Para móvil: usar Google Mobile Ads
      _loadMobileAd();
    }
  }

  Future<void> _loadWebAd() async {
    if (!AdSenseConfig.areAdsEnabled || !AdSenseConfig.isAdSenseAvailable()) {
      return;
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final adConfig = ResponsiveAdHelper.getAdSize(screenWidth);
    final slotId = ResponsiveAdHelper.getOptimalSlotId(
      screenWidth,
      widget.position,
    );

    await AdSenseConfig.loadManualAd(
      containerId: 'ad-${widget.position}-${widget.pageName}',
      slotId: slotId,
      pageName: widget.pageName,
      pageContent: widget.pageContent,
      adFormat: adConfig['format'],
    );

    _adLoadSuccess = true;
    if (mounted) setState(() {});
  }

  void _loadMobileAd() {
    final screenWidth = MediaQuery.of(context).size.width;
    final slotId = ResponsiveAdHelper.getOptimalSlotId(
      screenWidth,
      widget.position,
    );

    _bannerAd = BannerAd(
      adUnitId: kDebugMode
          ? 'ca-app-pub-3940256099942544/6300978111' // Test ID
          : slotId,
      size: _getAdSize(screenWidth),
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _adLoadSuccess = true;
          if (mounted) setState(() {});

          if (kDebugMode) {
            print('✅ Anuncio móvil cargado para ${widget.pageName}');
          }
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (kDebugMode) {
            print('❌ Error cargando anuncio móvil: ${error.message}');
          }
        },
      ),
    )..load();
  }

  AdSize _getAdSize(double screenWidth) {
    if (screenWidth < 600) {
      return AdSize.banner; // 320x50
    } else if (screenWidth < 900) {
      return AdSize.leaderboard; // 728x90
    } else {
      return AdSize.largeBanner; // 320x100
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ❌ ANUNCIOS COMPLETAMENTE DESHABILITADOS EN WEB
    // MOTIVO: Google AdSense reportó "Anuncios servidos por Google en pantallas sin contenido del editor"
    // FECHA: 2 de noviembre de 2025
    // POLÍTICA: Solo contenido editorial rico y valioso puede mostrar anuncios
    if (kIsWeb) {
      if (kDebugMode) {
        print('');
        print('=' * 60);
        print('🚫 BLOQUEO DE ANUNCIOS - CUMPLIMIENTO ADSENSE');
        print('=' * 60);
        print('📄 Página: ${widget.pageName}');
        print('📝 Contenido: ${widget.pageContent.length} caracteres');
        print('🌐 Plataforma: WEB');
        print('⚠️  Política: Anuncios completamente deshabilitados en web');
        print('📋 Motivo: Prevención de violaciones de políticas de AdSense');
        print('🔒 Estado: BLOQUEADO');
        print('=' * 60);
        print('');
      }
      return const SizedBox.shrink(); // No mostrar NADA en web
    }

    // Si no pasa las validaciones EN MÓVIL, no mostrar nada
    if (_validationResult == null || !_validationResult!.isValidForAds) {
      return _buildDebugInfo();
    }

    // Si no se ha cargado el anuncio exitosamente EN MÓVIL, no mostrar nada
    if (!_adLoadSuccess) {
      return _buildDebugInfo();
    }

    return _buildAdContainer();
  }

  Widget _buildAdContainer() {
    if (kIsWeb) {
      return _buildWebAdContainer();
    } else {
      return _buildMobileAdContainer();
    }
  }

  Widget _buildWebAdContainer() {
    final screenWidth = MediaQuery.of(context).size.width;
    final adConfig = ResponsiveAdHelper.getAdSize(screenWidth);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          if (widget.showMetrics) _buildValidationMetrics(),
          Container(
            width: adConfig['width'].toDouble(),
            height: adConfig['height'].toDouble(),
            decoration: BoxDecoration(
              border: kDebugMode
                  ? Border.all(color: Colors.green, width: 2)
                  : null,
              borderRadius: BorderRadius.circular(4),
            ),
            child: kDebugMode
                ? Center(
                    child: Text(
                      '📺 Ad Space\n${adConfig['width']}x${adConfig['height']}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.green),
                    ),
                  )
                : null,
          ),
          if (kDebugMode)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '✅ Anuncio validado: ${widget.pageName}',
                style: const TextStyle(fontSize: 10, color: Colors.green),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMobileAdContainer() {
    final bannerAd = _bannerAd;
    if (bannerAd == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          if (widget.showMetrics) _buildValidationMetrics(),
          SizedBox(
            width: bannerAd.size.width.toDouble(),
            height: bannerAd.size.height.toDouble(),
            child: AdWidget(ad: bannerAd),
          ),
          if (kDebugMode)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '✅ Anuncio móvil validado: ${widget.pageName}',
                style: const TextStyle(fontSize: 10, color: Colors.green),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildValidationMetrics() {
    if (_validationResult == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📊 Métricas de Contenido',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          const SizedBox(height: 4),
          Text('Puntuación: ${_validationResult!.score}/100'),
          Text('Errores: ${_validationResult!.errors.length}'),
          Text('Advertencias: ${_validationResult!.warnings.length}'),
          Text('Caracteres: ${widget.pageContent.length}'),
          Text('Página: ${widget.pageName}'),
        ],
      ),
    );
  }

  Widget _buildDebugInfo() {
    if (!kDebugMode || !widget.showMetrics) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🚫 Anuncio No Mostrado',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade800,
            ),
          ),
          const SizedBox(height: 4),
          if (_validationResult != null) ...[
            Text('Puntuación: ${_validationResult!.score}/100'),
            Text('Válido: ${_validationResult!.isValidForAds}'),
            if (_validationResult!.errors.isNotEmpty)
              Text('Errores: ${_validationResult!.errors.join(", ")}'),
          ],
          Text('Página: ${widget.pageName}'),
          Text('Contenido: ${widget.pageContent.length} chars'),
        ],
      ),
    );
  }
}
