#!/usr/bin/env bash
set -e
gh repo create registro-testes-demo --public --source=. --remote=origin --push \
  --description "Demonstrativo do registro eletronico de testes rapidos (dados ficticios) - trava de digitos verificadores de CPF/CNS e indicadores"
gh api -X POST repos/thiagoabranches/registro-testes-demo/pages -f "source[branch]=main" -f "source[path]=/"
echo "Site: https://thiagoabranches.github.io/registro-testes-demo/"
