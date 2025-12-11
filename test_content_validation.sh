#!/bin/bash

# Script para probar la validación de contenido de páginas principales
# Este script verifica que cada página tenga suficiente contenido editorial

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║     VALIDACIÓN DE CONTENIDO EDITORIAL - TOLEDO TOUR            ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

PROJECT_DIR="/Users/yesod/FlutterProjects/newToledoTour/toledotour"

# Función para contar caracteres en contenido de texto
count_text_content() {
    local file=$1
    # Extraer todo el texto entre comillas simples en widgets Text
    grep -o "Text(['\"].*['\"]" "$file" 2>/dev/null | sed "s/Text(['\"]//g" | sed "s/['\"].*//g" | tr '\n' ' ' | wc -c || echo "0"
}

# Función para contar palabras
count_words() {
    local file=$1
    grep -o "Text(['\"].*['\"]" "$file" 2>/dev/null | sed "s/Text(['\"]//g" | sed "s/['\"].*//g" | tr '\n' ' ' | wc -w || echo "0"
}

echo "═══════════════════════════════════════════════════════════════"
echo "▶ PÁGINAS PRINCIPALES CON CONTENIDO EDITORIAL"
echo "═══════════════════════════════════════════════════════════════"
echo ""

# Páginas principales que deben tener contenido rico
main_pages=(
    "lib/turismo_cultural.dart"
    "lib/gastronomia.dart"
    "lib/naturaleza.dart"
    "lib/nocturno.dart"
    "lib/free_tour.dart"
)

total_pages=0
valid_pages=0

for page in "${main_pages[@]}"; do
    total_pages=$((total_pages + 1))
    page_name=$(basename "$page" .dart)
    
    if [ -f "$PROJECT_DIR/$page" ]; then
        # Contar contenido
        chars=$(count_text_content "$PROJECT_DIR/$page")
        words=$(count_words "$PROJECT_DIR/$page")
        
        # Contar widgets Text (aproximación de párrafos)
        text_widgets=$(grep -c "Text(" "$PROJECT_DIR/$page" || echo "0")
        
        echo "📄 $page_name"
        echo "   ├─ Caracteres de texto: ~$chars"
        echo "   ├─ Palabras: ~$words"
        echo "   └─ Widgets de texto: $text_widgets"
        
        # Validar según requisitos de AdSense
        if [ "$chars" -ge 1500 ] && [ "$words" -ge 200 ] && [ "$text_widgets" -ge 8 ]; then
            echo "   ✅ VÁLIDO para AdSense (cumple requisitos mínimos)"
            valid_pages=$((valid_pages + 1))
        else
            echo "   ⚠️  REVISAR - Podría necesitar más contenido"
            if [ "$chars" -lt 1500 ]; then
                echo "      • Necesita más caracteres (mínimo 1500)"
            fi
            if [ "$words" -lt 200 ]; then
                echo "      • Necesita más palabras (mínimo 200)"
            fi
            if [ "$text_widgets" -lt 8 ]; then
                echo "      • Necesita más párrafos/secciones (mínimo 8)"
            fi
        fi
        echo ""
    else
        echo "❌ $page_name - ARCHIVO NO ENCONTRADO"
        echo ""
    fi
done

echo "═══════════════════════════════════════════════════════════════"
echo "▶ ARCHIVO DE LOCALIZACIONES"
echo "═══════════════════════════════════════════════════════════════"
echo ""

# Verificar archivo de localizaciones
l10n_file="$PROJECT_DIR/lib/l10n/app_localizations.dart"
if [ -f "$l10n_file" ]; then
    # Contar traducciones relevantes
    intro_texts=$(grep -c "_intro_text" "$l10n_file" || echo "0")
    desc_texts=$(grep -c "_desc" "$l10n_file" || echo "0")
    title_texts=$(grep -c "_title" "$l10n_file" || echo "0")
    
    echo "📚 app_localizations.dart"
    echo "   ├─ Textos introductorios: $intro_texts"
    echo "   ├─ Descripciones: $desc_texts"
    echo "   └─ Títulos: $title_texts"
    
    # Verificar contenido expandido específico
    echo ""
    echo "   Contenido Editorial Expandido:"
    
    if grep -q "Turismo Cultural en Toledo.*Guía Completa" "$l10n_file"; then
        echo "   ✅ Turismo Cultural - Contenido expandido presente"
    else
        echo "   ⚠️  Turismo Cultural - Verificar contenido"
    fi
    
    if grep -q "Gastronomía.*Tradición Culinaria" "$l10n_file"; then
        echo "   ✅ Gastronomía - Contenido expandido presente"
    else
        echo "   ⚠️  Gastronomía - Verificar contenido"
    fi
    
    if grep -q "Entorno Natural.*Toledo" "$l10n_file"; then
        echo "   ✅ Naturaleza - Contenido expandido presente"
    else
        echo "   ⚠️  Naturaleza - Verificar contenido"
    fi
    
    if grep -q "Toledo de Noche.*Misterio" "$l10n_file"; then
        echo "   ✅ Vida Nocturna - Contenido expandido presente"
    else
        echo "   ⚠️  Vida Nocturna - Verificar contenido"
    fi
    
    if grep -q "Free Tours.*Toledo Imperial" "$l10n_file"; then
        echo "   ✅ Free Tours - Contenido expandido presente"
    else
        echo "   ⚠️  Free Tours - Verificar contenido"
    fi
fi

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "▶ RESUMEN FINAL"
echo "═══════════════════════════════════════════════════════════════"
echo ""

percentage=$((valid_pages * 100 / total_pages))

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                  RESULTADOS DE VALIDACIÓN                      ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "  Páginas analizadas:      $total_pages"
echo "  Páginas válidas:         $valid_pages"
echo "  Páginas a revisar:       $((total_pages - valid_pages))"
echo ""
echo "  Tasa de cumplimiento:    $percentage%"
echo ""

if [ "$valid_pages" -eq "$total_pages" ]; then
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║               🎉 ¡VALIDACIÓN EXITOSA! 🎉                       ║"
    echo "║                                                                ║"
    echo "║  Todas las páginas cumplen con los requisitos de contenido    ║"
    echo "║  editorial para Google AdSense                                ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
else
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║                ⚠️  ACCIÓN REQUERIDA ⚠️                          ║"
    echo "║                                                                ║"
    echo "║  Algunas páginas necesitan más contenido editorial            ║"
    echo "║  para cumplir con las políticas de Google AdSense             ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
fi

echo ""
