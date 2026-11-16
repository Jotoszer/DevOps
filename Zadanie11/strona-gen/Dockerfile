# --- Stadium 1: generowanie treści ---
FROM debian:bookworm-slim AS generator
WORKDIR /praca
COPY generuj.sh .
COPY dane/ ./dane/
RUN chmod +x generuj.sh \
    && ./generuj.sh dane/uslugi.csv /wynik

# --- Stadium 2: kontrola jakości wygenerowanej treści ---
FROM debian:bookworm-slim AS kontrola
RUN apt-get update \
    && apt-get install -y --no-install-recommends tidy \
    && rm -rf /var/lib/apt/lists/*
COPY --from=generator /wynik /wynik
RUN tidy -q -e /wynik/index.html || true

# --- Stadium 3: obraz wykonawczy ---
FROM nginx:1.27-alpine AS runtime
COPY --from=generator /wynik/ /usr/share/nginx/html/
COPY nginx-serwis.conf /etc/nginx/conf.d/default.conf
EXPOSE 8080
STOPSIGNAL SIGQUIT
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
    CMD wget -q --spider http://localhost:8080/ || exit 1
