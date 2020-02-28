set winaltkeys=no
set background=dark
colorscheme gruvbox

if has("nvim")
  GuiFont DejaVu\ Sans\ Mono\ for\ Powerline:h12
else
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12:cANSI
end

set lines=43
set columns=100
au BufRead,BufNewFile *.rb setlocal balloondelay=1000000
