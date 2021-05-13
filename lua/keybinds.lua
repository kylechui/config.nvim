local map = vim.api.nvim_set_keymap
-- Set up <Space> to be the global leader
map('n', '<Space>', '<NOP>', { noremap = true, silent = true })
vim.g.mapleader = ' '
-- Keybinds for editing and sourcing init files
map('n', '<Leader>s', '<Cmd>lua require(\'pluginSettings.telescope\').search_dotfiles()<CR>', { noremap = true, silent = true })
map('n', '<Leader>r', '<Cmd>luafile $MYVIMRC<CR>', { noremap = true })
-- Edit snippets
map('n', '<Leader>u', '<Cmd>UltiSnipsEdit<CR>', { noremap = true, silent = true })
-- Open Todo List
map('n', '<Leader>t', '<Cmd>e ~/Documents/github/Todo.txt<CR>', { noremap = true, silent = true })
-- Saving files with <C-s>
map('n', '<C-s>', '<Cmd>up!<CR>', { noremap = true, silent = true })
map('i', '<C-s>', '<Esc><Cmd>up!<CR>', { noremap = true, silent = true })
map('v', '<C-s>', '<Esc><Cmd>up!<CR>', { noremap = true, silent = true })
-- Deleting words with <C-BS>
map('i', '', '<C-w>', { noremap = true, silent = true })
map('c', '', '<C-w>', { noremap = true, silent = true })
map('i', '<C-BS>', '<C-w>', { noremap = true, silent = true })
map('c', '<C-BS>', '<C-w>', { noremap = true, silent = true })
-- Open/close file explorer
map('n', '<C-\\>', '<Esc><Cmd>NvimTreeToggle<CR>', { noremap = true, silent = true })
-- Move towards the beginning/end of a line
map('n', 'H', 'g^', { noremap = true, silent = true })
map('v', 'H', 'g^', { noremap = true, silent = true })
map('n', 'L', 'g_', { noremap = true, silent = true })
map('v', 'L', 'g_', { noremap = true, silent = true })
-- Indent/dedent blocks fo text
map('v', '>', '>gv', { noremap = true, silent = true })
map('v', '<', '<gv', { noremap = true, silent = true })
-- Make Y actually make sense
map('n', 'Y', 'y$', { noremap = true, silent = true })
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
-- Telescope fuzzy find stuff
map('n', '<Leader>f.', '<Cmd>lua require(\'telescope.builtin\').find_files()<CR>', { noremap = true, silent = true })
map('n', '<Leader>ff', '<Cmd>lua require(\'pluginSettings.telescope\').search_workspace()<CR>', { noremap = true, silent = true })
map('n', '<Leader>fb', '<Cmd>lua require(\'telescope.builtin\').buffers()<CR>', { noremap = true, silent = true })
map('n', '<Leader>fg', '<Cmd>lua require(\'telescope.builtin\').live_grep()<CR>', { noremap = true, silent = true })
map('n', '<Leader>fh', '<Cmd>lua require(\'telescope.builtin\').help_tags()<CR>', { noremap = true, silent = true })
-- Moving lines up and down
map('n', 'J', '<Cmd>m+<CR>', { noremap = true, silent = true })
map('v', 'J', ':m \'>+1<CR>gv', { noremap = true, silent = true })
map('n', 'K', '<Cmd>m-2<CR>', { noremap = true, silent = true })
map('v', 'K', ':m \'<-2<CR>gv', { noremap = true, silent = true })
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
-- Stop the mouse from going into visual mode
map('n', '<LeftDrag>', '<LeftMouse>', { noremap = true, silent = true })
map('n', '<LeftRelease>', '<LeftMouse>', { noremap = true, silent = true })
-- Better deletion of visual selections
map('v', '<Leader>p', '"_dP', { noremap = true, silent = true })
-- Spell check
map('i', '<C-l>', '<C-g>u<ESC>b[s1z=`]a<C-g>u', { noremap = true, silent = true })
-- Smart carriage return
map('i' , '<CR>','v:lua.MUtils.smart_cr()', {expr = true , noremap = true})
