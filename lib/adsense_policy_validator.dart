import 'package:flutter/foundation.dart';

/// Validador de Políticas de Google AdSense
/// Este módulo implementa verificaciones estrictas para cumplir con las políticas de Google AdSense
/// y prevenir violaciones de contenido editorial.
///
/// POLÍTICA CRÍTICA: Google AdSense prohíbe "Anuncios servidos por Google en pantallas sin contenido del editor"
class AdSensePolicyValidator {
  // Requisitos mínimos actualizados el 2 de noviembre de 2025
  static const int _minCharsForAds = 1500; // Mínimo 1500 caracteres
  static const int _minWordsForAds = 200; // Mínimo 200 palabras
  static const int _minParagraphsForAds = 8; // Mínimo 8 párrafos
  static const int _minSentencesForAds = 15; // Mínimo 15 oraciones

  /// Páginas que NUNCA pueden mostrar anuncios porque carecen de valor editorial
  static const Set<String> _zeroValuePages = {
    'language_selector',
    'language_selector_page',
    'languageselectorpage',
    'app_info',
    'app_info_page',
    'appinfopage',
    'contact_form',
    'contact_form_page',
    'contactformpage',
    'settings',
    'config',
    'about',
    'splash',
    'loading',
    'error',
    'empty',
    'home',
    'main',
    'root',
    'initial',
    'welcome',
    'privacy',
    'terms',
    'tourism_options_page', // La página principal solo tiene tarjetas de navegación
    'tourismoptionspage',
  };

  /// Valida si una página cumple con las políticas de AdSense para mostrar anuncios
  static ValidationResult validatePage({
    required String pageName,
    required String content,
    required bool isWeb,
  }) {
    final normalizedPageName = pageName.toLowerCase().replaceAll('_', '');

    // 1. BLOQUEO TOTAL EN WEB
    if (isWeb) {
      return ValidationResult(
        canShowAds: false,
        reason:
            'Anuncios completamente deshabilitados en web por política de AdSense',
        violations: ['Web platform detected'],
        score: 0,
      );
    }

    // 2. VERIFICAR PÁGINAS DE CERO VALOR
    if (_zeroValuePages.any(
      (page) => normalizedPageName.contains(page.toLowerCase()),
    )) {
      return ValidationResult(
        canShowAds: false,
        reason: 'Página "$pageName" no tiene contenido editorial de valor',
        violations: ['Zero-value page detected'],
        score: 0,
      );
    }

    // 3. VALIDACIÓN DE CONTENIDO
    final trimmedContent = content.trim();
    final violations = <String>[];
    int score = 100;

    // Validar longitud de caracteres
    if (trimmedContent.length < _minCharsForAds) {
      violations.add(
        'Contenido insuficiente: ${trimmedContent.length}/$_minCharsForAds caracteres',
      );
      score -= 30;
    }

    // Validar palabras
    final words = _countWords(trimmedContent);
    if (words < _minWordsForAds) {
      violations.add('Palabras insuficientes: $words/$_minWordsForAds');
      score -= 25;
    }

    // Validar párrafos
    final paragraphs = _countParagraphs(trimmedContent);
    if (paragraphs < _minParagraphsForAds) {
      violations.add(
        'Párrafos insuficientes: $paragraphs/$_minParagraphsForAds',
      );
      score -= 25;
    }

    // Validar oraciones
    final sentences = _countSentences(trimmedContent);
    if (sentences < _minSentencesForAds) {
      violations.add(
        'Oraciones insuficientes: $sentences/$_minSentencesForAds',
      );
      score -= 20;
    }

    // 4. DECISIÓN FINAL
    final canShowAds = violations.isEmpty && score >= 80;

    if (kDebugMode) {
      _logValidation(pageName, canShowAds, score, violations);
    }

    return ValidationResult(
      canShowAds: canShowAds,
      reason: canShowAds
          ? 'Contenido editorial válido para anuncios'
          : 'Contenido insuficiente para políticas de AdSense',
      violations: violations,
      score: score,
      stats: {
        'characters': trimmedContent.length,
        'words': words,
        'paragraphs': paragraphs,
        'sentences': sentences,
      },
    );
  }

  static int _countWords(String text) {
    return text.split(RegExp(r'\s+')).where((w) => w.length > 2).length;
  }

  static int _countParagraphs(String text) {
    return text.split('\n').where((p) => p.trim().length > 20).length;
  }

  static int _countSentences(String text) {
    return text
        .split(RegExp(r'[.!?]+'))
        .where((s) => s.trim().isNotEmpty)
        .length;
  }

  static void _logValidation(
    String pageName,
    bool canShowAds,
    int score,
    List<String> violations,
  ) {
    print('');
    print('╔${'═' * 58}╗');
    print('║  📋 VALIDACIÓN DE POLÍTICAS DE ADSENSE${' ' * 18}║');
    print('╠${'═' * 58}╣');
    print('║  📄 Página: ${pageName.padRight(44)}║');
    print(
      '║  📊 Puntuación: $score/100${' ' * (40 - score.toString().length)}║',
    );
    print(
      '║  ${canShowAds ? "✅" : "❌"} Puede mostrar anuncios: ${canShowAds ? "SÍ" : "NO"}${' ' * (canShowAds ? 30 : 31)}║',
    );

    if (violations.isNotEmpty) {
      print('╠${'═' * 58}╣');
      print('║  ⚠️  VIOLACIONES:${' ' * 40}║');
      for (final violation in violations) {
        final truncated = violation.length > 54
            ? '${violation.substring(0, 51)}...'
            : violation;
        print('║    • ${truncated.padRight(52)}║');
      }
    }

    print('╚${'═' * 58}╝');
    print('');
  }

  /// Obtiene las políticas de cumplimiento actuales
  static Map<String, String> getPolicies() {
    return {
      'min_characters': '$_minCharsForAds caracteres mínimos',
      'min_words': '$_minWordsForAds palabras mínimas',
      'min_paragraphs': '$_minParagraphsForAds párrafos mínimos',
      'min_sentences': '$_minSentencesForAds oraciones mínimas',
      'web_policy': 'Anuncios deshabilitados completamente en web',
      'mobile_policy': 'Anuncios permitidos solo con contenido editorial rico',
      'zero_value_pages': 'Páginas sin valor editorial prohibidas',
      'last_updated': '2 de noviembre de 2025',
    };
  }
}

/// Resultado de la validación de políticas de AdSense
class ValidationResult {
  final bool canShowAds;
  final String reason;
  final List<String> violations;
  final int score;
  final Map<String, int>? stats;

  ValidationResult({
    required this.canShowAds,
    required this.reason,
    required this.violations,
    required this.score,
    this.stats,
  });

  @override
  String toString() {
    return 'ValidationResult(canShowAds: $canShowAds, score: $score, violations: ${violations.length})';
  }
}
