local map = vim.api.nvim_set_keymap
-- Set up <Space> to be the global leader
map('n', '<Space>', '<NOP>', { noremap = true, silent = true })
vim.g.mapleader = ' '
-- Keybinds for editing and reloading init files
map('n', '<Leader>s', '<Cmd>lua require(\'pluginSettings.telescope\').search_dotfiles()<CR>', { noremap = true, silent = true })
map('n', '<Leader>r', '<Cmd>luafile $MYVIMRC<CR>', { noremap = true })
-- Edit snippets
map('n', '<Leader>u', '<Cmd>UltiSnipsEdit<CR>', { noremap = true, silent = true })
-- Saving files with <C-s>
map('n', '<C-s>', '<Cmd>up!<CR>', { noremap = true, silent = true })
map('i', '<C-s>', '<Esc><Cmd>up!<CR>', { noremap = true, silent = true })
map('v', '<C-s>', '<Esc><Cmd>up!<CR>', { noremap = true, silent = true })
-- Deleting words with <C-BS>
map('i', '', '<C-w>', { noremap = true, silent = true })
map('c', '', '<C-w>', { noremap = true, silent = true })
map('i', '<C-BS>', '<C-w>', { noremap = true, silent = true })
map('c', '<C-BS>', '<C-w>', { noremap = true })
-- Open/close file explorer
map('n', '<C-\\>', '<Esc><Cmd>NvimTreeToggle<CR>', { noremap = true, silent = true })
-- Move towards the beginning/end of a line
map('n', 'H', 'g^', { noremap = true, silent = true })
map('v', 'H', 'g^', { noremap = true, silent = true })
map('n', 'L', 'g$', { noremap = true, silent = true })
map('v', 'L', 'g$', { noremap = true, silent = true })
-- Better indent/dedent lines and blocks of text
map('n', '>', '>>', { noremap = true, silent = true })
map('n', '<', '<<', { noremap = true, silent = true })
map('v', '>', '>gv', { noremap = true, silent = true })
map('v', '<', '<gv', { noremap = true, silent = true })
-- Make Y actually make sense
map('n', 'Y', 'yg$', { noremap = true, silent = true })
-- Better buffer navigation/deletion
map('n', '<Leader>j', '<Cmd>bn<CR>', { noremap = true, silent = true })
map('n', '<Leader>k', '<Cmd>bp<CR>', { noremap = true, silent = true })
map('n', '<C-Tab>', '<Cmd>bn<CR>', { noremap = true, silent = true })
map('n', '<C-S-Tab>', '<Cmd>bp<CR>', { noremap = true, silent = true })
map('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
map('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
map('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
map('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
map('n', '<C-w>', '<Cmd>bd!<CR>', { noremap = true, silent = true })
map('i', '<C-w>', '<Cmd>bd!<CR>', { noremap = true, silent = true })
map('n', '<A-h>', '<Cmd>BufferLineMovePrev<CR>', { noremap = true, silent = true })
map('n', '<A-l>', '<Cmd>BufferLineMoveNext<CR>', { noremap = true, silent = true })
-- Telescope fuzzy find stuff
map('n', '<Leader>f.', '<Cmd>lua require(\'telescope.builtin\').find_files()<CR>', { noremap = true, silent = true })
map('n', '<Leader>ff', '<Cmd>lua require(\'pluginSettings.telescope\').search_workspace()<CR>', { noremap = true, silent = true })
map('n', '<Leader>fb', '<Cmd>lua require(\'telescope.builtin\').buffers()<CR>', { noremap = true, silent = true })
map('n', '<Leader>fg', '<Cmd>lua require(\'telescope.builtin\').live_grep()<CR>', { noremap = true, silent = true })
map('n', '<Leader>fh', '<Cmd>lua require(\'telescope.builtin\').help_tags()<CR>', { noremap = true, silent = true })
-- Navigate by wrapped lines by default
map('n', 'j', 'v:count ? (v:count > 5 ? "m\'" . v:count : \'\') . \'j\' : \'gj\'', { noremap = true, silent = true, expr = true })
map('n', 'k', 'v:count ? (v:count > 5 ? "m\'" . v:count : \'\') . \'k\' : \'gk\'', { noremap = true, silent = true, expr = true })
map('v', 'j', 'v:count ? (v:count > 5 ? "m\'" . v:count : \'\') . \'j\' : \'gj\'', { noremap = true, silent = true, expr = true })
map('v', 'k', 'v:count ? (v:count > 5 ? "m\'" . v:count : \'\') . \'k\' : \'gk\'', { noremap = true, silent = true, expr = true })
-- Universal comments with <C-/>
map('n', '<C-/>', '<Plug>kommentary_line_default', {})
map('v', '<C-/>', '<Plug>kommentary_visual_default', {})
-- Allow for repeating commands in visual mode
map('v', '.', ':normal.<CR>', { noremap = true, silent = true })
-- Better deletion of visual selections
map('v', '<Leader>p', '"_dP', { noremap = true, silent = true })
-- Spell check
map('i', '<C-l>', '<C-g>u<ESC>b[s1z=`]a<C-g>u', { noremap = true, silent = true })
-- Smart carriage return
map('i' , '<CR>', 'v:lua.MUtils.smart_cr()', { expr = true , noremap = true })
-- Git binds
map('n' , '<Leader>g', '<Cmd>Git<CR>', { noremap = true })
map('n' , '<Leader>gp', '<Cmd>Git push<CR>', { noremap = true })
-- Font size adjustment
map('n' , '<C-=>', '<Cmd>lua require(\'utils\').adjust_font_size(1)<CR>', { noremap = true })
map('n' , '<C-->', '<Cmd>lua require(\'utils\').adjust_font_size(-1)<CR>', { noremap = true })
-- LSP nonsense
map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
-- Select all
map('n', '<C-a>', 'ggVG', { noremap = true, silent = true })
map('i', '<C-a>', '<Esc>ggVG', { noremap = true, silent = true })
-- Disable ex mode
map('n', 'Q', '<NOP>', { noremap = true, silent = true })
