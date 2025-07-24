# Makefile para proyecto K6 Load Testing

.PHONY: install test-dev test-staging test-prod clean help

# Variables
K6_VERSION = 0.49.0
K6_URL = https://github.com/grafana/k6/releases/download/v$(K6_VERSION)/k6-v$(K6_VERSION)-linux-amd64.tar.gz
K6_BINARY = ./bin/k6

K6_REPORTER_VERSION = 2.4.0
K6_REPORTER_URL = https://github.com/benc-uk/k6-reporter/archive/refs/tags/$(K6_REPORTER_VERSION).tar.gz
K6_REPORTER_BINARY = ./bin/k6-reporter

# Descargar y preparar K6 localmente
install:
	@echo "🔽 Descargando K6 v$(K6_VERSION)..."
	curl -L $(K6_URL) -o k6.tar.gz
	tar -xzf k6.tar.gz
	mkdir -p bin
	mv k6-v$(K6_VERSION)-linux-amd64/k6 $(K6_BINARY)
	chmod +x $(K6_BINARY)
	rm -rf k6-v$(K6_VERSION)-linux-amd64 k6.tar.gz
	@echo "✅ K6 instalado en $(K6_BINARY)"

# Ejecutar test en entorno dev
test-dev:
	@mkdir -p results
	ENV=dev $(K6_BINARY) run --out json=results/result.json test.js

# Ejecutar test en entorno staging
test-staging:
	ENV=staging $(K6_BINARY) run test.js

# Ejecutar test en entorno prod
test-prod:
	ENV=prod $(K6_BINARY) run test.js


# Limpiar binario local
clean:
	rm -rf ./bin/k6
	@echo "Limpieza completada. Binario eliminado."

# Mostrar ayuda
help:
	@echo "Comandos disponibles:"
	@echo "  make install       # Descargar e instalar K6 localmente"
	@echo "  make test-dev      # Ejecutar tests en entorno dev"
	@echo "  make test-staging  # Ejecutar tests en entorno staging"
	@echo "  make test-prod     # Ejecutar tests en entorno prod"
	@echo "  make clean         # Eliminar binario local"