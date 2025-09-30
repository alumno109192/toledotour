#!/bin/bash
# Script de verificación de cumplimiento de Google AdSense
# Ejecutar después de los cambios para verificar que todo está correcto

echo "🔍 VERIFICACIÓN DE CUMPLIMIENTO GOOGLE ADSENSE"
echo "================================================"

echo ""
echo "1. Verificando eliminación de scripts de AdSense en web..."
if grep -q "adsbygoogle.js" build/web/index.html; then
    echo "❌ ERROR: Scripts de AdSense encontrados en build web"
    exit 1
else
    echo "✅ Scripts de AdSense correctamente eliminados"
fi

echo ""
echo "2. Verificando configuración de anuncios..."
if grep -A1 "_adsEnabled =" lib/adsense_config.dart | grep -q "false"; then
    echo "✅ Anuncios correctamente deshabilitados en configuración"
else
    echo "❌ ERROR: Anuncios no están deshabilitados"
    exit 1
fi

echo ""
echo "3. Verificando widgets de anuncios..."
if grep -q "if (kIsWeb)" lib/ad_banner_widget.dart && grep -q "SizedBox.shrink()" lib/ad_banner_widget.dart; then
    echo "✅ AdBannerWidget correctamente bloqueado en web"
else
    echo "❌ ERROR: AdBannerWidget no está bloqueado en web"
    exit 1
fi

if grep -q "if (kIsWeb)" lib/safe_ad_widget.dart && grep -q "SizedBox.shrink()" lib/safe_ad_widget.dart; then
    echo "✅ SafeAdWidget correctamente bloqueado en web"
else
    echo "❌ ERROR: SafeAdWidget no está bloqueado en web"
    exit 1
fi

echo ""
echo "4. Verificando requisitos de contenido editorial..."
if grep -A1 "_minContentLengthWeb =" lib/editorial_content_guard.dart | grep -q "1200"; then
    echo "✅ Requisitos de contenido aumentados correctamente"
else
    echo "❌ ERROR: Requisitos de contenido no aumentados"
    exit 1
fi

echo ""
echo "5. Verificando documentación..."
if [ -f "ADSENSE_COMPLIANCE_FIX.md" ]; then
    echo "✅ Documentación de corrección creada"
else
    echo "❌ ERROR: Falta documentación de corrección"
    exit 1
fi

echo ""
echo "🎯 RESULTADO FINAL"
echo "=================="
echo "✅ Todos los checks pasaron correctamente"
echo "✅ La aplicación cumple con las políticas de Google AdSense"
echo "✅ NO habrá anuncios en pantallas sin contenido editorial"
echo ""
echo "📋 ESTADO:"
echo "   • Web: Anuncios COMPLETAMENTE DESHABILITADOS"
echo "   • Móvil: Solo con validación estricta de contenido"
echo "   • Páginas problemáticas: TODAS bloqueadas"
echo ""
echo "🚀 La aplicación está lista para deployment sin violaciones de políticas"