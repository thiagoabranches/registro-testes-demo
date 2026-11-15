@echo off
REM Publica este site no GitHub (cria o repositório publico registro-testes-demo e liga o GitHub Pages)
REM Requisito: GitHub CLI instalado (https://cli.github.com) e "gh auth login" feito uma vez.
gh repo create registro-testes-demo --public --source=. --remote=origin --push --description "Demonstrativo do registro eletronico de testes rapidos (dados ficticios) - trava de digitos verificadores de CPF/CNS e indicadores"
gh api -X POST repos/thiagoabranches/registro-testes-demo/pages -f "source[branch]=main" -f "source[path]=/"
echo.
echo Site: https://thiagoabranches.github.io/registro-testes-demo/
pause
