# nvim-config

Neovim 0.12+ configuration focused on Go, with optional language servers for Lua,
C/C++, Kotlin, JavaScript/TypeScript, HTML/CSS, YAML, Python, Java and Protobuf.

## Installation

Clone this repository into `~/.config/nvim` and start Neovim. The first launch
bootstraps lazy.nvim and installs the plugins recorded in `lazy-lock.json`.

A Nerd Font is needed for the configured icons. File and text search use `rg`.
Language servers, debuggers and formatters are separate tools: install the ones
needed for your languages through `:Mason` or your existing package manager.

For Go, the configured tools are `gopls`, `goimports-reviser` and `gofumpt`.
Debugging also requires Delve (`dlv`). Open Neovim from the Go module's directory
and save changes before debugging tests. Lua uses `lua-language-server` and `stylua`.

The configuration adds Mason's bin directory and `GOBIN` (or `GOPATH/bin`) to
Neovim's PATH before plugins initialize. Configured language servers start only
when their executable is available; restart Neovim after installing a server.

## Completion and hints

COQ v2 provides LSP, snippet, path and same-filetype buffer completion. Go, Lua
and C/C++ language-server results take priority. Tree-sitter words, tmux text,
registers, tags and third-party completion sources are disabled.

Go completion uses case-insensitive prefix matching. This avoids distant fuzzy
matches, at the cost of no longer matching arbitrary letters inside a name.

Completion documentation and search previews are hidden by default. Precognition
motion hints are also hidden; `Space p` toggles them, without the noisy `f`/`t`
labels. COQ's inline ghost text remains enabled.

| Key | Action |
| --- | --- |
| `Tab` / `Shift-Tab` | Select the next / previous completion |
| `Enter` | Accept the selected completion; insert a newline when none is selected |
| `Ctrl-y` | Accept the selected completion without a newline |
| `Ctrl-Space` | Trigger completion manually |
| `Ctrl-]` | Jump to the next snippet field |
| `Esc` | Dismiss completion and leave Insert mode |
| `Space p` | Toggle motion hints |

Enter and Backspace are shared with nvim-autopairs: accepting a completion does
not add a newline, while ordinary paired newlines and paired deletion still work.

## Navigation and editing

The leader key is Space.

| Key | Action |
| --- | --- |
| `Space ff` | Find files, including hidden files, respecting ignore rules |
| `Space fa` | Find files including ignored files; exclude `.git` contents |
| `Space fw` | Search text, including hidden files |
| `Space fd` / `Space pd` | Select a directory, then search its text / files |
| `Ctrl-n` | Toggle the file tree |
| `gd` / `gr` / `gi` | LSP definitions / references / implementations in Telescope |
| `Space ra` / `Space ca` | Rename / code action |
| `Space fm` | Format the current buffer |
| `Space ch` | Show keybindings with WhichKey |
| `Ctrl-\` | Toggle the floating terminal |
| `Tab` / `Shift-Tab` in Normal mode | Next / previous buffer |
| `za` / `zR` / `zM` | Toggle / open all / close all indent folds |

Conform formats on save, using an LSP formatter as a fallback when no configured
external formatter is available. `:ConformInfo` shows the active formatter and
its availability. Native EditorConfig support can override file-specific options.

## Debugging

| Key | Action |
| --- | --- |
| `Space db` / `Space dc` | Toggle breakpoint / continue |
| `Space dsi` / `Space dso` / `Space dst` | Step into / over / out |
| `Space dgt` | Debug the Go test under the cursor |
| `Space dgl` | Debug the last Go test |
| `Space dut` | Toggle the debugger UI |

DAP loads when requested or when Go's debugger integration is needed. DAP reads
`.vscode/launch.json` automatically; no manual launch-file import is necessary.

## Maintenance

- Use `:Lazy` for plugin updates and commit the resulting lockfile after checking
  completion, formatting and debugging. `:Lazy profile` shows plugin load costs.
- Updating go.nvim no longer installs its entire tool collection into `GOBIN`.
  Manage tool versions explicitly. Individual Go commands may still install a
  missing helper through go.nvim's own installer.
- Use `:checkhealth vim.lsp` in a source buffer to inspect language-server setup.
- Treesitter remains on `master`, matching its current configuration API and
  go.nvim settings. Switching to `main` requires a coordinated configuration
  migration. Missing configured parsers install asynchronously.

The existing Telescope and COQ setup is retained. Possible later migrations are
[blink.cmp](https://cmp.saghen.dev/configuration/sources), whose buffer source is
an LSP fallback by default, or [Snacks picker](https://github.com/folke/snacks.nvim/blob/main/docs/picker.md)
to consolidate Telescope and directory selection. These are alternatives, not
additional completion or picker layers enabled alongside the current ones.
Native [Neovim LSP completion](https://neovim.io/doc/user/lsp/#lsp-completion)
also passed the Go comparison, including LSP-provided snippets, but does not
replace COQ's separate path and snippet-pack sources.

## Regression checks

After installing the plugins, run this from the configuration directory:

```sh
nvim --headless -i NONE -c "luafile tests/editing.lua"
```

The checks drive real Insert-mode input: selected and unselected completion,
Enter, Backspace, paired brackets and quotes, and the existing cursor mappings.
They use a scratch buffer and do not require a running language server.
