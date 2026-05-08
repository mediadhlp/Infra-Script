!/bin/bash

DATA=$(date +%F_%H-%M)

DB="/etc/pihole/pihole-FTL.db"

echo "=== Iniciando manutenção Pi-hole: $DATA ==="

echo "[1] Verificando sqlite3"

if ! command -v sqlite3 >/dev/null 2>&1; then
    echo "sqlite3 não encontrado. Instalando..."
    apt update -qq
    apt install sqlite3 -y
else
    echo "sqlite3 já instalado."
fi

echo "[2] Aplicando retenção de 30 dias"
pihole-FTL --config database.maxDBdays 30

echo "[3] Desativando query logging detalhado"
pihole-FTL --config dns.queryLogging false

echo "[4] Parando Pi-hole FTL"
systemctl stop pihole-FTL

echo "[5] Apagando registros anteriores a 30 dias e compactando banco"
sqlite3 "$DB" "DELETE FROM query_storage WHERE timestamp < strftime('%s','now','-30 days'); VACUUM;"

echo "[6] Ajustando permissões"
chown pihole:pihole "$DB"
chmod 640 "$DB"

echo "[7] Iniciando Pi-hole FTL"
systemctl start pihole-FTL

echo "[8] Status final"
systemctl --no-pager status pihole-FTL

echo "[9] Tamanho final do banco"
ls -lh "$DB"

echo "=== Finalizado ==="        
