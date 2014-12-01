" 1. Startup
" ----------

" Dreckiger Hack: Wenn wir im GUI-Modus laufen,
" source diese Datei NICHT als .vimrc, sondern
" nur als .gvimrc. Damit kann ein Symlink von
" .vimrc -> .gvimrc gesetzt werden und dennoch
" wird die Config nur einmal durchlaufen.
if has("gui_running")
	if exists("g:gvimrc")
		unlet g:gvimrc
	else
		let g:gvimrc = 1
		finish
	endif
endif

" Eventuell angepassten Runtime-Pfad
" speichern.
let s:save_runtimepath = &runtimepath
let s:save_diff = &diff

" Alle Optionen auf Standard
set all&
highlight clear

" Und wiederherstellen
let &runtimepath = s:save_runtimepath
let &diff = s:save_diff
unlet s:save_runtimepath
unlet s:save_diff

" 1. Allgemeine Einstellungen
" ---------------------------

" Wir wollen nicht mit dem klassischen vi
" kompatibel sein, sprich nicht seine Bugs
" emulieren. Das könnten wir allerdings sogar
" gleich für verschiedene Versionen ;)
set nocompatible

" Unsere Shell, die wir allerdings recht
" selten bis nie brauchen.
set shell=/bin/tcsh

" Zeigt kurz an, welche Klammer durch eine
" neueingefügte Klammer gerade geschlossen wurde.
" Recht gut, um unvollständige Klammerung
" auszuschließen.
set showmatch

" Zeigt in der Kommandozeile an, in welchem Mode
" wir uns aktuell befinden. Recht praktisch um den
" Überblick zu behalten.
set showmode

" Zeigt Zeilennummern an.
set number

" Setzt nach Bewegungskommandos den Cursor auf das
" erste Zeichen der Zeile und NICHT an deren
" Beginn.
set nostartofline

" Zeigt die Statuszeile unten immer an.
set ls=2

" Zeigt wie der Name schon sagt das letzte
" Kommando in der Statuszeile an.
set showcmd

" Ein Tabstop sind vier Leerzeichen.
set tabstop=4

" Automatische Einrückung von exakt
" vier Leerzeichen.
set shiftwidth=4

" Statt vier Leerzeichen nimmt er
" jeweils einen Tabstop. Dieser Wert sollte
" gleich 'tabstop' und 'shiftwidth' sein,
" sonst verhält er sich komisch.
set softtabstop=4

" Schon suchen, während wir noch tippen.
set incsearch

" Virtuelles editieren bedeutet, dass wir den
" Cursor an stellen positionieren können, wo
" sich noch kein Zeichen befindet. Wir wollen
" dies in allen Modi.
set virtualedit=all

" Visuelle Benachrichtigung anstatt der
" Versuch zu piepen.
set visualbell

" Zeilen automagisch zur
" Darstellung umbrechen
set wrap

" Marker für umgebrochene Zeile
set showbreak=->\ \ \

" Breche immer am vollen Wort oder
" anderem Trennzeichen um
set linebreak

" Länge einer Zeile, automatischer harter
" Umbruch, wenn dies überschritten wird.
set textwidth=72

" Im Titel des Fensters oder des Terminal
" anzeigen, was wir gerade editieren.
set title

" Schnelle TTY-Updates nutzen.
" Sollte jedes Terminal können.
set ttyfast

" Suchbegriffe hervorheben
set hlsearch

" Die Statuszeile unten zeigt an, wo
" in der Datei wir uns befinden.
set ruler

" Versteckte Buffer können noch ungesicherte
" Änderungen enthalten. Ohne diese Option
" müssten wir sie immer speichern.
set hidden

" Nach der Einrückung des Textes automatisch
" Foldings erstellen.
set foldmethod=indent

" Wir wollen Backspace über
"  - Einrückungen
"  - End of line
"  - Zeilenanfang
" hinweg nutzen können
set backspace=indent,eol,start

