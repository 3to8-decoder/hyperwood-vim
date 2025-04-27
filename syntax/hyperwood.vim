" Vim syntax file
" Language: Hyperwood Exchange Format
" Maintainer: 3to8-decoder
" Latest Revision: 2025-04-27
if exists("b:current_syntax")
  finish
endif
" Case sensitive
syntax case match

"""""" HEADER:
syntax match hefHeader /^Hyperwood Exchange Format$/
syntax match hefVersion /^Version 1$/
syntax match hefHomepage /^\(https:\/\/\)\?hyperwood\.org$/ nextgroup=hefModelName skipnl
" Model name (line 4)
syntax match hefModelName /^[A-Za-z][A-Za-z ]*$/ contained
" Header colors:
highlight default link hefHeader Comment
highlight default link hefVersion Comment
highlight default link hefHomepage Comment
highlight default link hefModelName Title


"""""" JSON stuff:
" JSON sections (lines 5-7)
syntax region hefParameters start=/{/ end=/}/ contains=hefJSONKey,hefJSONString,hefJSONNumber
syntax region hefVariant start=/{/ end=/}/ contains=hefJSONKey,hefJSONString,hefJSONNumber
syntax region hefProperties start=/{/ end=/}/ contains=hefJSONKey,hefJSONString,hefJSONNumber
" JSON components
syntax match hefJSONKey /"[^"]\+":/he=e-1 contained
syntax match hefJSONString /"[^"]\+"/ contained
syntax match hefJSONNumber /-\?\d\+\(\.\d\+\)\?/ contained
" JSON colors:
highlight default link hefParameters Special
highlight default link hefVariant Special
highlight default link hefProperties Special
highlight default link hefJSONKey Identifier
highlight default link hefJSONString String
highlight default link hefJSONNumber Number


""""" SLAT lines:
" first match a whole slatline
" Format: x y z x y z layer partindex
syntax match hefSlat /^\(-\?\d\+\(\.\d\+\)\?\s\+\)\{6}\d\+\s\+\d\+$/
" First coordinate set (position, x/y/z)
syntax match hefCoord1 /^-\?\d\+\(\.\d\+\)\?/ contained containedin=hefSlat nextgroup=hefCoord2 skipwhite
syntax match hefCoord2 /-\?\d\+\(\.\d\+\)\?/ contained nextgroup=hefCoord3 skipwhite
syntax match hefCoord3 /-\?\d\+\(\.\d\+\)\?/ contained nextgroup=hefCoord4 skipwhite
" Second coordinate set (vector, x/y/z)
syntax match hefCoord4 /-\?\d\+\(\.\d\+\)\?/ contained nextgroup=hefCoord5 skipwhite
syntax match hefCoord5 /-\?\d\+\(\.\d\+\)\?/ contained nextgroup=hefCoord6 skipwhite
syntax match hefCoord6 /-\?\d\+\(\.\d\+\)\?/ contained nextgroup=hefLayer skipwhite
" Layer and part index
syntax match hefLayer /\d\+/ contained nextgroup=hefPartIndex skipwhite
syntax match hefPartIndex /\d\+$/ contained
" Define custom colors (approximating RGB values)
highlight hefCoord1 ctermfg=Red guifg=#FF5555
highlight hefCoord4 ctermfg=Red guifg=#FF5555
highlight hefCoord2 ctermfg=Green guifg=#55FF55
highlight hefCoord5 ctermfg=Green guifg=#55FF55
highlight hefCoord3 ctermfg=Blue guifg=#5555FF
highlight hefCoord6 ctermfg=Blue guifg=#5555FF
" Layer and part index
highlight default link hefLayer Comment
highlight default link hefPartIndex Normal

let b:current_syntax = "hyperwood"
