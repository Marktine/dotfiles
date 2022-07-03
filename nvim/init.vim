lua require('plugins')
lua require('lsp')
lua require('cmp-config')
lua require('trouble-config')

set smartindent
set tabstop=2
set expandtab
set shiftwidth=2
let mapleader = ","
set number

" Telescope key mapping
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
