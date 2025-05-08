#!/bin/bash

# Script para automatizar git add, commit y push

# Navegar al directorio del proyecto (opcional si ejecutas el script desde la raíz del proyecto)
# cd /d/monity

# Preguntar por el mensaje del commit
echo "Introduce el mensaje para el commit:"
read commit_message

# Añadir todos los cambios
echo "Añadiendo todos los cambios (git add .)..."
git add .

# Hacer commit con el mensaje proporcionado
echo "Haciendo commit con el mensaje: '$commit_message'..."
git commit -m "$commit_message"

# Subir los cambios a la rama main en origin
echo "Subiendo cambios a origin main (git push origin main)..."
git push origin main

echo "¡Proceso completado!"