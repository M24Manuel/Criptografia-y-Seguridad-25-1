#!/bin/bash

# Ruta del archivo o cadena proporcionada
ruta_original="$1"

# Función para aplicar ROT13
rot13() {
    echo "$1" | tr 'A-Za-z' 'N-ZA-Mn-za-m'
}

# Separar la ruta en partes antes y después del último "/"
directorio=$(dirname "$ruta_original")
archivo=$(basename "$ruta_original")

# Inicializar la variable para la ruta decodificada
ruta_decodificada=""

# Recorrer cada parte de la ruta separada por "/"
IFS='/' read -ra PARTES <<< "$directorio"
for parte in "${PARTES[@]}"; do
    # Decodificar usando ROT13
    parte_decodificada=$(rot13 "$parte")
    # Reconstruir la ruta decodificada con "/"
    ruta_decodificada="$ruta_decodificada/$parte_decodificada"
done

# Procesar el archivo final
# Si contiene un punto, tratar la parte antes y después del punto por separado
if [[ "$archivo" == *.* ]]; then
    nombre=$(echo "$archivo" | cut -d. -f1)
    extension=$(echo "$archivo" | cut -d. -f2)
    archivo_decodificado="$(rot13 "$nombre").$(rot13 "$extension")"
else
    archivo_decodificado=$(rot13 "$archivo")
fi

# Reconstruir la ruta completa decodificada
ruta_decodificada="$ruta_decodificada/$archivo_decodificado"

# Mostrar el resultado
echo "Ruta original: $ruta_original"
echo "Ruta decodificada: $ruta_decodificada"
