import 'package:flutter/foundation.dart';

/// Validador avanzado de calidad de contenido para cumplir políticas de Google AdSense
class ContentQualityValidator {
  /// Estructura para resultados de validación
  static const Map<String, List<String>> contentRequirements = {
    'tourism_pages': [
      'Información útil y original sobre destinos turísticos',
      'Detalles específicos: horarios, precios, ubicaciones',
      'Contexto histórico o cultural relevante',
      'Recomendaciones prácticas para visitantes',
    ],
    'restaurant_pages': [
      'Descripción detallada de la gastronomía local',
      'Información sobre especialidades y platos típicos',
      'Contexto cultural de la comida toledana',
      'Recomendaciones gastronómicas específicas',
    ],
    'cultural_pages': [
      'Información histórica verificable y detallada',
      'Contexto cultural y artístico relevante',
      'Importancia patrimonial del sitio o evento',
      'Detalles prácticos para la visita cultural',
    ],
  };

  /// Validación exhaustiva de contenido editorial
  static ContentValidationResult validateContent({
    required String content,
    required String pageName,
    required String pageType,
  }) {
    final result = ContentValidationResult();

    // 1. Validación básica de longitud
    _validateLength(content, result);

    // 2. Validación de estructura
    _validateStructure(content, result);

    // 3. Validación de calidad de contenido
    _validateQuality(content, result);

    // 4. Validación específica por tipo de página
    _validatePageType(content, pageType, result);

    // 5. Validación de elementos prohibidos
    _validateForbiddenContent(content, result);

    // 6. Puntuación general
    result.calculateScore();

    if (kDebugMode) {
      _logValidationResult(pageName, result);
    }

    return result;
  }

  static void _validateLength(String content, ContentValidationResult result) {
    final length = content.trim().length;

    if (length < 400) {
      result.addError(
        'Contenido demasiado corto: $length caracteres (mínimo 400)',
      );
    } else if (length < 800 && kIsWeb) {
      result.addWarning(
        'Contenido corto para web: $length caracteres (recomendado 800+)',
      );
    } else {
      result.addSuccess('Longitud de contenido adecuada: $length caracteres');
    }
  }

  static void _validateStructure(
    String content,
    ContentValidationResult result,
  ) {
    final paragraphs = content
        .split('\n')
        .where((p) => p.trim().length > 20)
        .length;
    final sentences = content
        .split(RegExp(r'[.!?]+'))
        .where((s) => s.trim().isNotEmpty)
        .length;
    final words = content
        .split(RegExp(r'\s+'))
        .where((w) => w.length > 2)
        .length;

    if (paragraphs < 3) {
      result.addError('Muy pocos párrafos: $paragraphs (mínimo 3)');
    } else {
      result.addSuccess(
        'Estructura de párrafos adecuada: $paragraphs párrafos',
      );
    }

    if (sentences < 10) {
      result.addWarning('Pocas oraciones: $sentences (recomendado 10+)');
    }

    if (words < 80) {
      result.addError('Muy pocas palabras: $words (mínimo 80)');
    }
  }

  static void _validateQuality(String content, ContentValidationResult result) {
    final lowerContent = content.toLowerCase();

    // Verificar palabras clave de turismo
    const tourismKeywords = [
      'toledo',
      'turismo',
      'visita',
      'historia',
      'cultura',
      'monumento',
      'catedral',
      'alcázar',
      'museo',
      'arte',
      'arquitectura',
      'patrimonio',
    ];

    int keywordCount = 0;
    for (final keyword in tourismKeywords) {
      if (lowerContent.contains(keyword)) {
        keywordCount++;
      }
    }

    if (keywordCount < 3) {
      result.addWarning('Pocas palabras clave de turismo: $keywordCount/3');
    } else {
      result.addSuccess(
        'Contenido relevante para turismo: $keywordCount palabras clave',
      );
    }

    // Verificar información práctica
    const practicalInfo = [
      'horario',
      'precio',
      'dirección',
      'cómo llegar',
      'entrada',
      'visita',
    ];
    int practicalCount = 0;
    for (final info in practicalInfo) {
      if (lowerContent.contains(info)) {
        practicalCount++;
      }
    }

    if (practicalCount >= 2) {
      result.addSuccess('Incluye información práctica útil');
    }
  }

  static void _validatePageType(
    String content,
    String pageType,
    ContentValidationResult result,
  ) {
    final requirements = contentRequirements[pageType] ?? [];
    if (requirements.isEmpty) return;

    final lowerContent = content.toLowerCase();
    int metRequirements = 0;

    for (final requirement in requirements) {
      // Verificación simplificada - en producción sería más sofisticada
      final keywords = requirement.toLowerCase().split(' ');
      bool hasKeywords = keywords.any(
        (keyword) => lowerContent.contains(keyword),
      );

      if (hasKeywords) {
        metRequirements++;
      }
    }

    final percentage = (metRequirements / requirements.length * 100).round();
    if (percentage >= 75) {
      result.addSuccess('Cumple requisitos de contenido: $percentage%');
    } else {
      result.addWarning('Cumplimiento parcial de requisitos: $percentage%');
    }
  }

  static void _validateForbiddenContent(
    String content,
    ContentValidationResult result,
  ) {
    final lowerContent = content.toLowerCase();

    // Contenido que puede violar políticas de AdSense
    const forbidden = [
      'haz clic aquí',
      'click here',
      'anuncio',
      'publicidad',
      'spam',
      'promoción',
      'descarga gratis',
      'oferta limitada',
    ];

    for (final phrase in forbidden) {
      if (lowerContent.contains(phrase)) {
        result.addError('Contiene contenido prohibido: "$phrase"');
      }
    }

    // Verificar densidad de enlaces
    final linkMatches = RegExp(r'http[s]?://').allMatches(content);
    if (linkMatches.length > 5) {
      result.addWarning(
        'Muchos enlaces externos: ${linkMatches.length} (máximo recomendado: 5)',
      );
    }
  }

  static void _logValidationResult(
    String pageName,
    ContentValidationResult result,
  ) {
    print('📋 Validación de contenido para: $pageName');
    print('   🎯 Puntuación: ${result.score}/100');
    print('   ✅ Apto para anuncios: ${result.isValidForAds ? "SÍ" : "NO"}');

    if (result.errors.isNotEmpty) {
      print('   ❌ Errores: ${result.errors.length}');
      for (final error in result.errors) {
        print('      • $error');
      }
    }

    if (result.warnings.isNotEmpty) {
      print('   ⚠️  Advertencias: ${result.warnings.length}');
      for (final warning in result.warnings) {
        print('      • $warning');
      }
    }
  }
}

/// Resultado de validación de contenido
class ContentValidationResult {
  final List<String> errors = [];
  final List<String> warnings = [];
  final List<String> successes = [];

  int score = 0;
  bool get isValidForAds => score >= 70 && errors.isEmpty;

  void addError(String message) => errors.add(message);
  void addWarning(String message) => warnings.add(message);
  void addSuccess(String message) => successes.add(message);

  void calculateScore() {
    // Fórmula de puntuación basada en éxitos, advertencias y errores
    int baseScore = successes.length * 20;
    int penalty = (warnings.length * 5) + (errors.length * 15);

    score = (baseScore - penalty).clamp(0, 100);
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'isValidForAds': isValidForAds,
      'errors': errors,
      'warnings': warnings,
      'successes': successes,
    };
  }
}