" Wie soll er den Text automatisch formatieren?
"  r - Das Kommentarzeichen in einer neuen
"      Kommentarzeile automatisch anfügen.
"
"  o - Das gleiche wie bei r, nachdem wir
"      mit o oder O den Modus gewechselt
"      haben.
"
"  c - Kommentare automatisch auf 'textwidth'
"      umbrechen, das Kommentarzeichen von
"      sich aus einfügen.
"
"  t - Automatischer Zeilenumbruch, wenn
"      'textwidth' erlaubt ist.
"
"  q - Auch Kommentare können mit 'gq'
"      neu formatiert werden.
set formatoptions=roctq

" Maus automatisch ausblenden
set mousehide

" Selektieren mit der Maus schaltet
" in visual Mode
set mouse=a

" Bereits 7 Zeilen über Fensterende mit
" dem Scrollen beginnen
set so=7

" Die von gvim genutzte Schriftart.
set guifont=Terminus\ 12

" Kein Scratchwindow
set completeopt=menu,menuone,longest

" Kein Timeout auf Mappings
set notimeout

" Die Swapfile 2 Sekunden schreiben
set updatetime=2000

" Die Viminfo-Datei speichert
" den Status des Editors auch
" über Neustarts hinweg.
"  % - Wir merken uns die Bufferlist
"
"  '128 - Marken der letzten 128 Dateien
"         speichern
"
"  /128 - Die letzten 128 Suchbegriffe
"
"  :128 - Die letzten 128 Befehle
"
"  @128 - Die letzten 128 eingegebenen
"         Zeilen
"
"  s1024 - Alle Register bis 1 Megabyte
"          Größe speichern.
set viminfo=%,'128,/128,:128,@128,s1024

" Wir wollen uns Undo über Sessions hinweg merken
set undodir=~/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000

" Gibt an, was in automatisch erstellte
" Session-Scripte gespeichert wird.
set sessionoptions=blank,buffers,curdir,folds,localoptions,options,resize,tabpages,unix,winsize,winpos

" Blowfish als Verschluesselung
set cm=blowfish

" Unterstuetzung fuer 256 Farben auf dem Terminal
set t_Co=256

" Unser Farbschema
colorscheme yamagi256

" .vimrc nach dem Editieren automagisch
" neu einlesen.
autocmd BufWritePost .vimrc source %

" Springe beim Öffnen einer Datei zur letzten 
" bekannten Cursor-Position
autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif


" -------------------------------------------------------------------- "

" 2. Key mappings
" ---------------

" Spellchecker umschalten
nmap <F2> :setlocal spell! spelllang=en_us<cr>
nmap <F5> :setlocal spell! spelllang=de_de<cr>

" Tagsfile neubauen
nmap <F6> :!/usr/local/bin/exctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Paste-Mode
:nmap <F7> :set paste!<CR>

" Druck auf F8 hebt alle Vorkommen
" des Wortes unter dem Cursor hervor
nmap <F8> :set hls<CR>:exec "let @/='\\<".expand("<cword>")."\\>'"<CR>

" F9 hebt Markierungen auf
nmap <F9> :nohls<CR>

" F10 zeigt die Bufferliste
:nmap <F10> :buffers<CR>:buffer<Space>

" -------------------------------------------------------------------- "

" 3. Indention
" ------------

" Automatisches Sytaxhighlighting
syntax on

" Vim soll versuchen die Art der
" korrekten Einrückung automagisch
" anhand des Dateityps (sprich der
" Dateiendung) zu ermitteln. Klappt
" recht gut.
filetype indent on

" Wenn es ein Indent-Plugin für einen
" Syntax gibt, soll dies anstelle der
" generischen Indent-Mechanismen für
" C- und Wirth-Syntax genutzt werden.
" Funktioniert eigentlich immer viel
" besser.
filetype plugin indent on

" In C-Code sollen // Kommentare nicht
" fortgesetzt werden, da dies stoert.
autocmd FileType c,cpp setlocal comments-=://

