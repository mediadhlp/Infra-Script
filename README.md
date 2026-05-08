Certifique que exista a pasta: /opt/script
se nao existir, crie - mkdir /opt/script
vá até a pasta: cd /opt/script

wget https://raw.githubusercontent.com/mediadhlp/Infra-Script/main/manutpihole.sh


## Permissão

chmod +x manutpihole.sh


## Execução

./manutpihole.sh

## Objetivo

Script para:
- limpeza do banco
- retenção de queries
- otimização sqlite
- manutenção Pi-hole

edite o cron e coloque para rodar a cada 60 dias no sábado às 00h
