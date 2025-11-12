#!/bin/bash

API_URL="https://cointradermonitor.com/api/pbb/v1/ticker"

LIMITE_PRECO="539936.71"

echo "Verificando API: $API_URL"
echo "Limite de alerta definido em: R$ $LIMITE_PRECO"

PRECO_ATUAL=$(curl -s  $API_URL | jq -r '.last')

if ! [[ "$PRECO_ATUAL" =~ ^[0-9.]+$  ]]; then
	echo "FALHA AO OBTER PREçO."
	echo "Resposta recebida: $PRECO_ATUAL"
	exit 1
fi	

echo "Preço atual do BITCOIN: R$ $PRECO_ATUAL"

if (( $(echo "$PRECO_ATUAL < $LIMITE_PRECO" | bc -l) )); then
	echo "ALERTA! o preço  (R$ $PRECO_ATUAL) esta abaixo do limite (R$ $LIMITE_PRECO)"
	exit 1
else 
	echo "Tudo OK. O preço (R$ $PRECO_ATUAL) está acima do limite (R$ $LIMITE_PRECO)"
	exit 0
fi	

