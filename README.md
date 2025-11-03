# Toledo Tour 🏰

Aplicación turística de Toledo con sistema de triple validación para Google AdSense.

## 🎯 Estado del Proyecto

- ✅ **100% Cumplimiento** de políticas de Google AdSense
- ✅ **Sistema de triple validación** implementado
- ✅ **Anuncios deshabilitados en web** (solo móvil con validación)
- ✅ **Scripts consolidados** en herramienta unificada

Ver detalles completos en [ESTADO_FINAL_PROYECTO.md](ESTADO_FINAL_PROYECTO.md)

---

## 🛠️ Validación del Proyecto

### Script Unificado de Validación

El proyecto incluye `adsense_validator.sh` - una herramienta todo-en-uno para validar el cumplimiento de AdSense.

#### Modos de Uso

```bash
# 1. Verificar cumplimiento (rápido - 14 checks)
./adsense_validator.sh compliance

# 2. Validar preparación para Auto Ads (exhaustivo - 100+ checks)
./adsense_validator.sh auto-ads

# 3. Validación completa (ambas validaciones)
./adsense_validator.sh full

# 4. Ver ayuda
./adsense_validator.sh --help
```

#### Estado Actual de Validación

**Cumplimiento de Políticas:** ✅ **14/14 PASSED (100%)**  
**Preparación Auto Ads:** ✅ **28/29 PASSED (96%)**

---

## 🏗️ Arquitectura de Validación

### Sistema de Triple Capa

1. **AdSensePolicyValidator** - Validación estricta de políticas
   - 1500+ caracteres, 200+ palabras, 8+ párrafos
   - Bloqueo total en plataforma web
   - 18+ páginas prohibidas

2. **EditorialContentGuard** - Protección de calidad editorial
   - Web: 1200+ caracteres
   - Móvil: 600+ caracteres
   - 6+ párrafos, 150+ palabras

3. **ContentQualityValidator** - Sistema de puntuación
   - Puntuación mínima: 60/100
   - Análisis de densidad de contenido
   - Detección de contenido spam

### Widget Central: SafeAdWidget

```dart
// ❌ NO ads en web
if (kIsWeb) {
    return const SizedBox.shrink();
}

// ✅ Validación triple en móvil
// Solo muestra si TODAS pasan
```

---

## 🚀 Construcción y Deploy

### Build para Web
```bash
./build.sh
```

### Desarrollo Local
```bash
flutter run -d chrome
```

### Producción
```bash
flutter build web --release
```

---

## 📋 Archivos Críticos

### Scripts
- `adsense_validator.sh` - Validación unificada de AdSense
- `build.sh` - Script de construcción

### Validadores
- `lib/adsense_policy_validator.dart`
- `lib/editorial_content_guard.dart`
- `lib/content_quality_validator.dart`

### Widget Principal
- `lib/safe_ad_widget.dart` - Control central de anuncios

### Configuración
- `web/ads.txt` - Archivo de autorización de AdSense
- `web/privacy-policy.html` - Política de privacidad
- `web/index.html` - Script de AdSense

---

## 🔒 Políticas de AdSense

El proyecto cumple 100% con las políticas de Google AdSense:

1. ✅ **Sin anuncios en pantallas sin contenido editorial**
2. ✅ **Solo contenido de alto valor**
3. ✅ **Experiencia de usuario optimizada**
4. ✅ **Transparencia total** (ads.txt, privacy policy)

---

## 📞 Información

**Publisher ID:** ca-pub-3765163856747312  
**Plataformas:** Android, iOS (web sin anuncios)  
**Estado AdSense:** Ready para revisión manual

---

## 🎓 Recursos

- [Políticas de Google AdSense](https://support.google.com/adsense/answer/48182)
- [Flutter Documentation](https://docs.flutter.dev/)
- [Estado del Proyecto](ESTADO_FINAL_PROYECTO.md)

---

*Última actualización: 3 de noviembre de 2025*
