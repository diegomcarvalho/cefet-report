# cefet-article

[![Quarto](https://img.shields.io/badge/Quarto-%3E%3D1.7.24-blue)](https://quarto.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**cefet-article** é uma extensão do Quarto para a geração de documentos de pesquisa e técnico-institucionais no padrão visual do **Cefet/RJ**. O formato é baseado na classe LaTeX `extarticle`, compilada com LuaLaTeX, e suporta saída em **PDF** (padrão A-2b) e **HTML**.

---

## Pré-requisitos

| Ferramenta | Versão mínima |
|---|---|
| [Quarto](https://quarto.org/docs/download/) | ≥ 1.7.24 |
| [LuaLaTeX](https://www.tug.org/texlive/) | TexLive 2023+ ou MiKTeX |
| Fontes: Sofia Sans Condensed, Roboto, Roboto Mono | Instaladas no sistema |

---

## Instalação

### Novo documento (recomendado)

Use o template diretamente para criar um novo projeto:

```bash
quarto use template diegomcarvalho/cefet-article
```

Isso instala a extensão e cria os arquivos `template.qmd` e `bibliography.bib` como ponto de partida.

### Projeto existente

Para adicionar o formato a um projeto Quarto já existente:

```bash
quarto add diegomcarvalho/cefet-article
```

---

## Uso rápido

Após a instalação, renderize o documento com:

```bash
# Gerar PDF (padrão)
quarto render meu-relatorio.qmd --to crt-pdf

# Gerar HTML
quarto render meu-relatorio.qmd --to crt-html

# Gerar ambos
quarto render meu-relatorio.qmd
```

---

## Estrutura do YAML (cabeçalho do `.qmd`)

O cabeçalho YAML controla todos os metadados e as opções de formatação do documento. Abaixo está a referência completa de cada parâmetro:

### Metadados do documento

```yaml
title: "Título do Relatório"
lang: pt                          # Idioma principal (pt, en, es)
region: BR                        # Região para hifenização e locale
date: "Janeiro 2026"              # Data de publicação (texto livre)
jornalinfo: "Cefet/RJ, DIGES, PRJ, 2026"  # Informação de rodapé/cabeçalho
admunit: Diretoria de Gestão Estratégica   # Unidade administrativa responsável
abstract: "Resumo do documento..."         # Resumo executivo (texto corrido)
keywordname: "Palavras-chave"              # Rótulo da seção de palavras-chave
keywords:
  - Palavra um
  - Palavra dois
```

| Parâmetro | Tipo | Obrigatório | Descrição |
|---|---|---|---|
| `title` | string | ✅ | Título principal do documento |
| `lang` | código ISO | ✅ | Idioma (`pt`, `en`, `es`) |
| `region` | código ISO | ✅ | Região para locale (`BR`, `US`, `PT`) |
| `date` | string | ✅ | Data de publicação (texto livre) |
| `jornalinfo` | string | ✅ | Aparece no cabeçalho lateral do PDF |
| `admunit` | string | ✅ | Unidade administrativa responsável |
| `abstract` | string | ✅ | Resumo executivo do documento |
| `keywordname` | string | ⬜ | Rótulo acima das palavras-chave (padrão: `"Palavras-chave"`) |
| `keywords` | lista | ⬜ | Lista de palavras-chave |

### Autores e afiliações

```yaml
author:
  - name: Nome Completo
    orcid: 0000-0000-0000-0000      # ORCID (opcional, gera ícone automático)
    affiliations:
      - ref: 1                      # Referência ao id em `affiliations:`
    current-address: "Endereço"     # Endereço atual do autor
    corresponding: true             # Indica autor correspondente
    email: autor@cefet-rj.br

email:
  ref: 1                            # id do autor correspondente
  stringcontato: "Contato: "        # Rótulo antes do e-mail
  emailcontato: autor@cefet-rj.br   # E-mail de contato exibido

affiliations:
  - id: 1                           # ID referenciado em author.affiliations
    name: Nome da Unidade
    city: Rio de Janeiro
    # state: RJ                     # Opcional
    # country: Brasil               # Opcional
```

### Formato de saída

```yaml
format:
  crt-pdf:
    keep-tex: true                  # Mantém o .tex intermediário (útil para debug)
    classoption:
      - fleqn                       # Equações alinhadas à esquerda
      - 9pt                         # Tamanho de fonte (8pt, 9pt, 10pt, 11pt, 12pt)
      - twocolumn                   # Layout em duas colunas (ou: onecolumn)
    bibliography: bibliography.bib  # Arquivo de referências BibTeX
```

| Opção `classoption` | Descrição |
|---|---|
| `twocolumn` | Duas colunas (padrão do formato) |
| `onecolumn` | Coluna única (ideal para relatórios longos) |
| `fleqn` | Equações alinhadas à esquerda |
| `9pt` / `10pt` / `11pt` | Tamanho base da fonte |

---

## Exemplo mínimo de cabeçalho

```yaml
---
title: "Relatório de Atividades 2026"
lang: pt
region: BR
date: "Junho 2026"
jornalinfo: "Cefet/RJ, DIGES, 2026"
admunit: Diretoria de Gestão Estratégica
abstract: "Este relatório apresenta as atividades desenvolvidas no primeiro semestre de 2026."
keywords:
  - Gestão Institucional
  - Relatório
author:
  - name: Diego Carvalho
    corresponding: true
    email: diego.carvalho@cefet-rj.br
    affiliations:
      - ref: 1
affiliations:
  - id: 1
    name: DIGES/Cefet/RJ
    city: Rio de Janeiro
format:
  crt-pdf:
    keep-tex: false
    classoption: [9pt, twocolumn]
    bibliography: bibliography.bib
---
```

---

## Recursos do Markdown suportados

O template suporta toda a sintaxe Markdown padrão do Quarto, incluindo:

- **Negrito**, *itálico*, `código inline`
- Listas ordenadas e não ordenadas
- Tabelas GFM
- Notas de rodapé `[^1]`
- Citações bibliográficas `[@chave]`
- Figuras com legenda: `![Legenda](figura.png){#fig-id}`
- Diagramas Mermaid via bloco de código ` ```{mermaid} `
- Equações LaTeX inline `\( x^2 \)` e em bloco `\[ E = mc^2 \]`
- Callouts Quarto: `:::{.callout-note}` etc.

---

## Bugs conhecidos

- Layout em **coluna única** (`onecolumn`) apresenta comportamento irregular no posicionamento do título — correção em andamento.

---

## Licença

Distribuído sob a licença [MIT](LICENSE). © 2026 Diego Carvalho — CEFET/RJ.
