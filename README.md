# K6 Load Testing Project

## 📂 Estructura del Proyecto

```
k6-load-tests/
├── environments/
│   ├── dev.env.json
│   ├── staging.env.json
│   └── prod.env.json
├── scenarios/
│   ├── createUser.js
│   ├── updateUser.js
│   ├── deleteUser.js
│   └── getUsers.js
├── utils/
│   └── helpers.js
├── bin/                # Binario local de K6 para ejecución aislada
│   └── k6
├── config.js           # Carga configuración según entorno definido
├── test.js
├── package.json
└── README.md
```

---

## ⚙️ Configuración por Entorno

Cada archivo JSON en `environments/` define parámetros para distintos ambientes:

- `baseUrl`: URL base de la API a testear.
- `users`: Número de usuarios virtuales (VUs).
- `rampUp`: Tiempo para subir usuarios.
- `duration`: Duración total del test.
- `apiKey`: Apikey

Ejemplo (`dev.env.json`):

```json
{
  "baseUrl": "https://reqres.in",
  "users": 5,
  "rampUp": "5s",
  "duration": "10s"
}
```

La configuración activa se selecciona mediante la variable de entorno `ENV` al ejecutar K6.

---

## 🚀 Cómo Ejecutar los Tests

### 1. Ejecución directa con el binario local de K6

```bash
# Ejecutar el test en entorno DEV
ENV=dev ./bin/k6 run test.js
```

### 2. Usando npm scripts para simplificar

```bash
npm run test:dev      # Ejecuta en entorno DEV
npm run test:staging  # Ejecuta en entorno STAGING
npm run test:prod     # Ejecuta en entorno PROD
```

---

## 🛠️ Instalación Local de K6 (Linux)

Para evitar instalar K6 globalmente y mantener el proyecto aislado:

```bash
# Descargar el binario oficial de K6 para Linux
curl -L https://github.com/grafana/k6/releases/download/v0.49.0/k6-v0.49.0-linux-amd64.tar.gz -o k6.tar.gz

# Extraerlo
tar -xzf k6.tar.gz

# Crear carpeta local para el binario y moverlo
mkdir -p bin && mv k6-v0.49.0-linux-amd64/k6 ./bin/k6

# Limpiar archivos temporales
rm -rf k6-v0.49.0-linux-amd64 k6.tar.gz
```

Ahora podés ejecutar K6 desde `./bin/k6` sin instalación global.

---

## 🧩 Cómo Funciona el Proyecto

- `test.js` es el entry point que orquesta los diferentes escenarios (`login`, `getUsers`).
- La configuración se carga dinámicamente según `ENV` con la función nativa `open()` de K6.
- Los escenarios están modularizados para facilitar mantenimiento y extensión.
- Validaciones y checks aseguran que las respuestas cumplan condiciones esperadas.

---

## 📊 Próximos Pasos / Mejoras

- Integrar métricas y visualización en Grafana.
- Automatizar ejecución en pipelines CI/CD.
- Añadir reportes automáticos en formatos JSON o HTML.

---
