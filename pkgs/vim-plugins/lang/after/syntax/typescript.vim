" Fixes vim/vim#11652
"
" Fix ported from yats.vim:
"   HerringtonDarkholme/yats.vim@f3ae3fc91696bd6e16586a5c95c88a5f9c6ff7c6
syntax keyword typescriptImport                import
  \ nextgroup=typescriptImportType,typescriptTypeBlock
  \ skipwhite

syntax region  typescriptTypeBlock
  \ matchgroup=typescriptBraces
  \ start=/{/ end=/}/
  \ contained
  \ contains=typescriptIdentifierName,typescriptImportType
  \ fold
