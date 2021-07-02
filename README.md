# config.nvim
My Lua configuration for Neovim on Linux. I mainly use this setup for [taking
notes](https://github.com/kylechui/latex) and doing homework in LaTeX.
[Obligatory link to Castel's blog.](https://castel.dev/post/lecture-notes-1/)
## Screenshots
Coming soon... whenever I stop being lazy
## Dependencies
* Requires [Neovim 0.5+](https://github.com/neovim/neovim/releases/tag/v0.5.0)
  for Lua support in Neovim
* Requires Python 3 (and pynvim) for [UltiSnips](https://github.com/sirver/UltiSnips)
* [Optional] Requires Node.js and yarn for [live previewing markdown
  files](https://github.com/iamcco/markdown-preview.nvim)
* [Optional] I use [Neovide](https://github.com/Kethku/neovide) as my interface
  of choice for the animated cursor
#### Why UltiSnips?
To my knowledge, it is the only snippet manager out there that has convenient
regexp-based snippets *and* auto-expanding snippets. If there is another
snippet manager out there written in Lua or something that has both of the
aforementioned features, I'll probably switch to that.
