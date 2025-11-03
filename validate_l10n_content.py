#!/usr/bin/env python3
"""
Script auxiliar para validar contenido de localizaciones
Valida que las descripciones tengan suficiente contenido editorial
"""

import json
import sys

def validate_content(file_path):
    """Valida el contenido de las descripciones en el archivo ARB"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        required_keys = [
            'cultural_tourism_desc',
            'gastronomy_desc',
            'nature_desc',
            'nightlife_desc'
        ]
        
        min_chars = 800
        all_pass = True
        results = []
        
        for key in required_keys:
            if key in data:
                content = data[key]
                char_count = len(content)
                
                if char_count >= min_chars:
                    results.append(f"✅ {key}: {char_count} caracteres (≥{min_chars})")
                else:
                    results.append(f"❌ {key}: {char_count} caracteres (necesita ≥{min_chars})")
                    all_pass = False
            else:
                results.append(f"❌ {key}: NO ENCONTRADO")
                all_pass = False
        
        # Imprimir resultados
        for result in results:
            print(result)
        
        return 0 if all_pass else 1
        
    except FileNotFoundError:
        print(f"❌ Archivo no encontrado: {file_path}")
        return 1
    except json.JSONDecodeError as e:
        print(f"❌ Error al parsear JSON: {e}")
        return 1
    except Exception as e:
        print(f"❌ Error inesperado: {e}")
        return 1

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Uso: python3 validate_l10n_content.py <archivo.arb>")
        sys.exit(1)
    
    sys.exit(validate_content(sys.argv[1]))
