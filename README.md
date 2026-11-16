# Registro eletrônico de testes rápidos · demonstração

Demonstração pública, com **dados 100% fictícios**, de um registro eletrônico para testes rápidos (dengue, COVID-19, influenza) e benzilpenicilina benzatina em unidade de saúde. Tudo roda no navegador: nada é enviado nem salvo.

Autor: Thiago Abranches, farmacêutico (CRF-SP 91811).

## O que há aqui

| Caminho | O que é |
|---|---|
| `index.html` | Explicação e validador interativo da **trava de dígitos verificadores** de CPF e CNS, com a conta passo a passo e amostras (CPF válido e inválido, CNS válido e inválido) |
| `app/*.html?robo=1` | Abre a demonstração já com o **robozinho guia**: um assistente que preenche o registro devagar, explicando cada passo (ou a pessoa pode preencher sozinha) |
| `app/enfermagem.html` | Demonstração do registro (perfil enfermagem). Usuário `enfermagem` ou `enfermagem2`, senha `demonstracao1`. Cada usuário vê só os próprios registros |
| `app/farmacia.html` | Demonstração do perfil farmácia (caixas e lotes, baixa assistida no GSS, usuários, exportação). Usuário `demo`, senha `demonstracao1` |
| `indicadores/index.html` | Painel de indicadores calculado no navegador a partir do CSV anonimizado (carrega também o seu próprio arquivo, sem enviá-lo a servidor) |
| `dados/registros_anonimos_exemplo.csv` | Registros **sintéticos** no formato exportado pelo sistema |
| `dados/resumo_mensal_exemplo.csv` | Resumo mensal por material (mesmo formato) |

## A trava dos dígitos verificadores

- **CPF**: o 10º dígito sai de `(soma dos 9 primeiros × pesos 10..2) × 10 mod 11` (10 vira 0); o 11º repete a conta com 10 dígitos e pesos 11..2. Sequências de dígitos iguais são recusadas.
- **CNS provisório (7, 8, 9)**: `soma dos 15 dígitos × pesos 15..1` precisa ser divisível por 11.
- **CNS definitivo (1, 2)**: os 11 primeiros dígitos (PIS) × pesos 15..5 geram o dígito final, depois do bloco `000` (ou `001` quando o dígito dá 10).

No sistema, um número inválido é apontado na hora, o salvamento exige confirmação explícita, o registro fica "A revisar" (fora da baixa) e há digitação em dobra.

**Limites**: número válido não prova que seja do paciente certo; erros de vários dígitos passam em ~1/100 (CPF) e ~1/11 (CNS); no CNS, a troca do 5º dígito (peso 11) nunca é detectada. Por isso a conferência do nome no GSS continua obrigatória.

## Indicadores sem dados pessoais

A versão da farmácia tem o botão **Exportar para indicadores**, que gera dois CSV sem nome, nascimento, CNS ou CPF:

1. `indicadores_registros_anonimos_AAAA-MM-DD.csv`: um registro por linha, com identificador embaralhado, data, material, lote, caixa, faixa etária, tipo e validade do documento, resultados, situação, data e dias até a baixa, posto.
2. `indicadores_resumo_mensal_AAAA-MM-DD.csv`: testes, baixados, pendentes, não encontrados, cancelados, números inválidos, % baixados, reagentes/NR/inválidos, % reagente, segundos testes e dias médios até a baixa, por mês e material.

Separador `;`, UTF-8 com BOM (abre direto no Excel pt-BR). Mesmo anonimizados, arquivos de unidades pequenas podem permitir reidentificação por combinação de data, faixa etária e posto: use internamente e agregue antes de publicar.

## Segurança do sistema real

Login individual, criptografia dos registros (AES-256-GCM, chaves protegidas por RSA-OAEP e por senha derivada com PBKDF2), nomes borrados, cada profissional vê só o que registrou, baixa restrita à farmácia. A pasta de rede precisa de permissões por grupo, proteção da pasta raiz, backup e auditoria pela TI.

## Publicar no GitHub Pages

1. Crie um repositório (por exemplo `registro-testes-demo`) e envie o conteúdo desta pasta para a raiz.
2. Em **Settings → Pages**, escolha **Deploy from a branch**, branch `main`, pasta `/ (root)`.
3. O site fica em `https://SEU-USUARIO.github.io/registro-testes-demo/`.

## Aviso

Demonstração educacional. Não substitui a validação da gerência, da TI e do encarregado de dados (LGPD) antes de qualquer uso com pacientes reais.
