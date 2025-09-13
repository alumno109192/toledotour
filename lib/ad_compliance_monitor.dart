import 'package:flutter/foundation.dart';

/// Sistema de métricas y monitoreo para cumplimiento de políticas de AdSense
class AdComplianceMonitor {
  static final Map<String, AdMetrics> _pageMetrics = {};
  static final List<ComplianceEvent> _events = [];

  /// Registra un evento de cumplimiento
  static void logEvent(ComplianceEvent event) {
    _events.add(event);

    if (kDebugMode) {
      print('📊 Evento de Cumplimiento:');
      print('   🎯 Tipo: ${event.type}');
      print('   📄 Página: ${event.pageName}');
      print('   📝 Descripción: ${event.description}');
      print('   ⏰ Timestamp: ${event.timestamp}');

      if (event.data.isNotEmpty) {
        print('   📋 Datos adicionales:');
        event.data.forEach((key, value) {
          print('      $key: $value');
        });
      }
    }

    // Mantener solo los últimos 100 eventos
    if (_events.length > 100) {
      _events.removeAt(0);
    }
  }

  /// Registra métricas de una página
  static void recordPageMetrics(String pageName, AdMetrics metrics) {
    _pageMetrics[pageName] = metrics;

    logEvent(
      ComplianceEvent(
        type: ComplianceEventType.pageAnalyzed,
        pageName: pageName,
        description: 'Página analizada para cumplimiento',
        data: metrics.toMap(),
      ),
    );
  }

  /// Registra cuando se muestra un anuncio
  static void recordAdShown(String pageName, String adType, String reason) {
    logEvent(
      ComplianceEvent(
        type: ComplianceEventType.adShown,
        pageName: pageName,
        description: reason,
        data: {'adType': adType},
      ),
    );
  }

  /// Registra cuando se bloquea un anuncio
  static void recordAdBlocked(
    String pageName,
    String reason,
    Map<String, dynamic> details,
  ) {
    logEvent(
      ComplianceEvent(
        type: ComplianceEventType.adBlocked,
        pageName: pageName,
        description: reason,
        data: details,
      ),
    );
  }

  /// Genera reporte de cumplimiento
  static ComplianceReport generateReport() {
    final totalPages = _pageMetrics.length;
    final pagesWithAds = _pageMetrics.values
        .where((m) => m.adsShown > 0)
        .length;
    final blockedAds = _events
        .where((e) => e.type == ComplianceEventType.adBlocked)
        .length;
    final shownAds = _events
        .where((e) => e.type == ComplianceEventType.adShown)
        .length;

    final avgContentLength = _pageMetrics.values.isEmpty
        ? 0
        : _pageMetrics.values
                  .map((m) => m.contentLength)
                  .reduce((a, b) => a + b) ~/
              _pageMetrics.length;

    final avgQualityScore = _pageMetrics.values.isEmpty
        ? 0
        : _pageMetrics.values
                  .map((m) => m.qualityScore)
                  .reduce((a, b) => a + b) ~/
              _pageMetrics.length;

    return ComplianceReport(
      totalPages: totalPages,
      pagesWithAds: pagesWithAds,
      blockedAds: blockedAds,
      shownAds: shownAds,
      avgContentLength: avgContentLength,
      avgQualityScore: avgQualityScore,
      complianceRate: totalPages > 0
          ? (pagesWithAds / totalPages * 100).round()
          : 0,
      events: List.from(_events),
    );
  }

  /// Obtiene métricas de una página específica
  static AdMetrics? getPageMetrics(String pageName) {
    return _pageMetrics[pageName];
  }

  /// Obtiene estadísticas generales
  static Map<String, dynamic> getGeneralStats() {
    final report = generateReport();

    return {
      'totalPages': report.totalPages,
      'pagesWithAds': report.pagesWithAds,
      'complianceRate': '${report.complianceRate}%',
      'avgContentLength': report.avgContentLength,
      'avgQualityScore': report.avgQualityScore,
      'totalEvents': _events.length,
      'adBlockedRate': report.shownAds > 0
          ? '${(report.blockedAds / (report.blockedAds + report.shownAds) * 100).round()}%'
          : '0%',
    };
  }

  /// Limpia las métricas (para testing)
  static void clearMetrics() {
    _pageMetrics.clear();
    _events.clear();
  }

