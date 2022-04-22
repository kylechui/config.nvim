# config.nvim

My Lua configuration for Neovim on Linux (some features work on Windows). I
mainly use this setup for [taking notes](https://github.com/kylechui/latex) and
doing homework in LaTeX, as well as programming in C++.
[Obligatory link to Castel's blog.](https://castel.dev/post/lecture-notes-1/)

## Screenshot

* Font: [JetBrains Mono Nerd
  Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/JetBrainsMono/Ligatures)
  (can be changed in
  [settings](https://github.com/kylechui/config.nvim/blob/f8ed82242dd8b55271ea2f3b453d15b9be8d5df9/lua/settings.lua#L13))

* Colorscheme: [kanagawa](https://github.com/rebelot/kanagawa.nvim)

* GUI: I use [Neovide](https://github.com/neovide/neovide) as my interface of
  choice

![nvim](./screenshot.png)

## Dependencies

* Requires [Neovim 0.7+](https://github.com/neovim/neovim/releases)
  for Lua integration
* Requires a PDF reader if you want to view compiled LaTeX documents:
  * Linux: [Zathura](https://pwmt.org/projects/zathura/)
  * Windows:
    [SumatraPDF](https://www.sumatrapdfreader.org/download-free-pdf-viewer)
* \[Optional] Requires Node.js and yarn for [live previewing markdown
  files](https://github.com/iamcco/markdown-preview.nvim)
  of choice

## Setup

I use [packer.nvim](https://github.com/wbthomason/packer.nvim) to manage all of
my packages. The general hierarchy for how things are configured is as follows:

    ftplugin
    └── ...
    queries
    └── ...
    lua
    ├── keybinds.lua
    ├── settings.lua
    ├── utils.lua
    └── plugins
        └── ...
    └── luasnippets
        └── ...

* `ftplugin/` -- Stores various settings for specific file types
* `queries/` -- Some scheme files for Tree-sitter parsing that define swappable
  groups, stored in `[fileType]/textobjects.scm`
* `keybinds.lua` -- Stores various key maps
* `settings.lua` -- General settings and options
* `utils.lua` -- Some helper functions
* `plugins/` -- A folder full of the configurations needed for each
  individual plugin, stored in the form `plugins/[pluginName].lua`
* `luasnippets/` -- My snippets configuration for each language I use, stored
  in the form `luasnippets/[fileType].lua`

## Todo

* Refactor code to make it cleaner
* Fix the jank that exists in some of the new API
* Add more snippets!
* Improve cross-compatibility with Windows