" ------------------------------------------------------------------- "

" 4. Cscope
" ---------

" Bei weitem nicht jeder Vim
" hat cscope. Daher nur als
" optionales Feature.
if has("cscope")

	" cscope fuer Tags nutzen
	set cscopetag

	" Aber nur als Fallback
	set csto=1

	" Wenn im aktuellen Verzeichnis
	" eine Datenbank ist, fuegen wir
	" sie ein.
	if filereadable("cscope.out")
		cs add cscope.out
	endif

	" Wenn neue Datenbank geladen,
	" kommentiere es bitte.
	set cscopeverbose

	" Einfuegen einer Datenbank
	nmap <C-\>a :cs add cscope.out<CR><CR>

	" Neubau der Datenbank
	nmap <C-\>r :!cscope -Rb<CR>:cs reset<CR><CR>

	" Alle Vorkommen eines Symbols
	nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>

	" Globale Definitionen eines Symbols
	nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>

	" Alle Aufrufe eines Symbols
	nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>

	" Funktionen, die durch das Symbol aufgerufen werden
	nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

	" Oeffnet die Datei unter dem Cursor
	nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>

endif

" ------------------------------------------------------------------- "

" 5. Plugins
" ----------

" Pathogen laden, was wiederum die
" Plugins reinzieht.
call pathogen#infect()
call pathogen#helptags()

" ----------

" SuperTab wählt nach dem Druck einer
" Tastenkombination anhand von auf den
" bereits getippten Text angewandten
" Heuristiken automatisch die korrekte
" Vervollständigungsmethode aus.

" Kontextabhängige, heuristische Auswahl
" der genutzten Vervollständigungsmethode.
let g:SuperTabDefaultCompletionType="context"

" Vorauswahl des ersten Treffers
let g:SuperTabLongestHighlight=1

" Stichwort-Ergänzung als Standard
let g:SuperTabContextDefaultCompletionType='<c-N><c-P>'
let g:SuperTabRetainCompletionDuration ='completion'

" Suche auf strg-space
if has("gui_running")
	let g:SuperTabMappingForward = '<C-Space>'
	let g:SuperTabMappingBackward = '<S-C-Space>'
else
	let g:SuperTabMappingForward = '<C-@>'
	let g:SuperTabMappingBackward = '<S-C-@>'
endif

" ----------

" clang_complete ist ein komplexes Plugin,
" was mittels Clang Autovervollständigung
" für C, C++ und ObjC implementiert.

" Pfad zu libclang.so
let g:clang_library_path="/usr/opt/clang/lib"

" Completions immer explizit starten.
let g:clang_complete_auto=0

" Clang errors anzeigen.
let g:clang_complete_copen=1

" Das Fenster mit den Fehlern
" automatisch aktualisieren.
let g:clang_periodic_quickfix=1

" Das Fehlerfenster aktualisieren
" wenn der Insert-Mode verlassen
" wird oder für einige Zeit
" nichts eingegeben wird.
autocmd InsertLeave *.c,*.cpp,*.cxx,*.cc call g:ClangUpdateQuickFix()
autocmd CursorHoldI *.c,*.cpp,*.cxx,*.cc call g:ClangUpdateQuickFix()

" Preview-Fenster automatisch
" schließen.
let g:clang_close_preview=1

" Auch Präprozessor-Kram soll
" vervollständigt werden.
let g:clang_complete_macros=1

" Auch Pattern (wie z.B. Schleifen)
" sollen vervollständigt werden.
let g:clang_complete_patterns=1

" Ersten Treffer selektieren
let g:clang_auto_select=1

" ----------

" gundo ist ein Plugin, welches den
" Undo-Tree visualisiert.
map <F11> :GundoToggle<CR>

" ----------

" NERDTree ist ein sehr praktischer
" Dateibrowser. Hier in der bugfreien
" Version von Github.

" Ein- und ausschalten auf F12
map <F12> :NERDTreeToggle<CR>