  /// Exporta datos para análisis externo
  static Map<String, dynamic> exportData() {
    return {
      'timestamp': DateTime.now().toIso8601String(),
      'pageMetrics': _pageMetrics.map((k, v) => MapEntry(k, v.toMap())),
      'events': _events.map((e) => e.toMap()).toList(),
      'report': generateReport().toMap(),
    };
  }
}

/// Tipos de eventos de cumplimiento
enum ComplianceEventType {
  pageAnalyzed,
  adShown,
  adBlocked,
  validationFailed,
  policyViolation,
  systemInit,
}

/// Evento de cumplimiento
class ComplianceEvent {
  final ComplianceEventType type;
  final String pageName;
  final String description;
  final Map<String, dynamic> data;
  final DateTime timestamp;

  ComplianceEvent({
    required this.type,
    required this.pageName,
    required this.description,
    this.data = const {},
  }) : timestamp = DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'type': type.toString(),
      'pageName': pageName,
      'description': description,
      'data': data,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

/// Métricas de una página
class AdMetrics {
  final String pageName;
  final int contentLength;
  final int qualityScore;
  final int adsShown;
  final int adsBlocked;
  final List<String> blockReasons;
  final DateTime lastAnalyzed;

  AdMetrics({
    required this.pageName,
    required this.contentLength,
    required this.qualityScore,
    this.adsShown = 0,
    this.adsBlocked = 0,
    this.blockReasons = const [],
  }) : lastAnalyzed = DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'pageName': pageName,
      'contentLength': contentLength,
      'qualityScore': qualityScore,
      'adsShown': adsShown,
      'adsBlocked': adsBlocked,
      'blockReasons': blockReasons,
      'lastAnalyzed': lastAnalyzed.toIso8601String(),
    };
  }
}

/// Reporte de cumplimiento
class ComplianceReport {
  final int totalPages;
  final int pagesWithAds;
  final int blockedAds;
  final int shownAds;
  final int avgContentLength;
  final int avgQualityScore;
  final int complianceRate;
  final List<ComplianceEvent> events;
  final DateTime generatedAt;

  ComplianceReport({
    required this.totalPages,
    required this.pagesWithAds,
    required this.blockedAds,
    required this.shownAds,
    required this.avgContentLength,
    required this.avgQualityScore,
    required this.complianceRate,
    required this.events,
  }) : generatedAt = DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'totalPages': totalPages,
      'pagesWithAds': pagesWithAds,
      'blockedAds': blockedAds,
      'shownAds': shownAds,
      'avgContentLength': avgContentLength,
      'avgQualityScore': avgQualityScore,
      'complianceRate': complianceRate,
      'generatedAt': generatedAt.toIso8601String(),
      'summary': {
        'adSuccessRate': shownAds > 0
            ? '${(shownAds / (shownAds + blockedAds) * 100).round()}%'
            : '0%',
        'averageContentQuality': avgQualityScore > 70
            ? 'Buena'
            : avgQualityScore > 50
            ? 'Regular'
            : 'Baja',
        'complianceStatus': complianceRate > 80
            ? 'Excelente'
            : complianceRate > 60
            ? 'Bueno'
            : 'Mejorable',
      },
    };
  }

  void printSummary() {
    if (!kDebugMode) return;

    print('📊 REPORTE DE CUMPLIMIENTO DE ADSENSE');
    print('════════════════════════════════════════');
    print('📄 Páginas analizadas: $totalPages');
    print('📺 Páginas con anuncios: $pagesWithAds');
    print('✅ Anuncios mostrados: $shownAds');
    print('🚫 Anuncios bloqueados: $blockedAds');
    print('📏 Promedio de contenido: $avgContentLength caracteres');
    print('⭐ Puntuación promedio: $avgQualityScore/100');
    print('🎯 Tasa de cumplimiento: $complianceRate%');
    print('════════════════════════════════════════');

    final summary = toMap()['summary'] as Map<String, dynamic>;
    print('📈 Tasa de éxito de anuncios: ${summary['adSuccessRate']}');
    print('🏆 Calidad de contenido: ${summary['averageContentQuality']}');
    print('✨ Estado de cumplimiento: ${summary['complianceStatus']}');
  }
}
