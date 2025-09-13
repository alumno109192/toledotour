import 'package:flutter/foundation.dart';

/// Guardia de contenido editorial para cumplir con políticas de Google AdSense
/// Esta clase asegura que los anuncios SOLO aparezcan en páginas con contenido editorial rico y valioso
class EditorialContentGuard {
  // Requisitos MÁS ESTRICTOS para web para cumplir con políticas de Google AdSense
  static const int _minContentLengthWeb = 800; // Mínimo 800 caracteres para web
  static const int _minContentLengthMobile =
      400; // Mínimo 400 caracteres para móvil
  static const int _minParagraphs = 4; // Mínimo 4 párrafos
  static const int _minWords = 100; // Mínimo 100 palabras

  // Páginas que requieren contenido extra para anuncios
  static const Set<String> _highContentPages = {
    'cultural_tourism',
    'gastronomia',
    'naturaleza',
    'destination_detail',
    'toledo_history',
    'restaurant_detail',
  };

  /// Verifica si una página tiene suficiente contenido editorial para mostrar anuncios
  static bool hasEditorialContent(String pageContent) {
    final content = pageContent.trim();
    final minLength = kIsWeb ? _minContentLengthWeb : _minContentLengthMobile;

    // Verificación básica de longitud
    if (content.length < minLength) {
      if (kDebugMode) {
        print(
          '🚫 Contenido insuficiente: ${content.length}/$minLength caracteres',
        );
      }
      return false;
    }

    // Verificación de párrafos
    final paragraphs = content
        .split('\n')
        .where((p) => p.trim().length > 10)
        .length;
    if (paragraphs < _minParagraphs) {
      if (kDebugMode) {
        print('🚫 Párrafos insuficientes: $paragraphs/$_minParagraphs');
      }
      return false;
    }

    // Verificación de palabras
    final words = content
        .split(RegExp(r'\s+'))
        .where((w) => w.length > 2)
        .length;
    if (words < _minWords) {
      if (kDebugMode) {
        print('🚫 Palabras insuficientes: $words/$_minWords');
      }
      return false;
    }

    if (kDebugMode) {
      print(
        '✅ Contenido editorial válido: ${content.length} chars, $paragraphs párrafos, $words palabras',
      );
    }

    return true;
  }

  /// Verifica si una página específica puede mostrar anuncios basado en su tipo
  static bool canShowAdsOnPage(String pageName, String content) {
    // Lista de páginas que NUNCA deben mostrar anuncios
    const forbiddenPages = [
      'language_selector',
      'app_info',
      'contact_form',
      'empty_page',
      'loading_page',
      'error_page',
      'welcome_page',
      'privacy_policy',
      'terms_of_service',
    ];

    if (forbiddenPages.contains(pageName.toLowerCase())) {
      if (kDebugMode) {
        print('🚫 Página "$pageName" en lista de páginas sin anuncios');
      }
      return false;
    }

    // Verificación extra para páginas de alto contenido
    if (_highContentPages.contains(pageName.toLowerCase())) {
      final extraMinLength = kIsWeb ? 1200 : 600; // Más contenido requerido
      if (content.trim().length < extraMinLength) {
        if (kDebugMode) {
          print(
            '🚫 Página de alto contenido "$pageName" requiere $extraMinLength caracteres',
          );
        }
        return false;
      }
    }

    return hasEditorialContent(content);
  }

  /// Obtiene el motivo por el cual no se pueden mostrar anuncios
  static String getBlockingReason(String pageName, String content) {
    const forbiddenPages = [
      'language_selector',
      'app_info',
      'contact_form',
      'empty_page',
      'loading_page',
      'error_page',
      'welcome_page',
      'privacy_policy',
      'terms_of_service',
    ];

    if (forbiddenPages.contains(pageName.toLowerCase())) {
      return 'Página "$pageName" en lista de exclusión de anuncios';
    }

    final minLength = kIsWeb ? _minContentLengthWeb : _minContentLengthMobile;
    if (content.trim().length < minLength) {
      return 'Contenido insuficiente: ${content.length} caracteres (mínimo $minLength)';
    }

    final paragraphs = content
        .split('\n')
        .where((p) => p.trim().length > 10)
        .length;
    if (paragraphs < _minParagraphs) {
      return 'Párrafos insuficientes: $paragraphs (mínimo $_minParagraphs)';
    }

    final words = content
        .split(RegExp(r'\s+'))
        .where((w) => w.length > 2)
        .length;
    if (words < _minWords) {
      return 'Palabras insuficientes: $words (mínimo $_minWords)';
    }

    return 'Verificación de contenido editorial fallida';
  }

  /// Registra información sobre la verificación de contenido
  static void logContentCheck(
    String pageName,
    String content,
    bool canShowAds,
  ) {
    if (!kDebugMode) return;

    print('📋 Editorial Content Check:');
    print('   📄 Página: $pageName');
    print('   📝 Contenido: ${content.length} caracteres');
    print('   🎯 ¿Puede mostrar anuncios?: ${canShowAds ? "SÍ" : "NO"}');

    if (!canShowAds) {
      print('   ❌ Motivo: ${getBlockingReason(pageName, content)}');
    }
  }

  /// Política de cumplimiento para desarrolladores
  static Map<String, String> getCompliancePolicies() {
    return {
      'editorial_content':
          'Páginas deben tener contenido editorial original y valioso',
      'minimum_content_web':
          'Mínimo $_minContentLengthWeb caracteres de contenido útil para web',
      'minimum_content_mobile':
          'Mínimo $_minContentLengthMobile caracteres de contenido útil para móvil',
      'minimum_paragraphs': 'Mínimo $_minParagraphs párrafos con contenido',
      'minimum_words': 'Mínimo $_minWords palabras significativas',
      'web_policy':
          'Anuncios habilitados en web SOLO con contenido editorial rico',
      'mobile_policy':
          'Anuncios permitidos en móvil con contenido editorial validado',
      'forbidden_pages':
          'Sin anuncios en páginas de configuración, carga o error',
      'user_experience': 'Priorizar experiencia de usuario sobre monetización',
      'high_content_pages': 'Páginas de turismo requieren contenido extra',
    };
  }

  /// Obtiene estadísticas del contenido para análisis
  static Map<String, int> getContentStats(String content) {
    final trimmed = content.trim();
    final paragraphs = trimmed
        .split('\n')
        .where((p) => p.trim().length > 10)
        .length;
    final words = trimmed
        .split(RegExp(r'\s+'))
        .where((w) => w.length > 2)
        .length;
    final sentences = trimmed
        .split(RegExp(r'[.!?]+'))
        .where((s) => s.trim().isNotEmpty)
        .length;

    return {
      'characters': trimmed.length,
      'paragraphs': paragraphs,
      'words': words,
      'sentences': sentences,
      'min_chars_required': kIsWeb
          ? _minContentLengthWeb
          : _minContentLengthMobile,
      'min_paragraphs_required': _minParagraphs,
      'min_words_required': _minWords,
    };
  }
}
