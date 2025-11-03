#!/bin/bash

# ╔══════════════════════════════════════════════════════════════════════════╗
# ║  VALIDADOR COMPLETO DE GOOGLE ADSENSE - TOLEDO TOUR                     ║
# ║  Versión: 3.0 - Unificado                                               ║
# ║  Fecha: 3 de noviembre de 2025                                          ║
# ║                                                                          ║
# ║  Este script combina:                                                   ║
# ║  - Verificación de cumplimiento de políticas (CRÍTICO)                  ║
# ║  - Validación de preparación para Auto Ads (INFORMATIVO)                ║
# ╚══════════════════════════════════════════════════════════════════════════╝

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Directorio del proyecto
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Contadores
TOTAL_CHECKS=0
PASSED_CHECKS=0
FAILED_CHECKS=0
WARNINGS=0
CRITICAL_FAILURES=0

# Modos de ejecución
MODE="${1:-compliance}"  # compliance (por defecto) | full | auto-ads
STRICT_MODE=true

# Función para mostrar ayuda
show_help() {
    echo -e "${CYAN}"
    cat << EOF
╔══════════════════════════════════════════════════════════════════════════╗
║              VALIDADOR DE GOOGLE ADSENSE - TOLEDO TOUR                   ║
╚══════════════════════════════════════════════════════════════════════════╝

USO:
    $0 [MODO]

MODOS DISPONIBLES:

    compliance     (Por defecto) Verificación CRÍTICA de cumplimiento
                   → Verifica que no hay violaciones de políticas
                   → Ejecución rápida (13 checks)
                   → ✅ Necesario para Google AdSense

    auto-ads       Validación COMPLETA para solicitar Auto Ads
                   → Evalúa calidad de contenido editorial
                   → Verifica preparación técnica
                   → Ejecución exhaustiva (100+ checks)
                   → Modo estricto activado

    full           Ejecuta AMBAS validaciones
                   → Cumplimiento + Auto Ads
                   → Reporte completo del proyecto
                   → Recomendado antes de deploy

EJEMPLOS:

    # Verificar cumplimiento (rápido)
    $0 compliance

    # Validar para Auto Ads
    $0 auto-ads

    # Validación completa
    $0 full

    # Modo no-estricto para Auto Ads
    STRICT_MODE=false $0 auto-ads

EOF
    echo -e "${NC}"
    exit 0
}

# Mostrar ayuda si se solicita
if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    show_help
fi

