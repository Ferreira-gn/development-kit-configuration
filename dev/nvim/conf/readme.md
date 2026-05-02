
## Objetivo

Este setup foi projetado para:

* Ser **leve em runtime**
* Não competir com serviços locais (Docker, Node, etc.)
* Funcionar como editor auxiliar no terminal
* Suportar múltiplas linguagens (TS, Go, Java/Spring, Nix, Docker, HTML/CSS)
* Ser **reprodutível via Nix**

---

## rquitetura

```
Nix (home.nix)
    ↓
instala dependências (LSPs, tools)
    ↓
Home Manager
    ↓
linka ~/.config/nvim
    ↓
Neovim (config Lua)
```

Separação de responsabilidades:

| Camada | Responsabilidade        |
| ------ | ----------------------- |
| Nix    | Instala dependências    |
| Neovim | Comportamento do editor |



## Estrutura

```
.
├── nix/
│   └── home.nix
└── dotfiles/
    └── nvim/
        ├── init.lua
        └── lua/
            ├── core/
            └── plugins/
```



## Dependências (Nix)

Gerenciadas via `home.nix`.

Inclui:

* Node + TypeScript LSP
* Go + gopls
* Java + jdtls
* Docker LSP
* Nix LSP (nil)
* Ferramentas CLI (git, ripgrep, fd)

**Importante:**
Não usamos installers como `mason.nvim`.



## Plugins principais

| Plugin         | Função                 |
| -------------- | ---------------------- |
| lazy.nvim      | Gerenciador de plugins |
| nvim-lspconfig | LSP                    |
| nvim-cmp       | Autocomplete           |
| treesitter     | Syntax highlight       |
| telescope      | Busca                  |
| gitsigns       | Git diff               |
| conform.nvim   | Formatter              |
| oil.nvim       | Navegação de arquivos  |





## Filosofia de performance

### 1. Lazy loading

Plugins só carregam quando necessário:

* LSP → ao abrir arquivo
* Telescope → ao usar comando
* CMP → ao entrar em insert mode



### 2. Sem processos em idle

```
Editor aberto
    ↓
Nenhuma atividade
    ↓
CPU ~0%
```



### 3. LSP sob demanda

```
Abrir arquivo TS → ativa tsserver
Abrir Go → ativa gopls
Abrir Java → ativa jdtls (pesado)
```

---

## Auto Save

Configurado para salvar ao sair do insert mode:

```
Insert → Esc → salva automaticamente
```

Evita:

* loops de save
* consumo excessivo de CPU


## Comportamento esperado


### Fluxo leve

```
Abrir arquivo pequeno
    ↓
Editar
    ↓
Fechar
```

Sem overhead.




### Fluxo com LSP

```
Abrir projeto
    ↓
LSP ativa automaticamente
    ↓
Autocomplete + diagnostics
```

