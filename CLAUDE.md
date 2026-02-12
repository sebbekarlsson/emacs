# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Emacs configuration (~640 lines of custom elisp) for GNU Emacs 31.0.50. Evil mode (Vim emulation) is the primary input method. Uses `use-package` with MELPA for package management.

## Architecture

```
init.el                  # Entry point: loads v2/ modules, sets global defaults
early-init.el            # Pre-package init: disables UI chrome, GC optimization
v2/
  core.el                # Bootstrap package.el + use-package, configure repos
  packages.el            # All package declarations (use-package blocks)
  hooks.el               # Mode hooks and language-specific settings (C style, Python, JS/TS)
  keybinds.el            # Custom keybindings and small utility functions
  configs/c.el           # Additional C config
  langstyles/clang/      # Language style files
```

Packages auto-install from MELPA on first load. LSP servers auto-install to `.cache/lsp/npm/`. No build scripts or Makefile — Emacs handles everything on startup.

## Key Design Decisions

- **Completion stack:** Vertico (minibuffer) + Company (in-buffer, aggressive: 0.005s delay, 1-char prefix)
- **LSP:** lsp-mode with lsp-ui. Active servers: clangd (C/C++), basedpyright (Python), typescript-language-server (JS/TS). Disabled clients: deno-ls, pylsp
- **C/C++ style:** Custom "better-c-style" based on Linux style with 2-space indentation, no tabs, extensive offset customization in `hooks.el`
- **Web-mode:** Handles .ts, .js, .jsx, .tsx, .mts, .mjs files with 2-space indent
- **Evil integrations:** evil-collection, evil-multiedit (M-d workflow), undo-tree
- **UI:** doom-one theme, doom-modeline, no menu/tool/scroll bars, global line numbers

## Important Keybinding Prefixes

- `C-c l` — LSP commands
- `C-c c` — Claude Code
- `F8` — Toggle Treemacs
- `M-d` / `M-D` — Multiedit next/previous occurrence
- `gd` — Go to definition (Evil normal mode)
- `M-<arrow>` — Window navigation

## When Editing This Config

- All package declarations go in `v2/packages.el` as `use-package` blocks with `:ensure t` (globally set)
- Language/mode-specific hooks go in `v2/hooks.el`
- Keybindings go in `v2/keybinds.el`
- The `.gitignore` excludes `elpa/`, `.cache/`, `eln-cache/`, and temp files — only track source config files
