# Jakhon's Neovim configuration

Requires Neovim 0.11.3+ (validated with 0.12.3), Git, a C compiler, Python 3 and Node.js/npm. A Nerd Font is useful for UI icons.

## Layout

- `lua/jakhon/remap.lua`: existing general keymaps and leader.
- `lua/jakhon/set.lua`: editor options.
- `lua/jakhon/autocmds.lua`: filetypes, indentation, whitespace and buffer-local LSP keymaps.
- `lua/jakhon/lazy_init.lua`: Lazy bootstrap.
- `lua/jakhon/lazy/`: plugin specs; completion, LSP, formatting and diagnostic UI each have one owner.
- `lua/jakhon/python.lua`: Python environment discovery.
- `lua/jakhon/format.lua`: deterministic formatter selection.
- `lua/jakhon/tools.lua`: Mason package list and installation.
- `lua/jakhon/snippets.lua`: Django/DRF/FastAPI snippets.

The historical `lazy/` directory name is retained. Lualine is the single statusline provider. Empty/duplicate plugin specs have been removed.

## Language support

| Files | Language tools | `<leader>gf` |
| --- | --- | --- |
| Python / Django / DRF / FastAPI | Pyright types/completion; Ruff lint/code actions | Ruff |
| Django templates (`htmldjango`) | HTML LSP, djLint diagnostics, Treesitter | djLint with Django profile |
| HTML / CSS / SCSS / Less | HTML/CSS LSP | Prettier |
| JavaScript / TypeScript / JSX / TSX | TypeScript language server | Prettier |
| C / C++ | clangd with clang-tidy | clangd |
| JSON / JSONC / YAML / Markdown | JSON LSP or Marksman where applicable | Prettier |
| Lua | Lua language server | StyLua |

Mason installs the configured servers and formatter executables automatically when a file opens. Use `:MasonToolsInstall` to retry, `:Mason` to inspect packages, and `:MasonLog` for installation failures. Treesitter installs missing configured parsers on startup. Wait for installation and reopen Neovim after the first setup.

Formatting is manual; saving only removes trailing whitespace, except in Markdown. Python and Django templates use four-space indentation; other web files use two spaces. Project formatter settings (`pyproject.toml`, `ruff.toml`, `.prettierrc`, `.clang-format`, etc.) remain authoritative for formatting.

## Python projects

Create the project's environment in `.venv`, `venv`, or `env` and install its dependencies there. Pyright first uses an activated `VIRTUAL_ENV` or `CONDA_PREFIX`. Without an activated environment, it discovers these directories from the LSP project root up to the repository boundary, then falls back to Python on PATH. Poetry/uv environments outside the project should be activated before opening Neovim. Use `:PythonInfo` to see the environment inherited by Neovim, the actual Pyright interpreter and whether Django/DRF/FastAPI are installed there. Activating an environment inside ToggleTerm does not change the parent Neovim process. Reopen Neovim from the activated shell after changing environments. For a running client, `:LspPyrightSetPythonPath /absolute/path/to/venv/bin/python` changes the interpreter without changing hotkeys.

`Ctrl+\` opens a floating shell and activates the virtualenv selected for the originating Python buffer (including a manually selected Pyright interpreter). Without a Python client, it uses the active shell environment or a project venv. Activation runs only when a new terminal is created; hiding/reopening keeps running jobs intact. To change the environment of an existing terminal, run `exit` and open it again.

Django, DRF, FastAPI, Pydantic and your project's other packages belong in that environment; Mason installs editor tools, not application dependencies. Django ORM's dynamic behavior can limit static type inference. `django-stubs` / `djangorestframework-stubs` are optional project dependencies; they do not make Pyright equivalent to Django's mypy plugin.

HTML beneath a `manage.py` ancestor, or with template tags in its first 100 lines, is classified as `htmldjango`. For unusual layouts use `:setfiletype htmldjango` before formatting. Generic Jinja files also use this detection; a separate Jinja profile can be added for projects that require it.

Custom Python snippet triggers: `djmodel`, `drfserializer`, `drfviewset`, `fastapi`, `apiroute`, `pydmodel`. Select a snippet from completion or expand with Tab; Tab/Shift-Tab move through snippet fields when the completion menu is closed. Class snippets assume the appropriate imports already exist. Friendly Snippets provides additional Python/HTML snippets.

## C / C++ projects

For accurate include paths, compiler flags and macros, generate `compile_commands.json` with your build system. For CMake, configure with `-DCMAKE_EXPORT_COMPILE_COMMANDS=ON`; clangd searches a `build/` directory automatically. Other build directory names can be exposed with a root-level symlink to the database. Simple standalone files work with clangd's fallback flags.

## Existing keys

Leader is Space. Existing keys and navigation directions are preserved, including `[d` → next and `]d` → previous.

| Keys | Action |
| --- | --- |
| `<leader>pv`, `<C-n>` | netrw, Neo-tree toggle |
| `<leader>ff`, `<C-p>`, `<leader>ps` | files, Git files, text search |
| `gd`, `K` | definition, hover |
| `<leader>vws`, `<leader>vd` | workspace symbols, diagnostic float |
| `<leader>vca`, `<leader>vrr`, `<leader>vrn` | code actions, references, rename |
| `<C-h>` in insert mode | signature help |
| `[d`, `]d` | next / previous diagnostic |
| `<leader>gf` | format current buffer |
| `<leader>tt`, `[t`, `]t` | Trouble diagnostics toggle, next / previous item |
| `<leader>gs`, `<leader>b` | Fugitive, blame toggle |
| `<leader>u`, `<C-\>` | undo tree, floating terminal |
| Tab / Shift-Tab, `<C-Space>`, Enter, Escape | completion/snippet navigation, completion, confirm, abort |

The remaining editing, clipboard, quickfix, substitution and reload mappings are unchanged in `remap.lua`.
