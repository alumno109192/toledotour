# Políticas de Anuncios - Toledo Tour

## ❌ ANUNCIOS COMPLETAMENTE DESHABILITADOS EN WEB

Para cumplir con las **políticas de contenido editorial de Google AdSense**, todos los anuncios han sido **completamente deshabilitados** en la versión web de la aplicación.

## 🚫 Problema Anterior

Google AdSense reportó: **"Anuncios servidos por Google en pantallas sin contenido del editor"**

Este error ocurría porque los Auto Ads aparecían en:
- Páginas de selección de idioma
- Páginas de carga
- Páginas con contenido mínimo
- Pantallas de configuración

## ✅ Solución Implementada

### 1. Web - Anuncios Completamente Removidos

- ❌ **AdSense Auto Ads**: Completamente removidos del `index.html`
- ❌ **Scripts de AdSense**: Eliminados todos los scripts
- ❌ **Inicialización de AdSense**: Deshabilitada en `adsense_config.dart`
- ❌ **AdBannerWidget**: No se renderiza en web (retorna `SizedBox.shrink()`)

### 2. Móvil - Anuncios Controlados

- ✅ **Banner Ads**: Solo en aplicaciones móviles nativas
- ✅ **Verificación de contenido**: Solo con contenido editorial suficiente
- ✅ **Guardia de contenido**: Implementado `EditorialContentGuard`

## 🛡️ Sistema de Protección: EditorialContentGuard

### Funcionalidades:

1. **Verificación de contenido mínimo**: 300+ caracteres
2. **Páginas prohibidas**: Lista de páginas que nunca muestran anuncios
3. **Logging detallado**: Para debugging y cumplimiento
4. **Políticas de cumplimiento**: Documentadas en código

### Páginas Sin Anuncios:

- `language_selector` - Selección de idioma
- `app_info` - Información de la app
- `contact_form` - Formulario de contacto
- `loading_page` - Páginas de carga
- `error_page` - Páginas de error

## 📱 Uso del Sistema

### En Páginas con Contenido Editorial:

```dart
// ✅ CORRECTO - Con verificación de contenido
AdBannerWidget(
  pageName: 'cultural_tourism',
  pageContent: 'Contenido editorial extenso sobre turismo cultural en Toledo...',
  showOnlyAfterContent: true,
)
```

### En Páginas Sin Contenido Editorial:

```dart
// ❌ NO USAR - Se bloquea automáticamente
AdBannerWidget(
  pageName: 'language_selector',
  pageContent: '',
)
// Resultado: SizedBox.shrink() - No se muestra
```

## 🔍 Debugging

El sistema proporciona logs detallados en modo debug:

```
📋 Editorial Content Check:
   📄 Página: cultural_tourism
   📝 Contenido: 1250 caracteres
   🎯 ¿Puede mostrar anuncios?: SÍ
```

```
🚫 AdBanner bloqueado: Anuncios deshabilitados en web para cumplimiento de políticas
```

## 📝 Archivos Modificados

### Principales:
- `web/index.html` - Scripts de AdSense removidos
- `lib/adsense_config.dart` - Inicialización deshabilitada
- `lib/ad_banner_widget.dart` - Guardia de contenido implementado
- `lib/main.dart` - AdBannerWidget removido de página principal

### Nuevos:
- `lib/editorial_content_guard.dart` - Sistema de protección
- `ADSENSE_POLICIES.md` - Este documento

## ⚠️ Importante para Desarrolladores

1. **NO** habilitar Auto Ads en web
2. **NO** agregar AdBannerWidget sin verificación de contenido
3. **SIEMPRE** usar `EditorialContentGuard` para nuevas páginas
4. **MANTENER** el contenido editorial como prioridad

## 🎯 Objetivo

**Priorizar la experiencia de usuario y el cumplimiento de políticas sobre la monetización.**

La aplicación debe ser útil y valiosa para los usuarios visitando Toledo, no una plataforma de anuncios.

## 🔮 Futuro

Si se desea reactivar anuncios en web:

1. Crear páginas con **contenido editorial extenso y valioso**
2. Implementar anuncios **manuales y específicos** (no Auto Ads)
3. Verificar cumplimiento con políticas de Google AdSense
4. Pasar por proceso de revisión de Google

---

**Fecha de implementación**: 12 de septiembre de 2025  
**Estado**: ✅ Anuncios seguros para políticas de Google AdSense