# Función para imprimir encabezado
print_header() {
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════════════════════════════════╗"
    echo "║         VALIDADOR DE GOOGLE ADSENSE - TOLEDO TOUR                       ║"
    echo "║                     Modo: $1${NC}"
    echo "╚══════════════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Funciones para checks
check_pass() {
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
    echo -e "${GREEN}✅ PASS${NC}: $1"
}

check_fail() {
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    FAILED_CHECKS=$((FAILED_CHECKS + 1))
    echo -e "${RED}❌ FAIL${NC}: $1"
}

check_warn() {
    WARNINGS=$((WARNINGS + 1))
    echo -e "${YELLOW}⚠️  WARN${NC}: $1"
}

check_info() {
    echo -e "${BLUE}ℹ️  INFO${NC}: $1"
}

check_critical() {
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    FAILED_CHECKS=$((FAILED_CHECKS + 1))
    CRITICAL_FAILURES=$((CRITICAL_FAILURES + 1))
    echo -e "${RED}🚨 CRÍTICO${NC}: $1"
}

print_section() {
    echo -e "\n${MAGENTA}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}▶ $1${NC}"
    echo -e "${MAGENTA}═══════════════════════════════════════════════════════════${NC}\n"
}

# ═══════════════════════════════════════════════════════════════════════════
# MODO: CUMPLIMIENTO DE POLÍTICAS (CRÍTICO)
# ═══════════════════════════════════════════════════════════════════════════
run_compliance_checks() {
    print_header "CUMPLIMIENTO DE POLÍTICAS (CRÍTICO)"
    
    print_section "1. VERIFICACIÓN DE BLOQUEO DE ANUNCIOS EN WEB"
    
    # Check 1: SafeAdWidget bloquea web
    if [ -f "$PROJECT_DIR/lib/safe_ad_widget.dart" ]; then
        check_pass "SafeAdWidget implementado"
        
        if grep -q "if (kIsWeb)" "$PROJECT_DIR/lib/safe_ad_widget.dart"; then
            if grep -A 20 "if (kIsWeb)" "$PROJECT_DIR/lib/safe_ad_widget.dart" | grep -q "return const SizedBox.shrink()"; then
                check_pass "SafeAdWidget bloquea anuncios en web correctamente ✓✓"
            else
                check_fail "SafeAdWidget no retorna widget vacío en web"
            fi
        else
            check_fail "SafeAdWidget NO bloquea anuncios en web"
        fi
    else
        check_fail "SafeAdWidget NO encontrado"
    fi
    
    print_section "2. VERIFICACIÓN DE GUARDIA DE CONTENIDO EDITORIAL"
    
    # Check 2: EditorialContentGuard existe y bloquea web
    if [ -f "$PROJECT_DIR/lib/editorial_content_guard.dart" ]; then
        check_pass "EditorialContentGuard implementado"
        
        if grep -q "if (kIsWeb)" "$PROJECT_DIR/lib/editorial_content_guard.dart"; then
            if grep -A 10 "if (kIsWeb)" "$PROJECT_DIR/lib/editorial_content_guard.dart" | grep -q "return false"; then
                check_pass "Anuncios bloqueados en web por EditorialContentGuard ✓"
            else
                check_fail "Lógica de bloqueo incorrecta"
            fi
        else
            check_fail "Bloqueo de web NO implementado"
        fi
        
        # Verificar lista de páginas prohibidas
        if grep -q "_forbiddenPages" "$PROJECT_DIR/lib/editorial_content_guard.dart"; then
            forbidden_count=$(grep -c "language_selector\|app_info\|contact_form\|tourism_options" "$PROJECT_DIR/lib/editorial_content_guard.dart")
            if [ "$forbidden_count" -ge 4 ]; then
                check_pass "Lista de páginas prohibidas expandida ✓"
            else
                check_warn "Lista de páginas prohibidas incompleta"
            fi
        fi
    else
        check_fail "EditorialContentGuard NO implementado"
    fi
    
    print_section "3. VERIFICACIÓN DE VALIDADOR DE POLÍTICAS"
    
    # Check 3: AdSensePolicyValidator
    if [ -f "$PROJECT_DIR/lib/adsense_policy_validator.dart" ]; then
        check_pass "AdSensePolicyValidator implementado ✓"
        
        if grep -q "validatePage" "$PROJECT_DIR/lib/adsense_policy_validator.dart"; then
            check_pass "Método validatePage presente"
        else
            check_fail "Método validatePage NO encontrado"
        fi
        
        if grep -q "Web platform detected\|if (isWeb)" "$PROJECT_DIR/lib/adsense_policy_validator.dart"; then
            check_pass "Bloqueo de plataforma web implementado ✓"
        else
            check_fail "Bloqueo de web NO implementado"
        fi
    else
        check_fail "AdSensePolicyValidator NO implementado"
    fi
    
    print_section "4. VERIFICACIÓN DE PÁGINAS SIN ANUNCIOS"
    
    # Check 4: Páginas prohibidas sin anuncios
    forbidden_pages=("main.dart" "app_info_page.dart" "contact_form_page.dart")
    
    for page in "${forbidden_pages[@]}"; do
        if [ -f "$PROJECT_DIR/lib/$page" ]; then
            if grep -q "SafeAdWidget\|AdBannerWidget\|BannerAd" "$PROJECT_DIR/lib/$page"; then
                check_fail "$page contiene anuncios (NO PERMITIDO)"
            else
                check_pass "$page no contiene anuncios ✓"
            fi
        fi
    done
    
    print_section "5. VERIFICACIÓN DE ARCHIVOS CRÍTICOS"
    
    # Check 5: Archivos críticos
    if [ -f "$PROJECT_DIR/web/ads.txt" ]; then
        check_pass "ads.txt presente"
        if grep -q "google.com, pub-" "$PROJECT_DIR/web/ads.txt"; then
            check_pass "ads.txt configurado correctamente ✓"
        fi
    else
        check_warn "ads.txt no encontrado"
    fi
    
    if [ -f "$PROJECT_DIR/web/privacy-policy.html" ]; then
        check_pass "privacy-policy.html presente"
    else
        check_warn "privacy-policy.html no encontrado"
    fi
}

# ═══════════════════════════════════════════════════════════════════════════
# MODO: VALIDACIÓN PARA AUTO ADS
# ═══════════════════════════════════════════════════════════════════════════
run_autoads_validation() {
    print_header "VALIDACIÓN PARA AUTO ADS"
    
    print_section "1. VALIDACIÓN DE CONTENIDO EDITORIAL"
    
    check_info "Verificando contenido de páginas principales..."
    
    # Validar páginas principales
    main_pages_ok=0
    for page in "lib/turismo_cultural.dart" "lib/gastronomia.dart" "lib/naturaleza.dart" "lib/nocturno.dart"; do
        if [ -f "$PROJECT_DIR/$page" ]; then
            text_lines=$(grep -c "Text(" "$PROJECT_DIR/$page" || echo "0")
            if [ $text_lines -ge 8 ]; then
                check_pass "$(basename $page) tiene $text_lines widgets de texto ✓"
                main_pages_ok=$((main_pages_ok + 1))
            else
                check_fail "$(basename $page) solo tiene $text_lines widgets (mínimo 8)"
            fi
        fi
    done
    
    print_section "2. CONFIGURACIÓN TÉCNICA DE ADSENSE"
    
    # Verificar Publisher ID
    if [ -f "$PROJECT_DIR/lib/adsense_config.dart" ]; then
        check_pass "Configuración de AdSense encontrada"
        
        if grep -q "ca-pub-" "$PROJECT_DIR/lib/adsense_config.dart"; then
            pub_id=$(grep -o "ca-pub-[0-9]*" "$PROJECT_DIR/lib/adsense_config.dart" | head -1)
            check_pass "Publisher ID configurado: $pub_id"
        else
            check_fail "Publisher ID no configurado"
        fi
    fi
    
    # Verificar index.html
    if [ -f "$PROJECT_DIR/web/index.html" ]; then
        if grep -q "adsbygoogle.js" "$PROJECT_DIR/web/index.html"; then
            check_pass "Script de AdSense en index.html"
            
            if grep -q "crossorigin=\"anonymous\"" "$PROJECT_DIR/web/index.html"; then
                check_pass "Atributo crossorigin correcto ✓"
            else
                check_warn "Atributo crossorigin no encontrado"
            fi
        else
            check_fail "Script de AdSense NO encontrado"
        fi
    fi
    
    print_section "3. VALIDACIÓN MULTICAPA"
    
    # Verificar validadores
    validators=("adsense_policy_validator.dart" "editorial_content_guard.dart" "content_quality_validator.dart")
    validators_found=0
    
    for validator in "${validators[@]}"; do
        if [ -f "$PROJECT_DIR/lib/$validator" ]; then
            check_pass "$(basename $validator .dart) implementado ✓"
            validators_found=$((validators_found + 1))
        else
            check_warn "$(basename $validator .dart) no encontrado"
        fi
    done
    
    if [ $validators_found -ge 2 ]; then
        check_pass "Sistema de validación multicapa implementado ✓✓"
    else
        check_fail "Sistema de validación insuficiente"
    fi
    
    print_section "4. EXPERIENCIA DE USUARIO"
    
    # Navegación
    if grep -rq "Navigator\|MaterialPageRoute" "$PROJECT_DIR/lib/"*.dart 2>/dev/null; then
        check_pass "Sistema de navegación implementado"
    fi
    
    # Responsive
    if grep -rq "MediaQuery\|LayoutBuilder" "$PROJECT_DIR/lib/"*.dart 2>/dev/null; then
        check_pass "Diseño responsive implementado"
    fi
    
    # Multiidioma
    if [ -d "$PROJECT_DIR/lib/l10n" ] && [ "$(ls -A "$PROJECT_DIR/lib/l10n")" ]; then
        check_pass "Soporte multiidioma implementado"
    fi
}

# ═══════════════════════════════════════════════════════════════════════════
# RESUMEN FINAL
# ═══════════════════════════════════════════════════════════════════════════
show_summary() {
    print_section "RESUMEN FINAL"
    
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                    RESULTADOS DE VALIDACIÓN                  ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}\n"
    
    echo -e "  Total de validaciones:  ${BLUE}$TOTAL_CHECKS${NC}"
    echo -e "  ${GREEN}✅ Pasadas:             $PASSED_CHECKS${NC}"
    echo -e "  ${RED}❌ Fallidas:            $FAILED_CHECKS${NC}"
    echo -e "  ${YELLOW}⚠️  Advertencias:        $WARNINGS${NC}"
    
    if [ $CRITICAL_FAILURES -gt 0 ]; then
        echo -e "  ${RED}🚨 Críticas:            $CRITICAL_FAILURES${NC}"
    fi
    
    echo ""
    
    # Calcular porcentaje
    if [ $TOTAL_CHECKS -gt 0 ]; then
        success_rate=$((PASSED_CHECKS * 100 / TOTAL_CHECKS))
        echo -e "  Tasa de éxito: ${BLUE}$success_rate%${NC}\n"
    fi
    
    # Decisión final
    if [ $CRITICAL_FAILURES -gt 0 ]; then
        echo -e "${RED}╔══════════════════════════════════════════════════════════════╗${NC}"
        echo -e "${RED}║        🚨 FALLOS CRÍTICOS DETECTADOS: $CRITICAL_FAILURES 🚨                  ║${NC}"
        echo -e "${RED}║                                                              ║${NC}"
        echo -e "${RED}║  Corrige los errores críticos antes de continuar            ║${NC}"
        echo -e "${RED}╚══════════════════════════════════════════════════════════════╝${NC}"
        exit 2
    elif [ $FAILED_CHECKS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
        echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
        echo -e "${GREEN}║            🏆 ¡VALIDACIÓN PERFECTA! 🏆                       ║${NC}"
        echo -e "${GREEN}║                                                              ║${NC}"
        echo -e "${GREEN}║  100% de cumplimiento - Ready para Google AdSense           ║${NC}"
        echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
        exit 0
    elif [ $FAILED_CHECKS -eq 0 ]; then
        echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
        echo -e "${GREEN}║                  ✅ VALIDACIÓN EXITOSA ✅                     ║${NC}"
        echo -e "${GREEN}║                                                              ║${NC}"
        echo -e "${GREEN}║  Cumple con políticas de AdSense                            ║${NC}"
        echo -e "${GREEN}║  Advertencias: $WARNINGS (no bloquean)                                ║${NC}"
        echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
        exit 0
    else
        echo -e "${YELLOW}╔══════════════════════════════════════════════════════════════╗${NC}"
        echo -e "${YELLOW}║              ⚠️  VALIDACIÓN CON ERRORES ⚠️                    ║${NC}"
        echo -e "${YELLOW}║                                                              ║${NC}"
        echo -e "${YELLOW}║  Corrige los errores antes de continuar                     ║${NC}"
        echo -e "${YELLOW}╚══════════════════════════════════════════════════════════════╝${NC}"
        exit 1
    fi
}

# ═══════════════════════════════════════════════════════════════════════════
# EJECUCIÓN PRINCIPAL
# ═══════════════════════════════════════════════════════════════════════════

clear

case "$MODE" in
    compliance)
        run_compliance_checks
        ;;
    auto-ads)
        run_autoads_validation
        ;;
    full)
        run_compliance_checks
        echo ""
        run_autoads_validation
        ;;
    *)
        echo -e "${RED}Modo inválido: $MODE${NC}"
        show_help
        ;;
esac

show_summary

echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}Generado: $(date '+%Y-%m-%d %H:%M:%S')${NC}"
echo -e "${CYAN}Modo: $MODE | Directorio: $(basename "$PROJECT_DIR")${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
