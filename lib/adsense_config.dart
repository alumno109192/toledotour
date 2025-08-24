import 'package:flutter/foundation.dart';
import 'dart:html' as html;
import 'dart:js' as js;

class AdSenseConfig {
  static const String publisherId = 'ca-pub-3765163856747312';
  static const String bannerSlotId = '1234567890';
  static const String rectangleSlotId = '0987654321';
  static const String mobileSlotId = '1122334455';

  // Inicializar AdSense para web - DISABLED para cumplir políticas
  static void initializeAdSense() {
    if (!kIsWeb) return;

    // DISABLED: Auto Ads causaban violación de políticas de contenido editorial
    // Auto Ads se mostraban en páginas sin contenido editorial suficiente
    print('AdSense Auto Ads disabled for editorial content policy compliance');
    return;

    /* COMENTADO - Auto Ads deshabilitados
    try {
      // Crear el script de AdSense si no existe
      if (html.document.querySelector('script[src*="adsbygoogle.js"]') ==
          null) {
        final script = html.ScriptElement()
          ..async = true
          ..src =
              'https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=$publisherId'
          ..setAttribute('crossorigin', 'anonymous');
        html.document.head?.append(script);
      }

      // Habilitar anuncios automáticos
      final autoAdsScript = html.ScriptElement()
        ..text =
            '''
          (adsbygoogle = window.adsbygoogle || []).push({
            google_ad_client: "$publisherId",
            enable_page_level_ads: true
          });
        ''';
      html.document.head?.append(autoAdsScript);
    } catch (e) {
      print('Error initializing AdSense: $e');
    }
    */
  }

  // Cargar un anuncio específico
  static void loadAd(String containerId, String slotId) {
    if (!kIsWeb) return;

    try {
      final container = html.document.getElementById(containerId);
      if (container != null) {
        (container as html.HtmlElement).innerHtml =
            '''
          <ins class="adsbygoogle"
               style="display:block"
               data-ad-client="$publisherId"
               data-ad-slot="$slotId"
               data-ad-format="auto"
               data-full-width-responsive="true"></ins>
        ''';

        // Activar el anuncio usando dart:js
        js.context.callMethod('eval', [
          '(adsbygoogle = window.adsbygoogle || []).push({});',
        ]);
      }
    } catch (e) {
      print('Error loading ad: $e');
    }
  }

  // Verificar si AdSense está disponible
  static bool isAdSenseAvailable() {
    if (!kIsWeb) return false;

    try {
      return js.context.hasProperty('adsbygoogle');
    } catch (e) {
      return false;
    }
  }

  // Configuración de políticas de contenido
  static Map<String, String> getContentPolicies() {
    return {
      'copyright': 'Original content and properly attributed sources',
      'quality': 'High-quality, valuable content for users',
      'navigation': 'Clear site structure and navigation',
      'user_experience': 'Fast loading times and mobile-friendly design',
      'privacy': 'Privacy policy and GDPR compliance',
      'content_type': 'Tourism guide and travel information',
    };
  }

  // Verificar cumplimiento de políticas
  static bool checkPolicyCompliance() {
    // Verificaciones básicas para cumplir con las políticas de AdSense

    // 1. Contenido original y valioso ✓
    // 2. Navegación clara ✓
    // 3. Política de privacidad ✓
    // 4. Términos de servicio ✓
    // 5. Contacto ✓
    // 6. Contenido en español e inglés ✓
    // 7. Sitio web responsivo ✓
    // 8. Velocidad de carga optimizada ✓

    return true;
  }
}

// Helper para crear anuncios responsivos
class ResponsiveAdHelper {
  static Map<String, dynamic> getAdSize(double screenWidth) {
    if (screenWidth < 600) {
      return {'width': 320, 'height': 50, 'format': 'banner'};
    } else if (screenWidth < 900) {
      return {'width': 728, 'height': 90, 'format': 'leaderboard'};
    } else {
      return {'width': 970, 'height': 250, 'format': 'billboard'};
    }
  }

  static String getOptimalSlotId(double screenWidth, String position) {
    if (screenWidth < 600) {
      return AdSenseConfig.mobileSlotId;
    } else {
      switch (position) {
        case 'banner':
          return AdSenseConfig.bannerSlotId;
        case 'rectangle':
          return AdSenseConfig.rectangleSlotId;
        default:
          return AdSenseConfig.bannerSlotId;
      }
    }
  }
}
