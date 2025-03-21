# My Neovim config

My personal lsp config for neovim
I use Windows and NixOS and this config is compatalbe with both OS

# English

## Required programs

1. latest neovim or nightly version of neovim
1. `fd` for Snacks picker
1. `ripgrep` for Snacks picker
1. `npm(node)` for installing treesitter languages

## TODO

- [x] fix nix completion for nix files.
- [ ] add lsps for web development
- [x] try cmp-nvim for nix lsps

Using neovim with Neovide for gui

# Completion

Currently using blink.cmp for completion.
But blink-cmp currently seems unstable for using with nix lsps, so planning to use cmp-nvim with
nix lsps

# Korean 한글

## 필요한 프로그램

1. 최신 버전의 neovim 혹은 nightly 버전의 neovim
1. Snacks picker에서 사용할 `fd`
1. Snacks picker에서 사용할 `ripgrep`
1. treesitter 언어 설치에 사용할 `node(npm)`

## 할 일
---
- [x] nix 파일들에 사용할 nix자동완성 고치기
- [ ] 웹 개발에 사용할 lsp 설치하기
- [x] nix lsp에 cmp-nvim사용해보기.
