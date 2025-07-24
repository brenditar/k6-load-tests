# Makefile para proyecto K6 Load Testing

.PHONY: install install-linux install-mac test-dev test-staging test-prod clean help

# Variables
K6_VERSION = 0.49.0
K6_BINARY = ./bin/k6

# 🔽 Instalar K6 para Linux
install-linux:
	@echo "🔽 Descargando K6 v$(K6_VERSION) para Linux..."
	curl -L https://github.com/grafana/k6/releases/download/v$(K6_VERSION)/k6-v$(K6_VERSION)-linux-amd64.tar.gz -o k6.tar.gz
	tar -xzf k6.tar.gz
	mkdir -p bin
	mv k6-v$(K6_VERSION)-linux-amd64/k6 $(K6_BINARY)
	chmod +x $(K6_BINARY)
	rm -rf k6-v$(K6_VERSION)-linux-amd64 k6.tar.gz
	@echo "✅ K6 instalado en $(K6_BINARY)"

# 🍏 Instalar K6 para macOS (Intel o Apple Silicon detectado automáticamente)
install-mac:
	@echo "🔽 Detectando arquitectura..."
	ARCH=$$(uname -m); \
	if [ "$$ARCH" = "arm64" ]; then \
		FILE=k6-v$(K6_VERSION)-macos-arm64.zip; \
	else \
		FILE=k6-v$(K6_VERSION)-macos-amd64.zip; \
	fi; \
	echo "🔽 Descargando $$FILE..."; \
	curl -L https://github.com/grafana/k6/releases/download/v$(K6_VERSION)/$$FILE -o k6.zip; \
	unzip -o k6.zip; \
	mkdir -p bin; \
	mv k6-*/k6 $(K6_BINARY); \
	chmod +x $(K6_BINARY); \
	rm -rf k6-* k6.zip; \
	echo "✅ K6 instalado en $(K6_BINARY)"

# Alias general que detecta el sistema operativo
install:
	@if [ "$$(uname)" = "Darwin" ]; then \
		$(MAKE) install-mac; \
	else \
		$(MAKE) install-linux; \
	fi

# Ejecutar test en entorno dev
test-dev:
	@mkdir -p results
	ENV=dev $(K6_BINARY) run test.js

# Ejecutar test en entorno staging
test-staging:
	ENV=staging $(K6_BINARY) run test.js

# Ejecutar test en entorno prod
test-prod:
	ENV=prod $(K6_BINARY) run test.js

# Limpiar binario local
clean:
	rm -rf ./bin/k6
	@echo "🧹 Limpieza completada. Binario eliminado."

# Mostrar ayuda
help:
	@echo "🛠️ Comandos disponibles:"
	@echo "  make install        # Detecta OS e instala K6 automáticamente"
	@echo "  make install-linux  # Instala K6 en Linux"
	@echo "  make install-mac    # Instala K6 en macOS (Intel o M1/M2)"
	@echo "  make test-dev       # Ejecutar tests en entorno dev"
	@echo "  make test-staging   # Ejecutar tests en entorno staging"
	@echo "  make test-prod      # Ejecutar tests en entorno prod"
	@echo "  make clean          # Eliminar binario local"