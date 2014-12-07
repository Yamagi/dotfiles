" ----------
" 1. Startup
" ----------

" Pathogen manipuliert den Runtime-Pfad, muss daher so früh wie nur
" möglich eingebunden werden. Sonst riskieren wir, dass er Plugins
" nicht reinzieht. Pathogen ist intelligent genug, dass wir es auch
" mehrmals einbinden können, ohne das seltsame Dinge geschehen.
call pathogen#infect()
call pathogen#helptags()

" Wenn wir im GUI-Mode laufen, source diese Datei nur beim zweiten
" Aufruf. Damit können wir einen Symlink vimrc -> gvimrc setzen und
" eventuelle Änderungen der systemweiten gvimrc wieder rückgängig
" machen. Denn leider kann man das Sourcen das systemweitem gvimrc
" nicht auf Ebene der Konfigurationsdateien verhindern. Und ein
" Shell-Alias gvim -> 'gvim -U ~/.gvimrc' ist nicht immer möglich.
if has("gui_running")
	if exists("g:gvimrc")
	   unlet g:gvimrc
   else
	   let g:gvimrc = 1
	   finish
  endif
endif

" Eventuell angepassten Runtime-Pfad speichern.
let s:save_runtimepath = &runtimepath
let s:save_diff = &diff

" Alle Optionen auf Standard
set all&

" Systemweite highlights löschen
highlight clear

" Systemweite autocmd löschen. Hoffentlich hält sich der Admin an die
" Konventionen und setzt sie in der Gruppe 'vimrcEx'. Sonst haben wir
" leider schlechte Karten. Wir müssen innerhalb einer Gruppe löschen,
" da das explizite Löschen einer Gruppe zu Fehlern führt, wenn diese
" Gruppe leer ist. Für Vim also nicht existiert. Alles klar? ;)
augroup vimrcEx
	autocmd!
augroup END

" Und den Runtime-Pfad wiederherstellen
let &runtimepath = s:save_runtimepath
let &diff = s:save_diff
unlet s:save_runtimepath
unlet s:save_diff

" =====================================================================

" ---------------------------
" 2. Allgemeine Einstellungen
" ---------------------------

" Normalerweise ist Vim 'compatible', emuliert also den klassischen vi.
" Wir wollen dies natürlich nicht, schließlich nutzen wir Vim statt vi.
" Schaltet die meisten folgenden Optionen erst frei.
set nocompatible

" Neue und sichere Blowfish-Implementerung zur Verschlüsselung.
set cryptmethod=blowfish2

" Buffer können sich im Hintergrund befinden, müssen also nicht zwingend
" einem Window zugeordnet sein. Damit verhält Vim sich wie die meisten
" Multi-File-Editors.
set hidden

" Das Kommando, welches der 'shell' Befehl startet.
set shell=/bin/tcsh

" Den Terminal-Titel auf den Namen der aktuellen Datei setzen.
set title

" Visuelle Benachrichtigung anstatt piepen.
set visualbell

" Modelines sind in vielen Installationen aus Sicherheitsgründen
" abgeschaltet. Wir wollen sie aber parsen.
set modeline

" ----

" Zeige Zeilennummern am linken Rand.
set number

" Wenn eine Klammer geschlossen wird, blinkt die öffnende Klammer kurz
" auf. Sehr sinvoll, um auch in komplexeren Strukturen den Überblick zu
" behalten.
set showmatch

" ----

" Zeigt die Statuszeile immer am unteren Rand des Fensters. Ohne diese
" Option wird sie nur in einigen Situationen gezeigt.
set laststatus=2

" Zeige die aktuelle Cursorposition in der Statuszeile.
set ruler

" Zeigt das letzte Kommando in der Statuszeile an, bis dies durch eine
" andere Ausgabe dort überschrieben wird.
set showcmd

" Zeigt in der Kommandozeile an, in welchem Mode wir sind.
set showmode

" ----

" Ein Tabstop sind vier Leerzeichen.
set tabstop=4

" Automatische Einrückung aus 'tabstop' bestimmen.
set shiftwidth=4

" Nehme alle 'tabstop" Leerzeichen einen Tab statt der Leerzeichen.
set softtabstop=-1

" ----

" Setzen den Cursor auf den Zeilenbeginn, nicht das erste Zeichen.
set nostartofline

" Erlaube in allen Modi freie Cursorpositionierung, unabhängig der
" Bereits eingegeben Zeichen.
set virtualedit=all

" Überlange Zeilen zur Darstellung umbrechen.
set wrap

" Breche nur in Leerzeichen um, nicht innerhalb eines Wortes.
set linebreak

" Marker für umgebrochene Zeilen.
set showbreak=->\

" ----

" Alle gefundenen Suchbegriffe hervorheben, nicht nur die Fundstelle.
set hlsearch

" Bereits suchen, während wir noch tippen.
set incsearch

" ----

" Backspace soll über Einrückungen, Zeilenanfänge und Zeilenende hinweg
" laufen. Damit verhält es sich wie in einem normalen Editor.
set backspace=indent,eol,start

" Anhand der Einrückung Foldings erstellen. Funktioniert in der Praxis
" von allen Methoden am besten.
set foldmethod=indent

" Defintion, wie Text automatisch formatiert werden soll:
"
"  r - Das Kommentarzeichen in einer neuen Kommentarzeile automatisch
"      anfügen.
"
"  o - Kommentarzeichen einfügen, wenn man mit o odr O in den Insert
"      Mode wechselt.
"
"  c - Kommentare automatisch auf 'textwidth' umbrechen, die Kommentare
"      automatisch einfügen.
"
"  t - Automatischer Zeilenumbruch auf 'textwidth'.
"
"  q - Auch Kommentare können mit 'gq' neu formatiert werden.
set formatoptions=roctq

" Maximale Zeilenlänge, automatischer Umbruch wenn diese überschritten
" wird.
set textwidth=72

" ----

" Die folgenden Dinge nur im GUI. Auf dem Terminal sind sie sinnlos,
" da technisch nicht umzusetzen oder da wir dem Terminal Emulator ins
" Handwerk pfuschen würden.
if has("gui_running")

	" Die von gvim genutzte Schriftart.
	set guifont=Terminus\ 12

	" Maus beim Tippen automatisch ausblenden.
	set mousehide

	" Selektieren mit der Maus schaltet in den Visual Mode.
	set mouse=a

" Die folgenden Dinge nur im Terminal. Im GUI sind sie sinnlos.
else

	" Erzwinge 256 Farben. Theoretisch sollte Vim dies automatisch
	" anhand der Terminfo / Termcap Einträge setzen. Praktisch hat
	" es noch nie so wirklich funktioniert, insbesondere nicht unter
	" FreeBSD.
	set t_Co=256

endif

" Unser Farbschema. Ein abgewandeltes desert-Schema.
colorscheme yamagi256

" Kein Scratchwindow, alle Informationen stattdessen inline anzeigen.
set completeopt=menu,menuone,longest,preview

" Bereits 5 Zeilen vor dem Fensterende zu scrollen beginnen.
set scrolloff=5

" Kein Timeout auf Mappings, ewig darauf warten dass sie entweder
" zuende getippt oder Escape gedrückt wird.
set notimeout

" ----

" Die Swapfile bereits nach 2 Sekunden Inaktivität schreiben. Es
" benötigt geringfügig mehr IO als der Standardwert von 4 Sekunden,
" aber man kann nie genug Wiederherstellungsinformationen haben.
set updatetime=2000

"  Mit Hilfe der ~/.viminfo Datei merkt sich Vim Dinge über mehrere
"  Sessions hinweg. Wir speichern in ihr:
"
"  % - Wir merken uns die Bufferliste, öffnen sie beim Start wieder,
"      sofern keine Datei an Vim übergeben wurde.
"
"  '128 - Marken der letzten 128 Dateien speichern.
"
"  /128 - Die letzten 128 Suchbegriffe.
"
"  :128 - Die letzten 128 History-Befehle.
"
"  @128 - Die letzten 128 eingegebenen Zeilen.
"
"  s1024 - Alle Register bis 1 Megabyte Größe speichern.
set viminfo=%,'128,/128,:128,@128,s1024

" Die Undo-Datei merkt sich Undo-Daten für einzelne Dateien über mehrere
" Sessions hinweg. Wir speichern diese Daten in ~/.vim/undo. Maximal
" 1.000 Änderungen können rückgängig gemacht werden, bis zu 10.000
" Zeilen werden beim erneuten laden einer (extern geänderten) Datei
" im RAM gehalten. Dies erlaubt es, die externen Änderungen per Undo
" rückgängig zu machen.
set undofile
set undodir=~/.vim/undo
set undolevels=1000
set undoreload=10000

" Gibt an, was in automatisch erstellte Session-Scripte gespeichert wird.
set sessionoptions=blank,buffers,curdir,folds,localoptions,options,resize,tabpages,unix,winsize,winpos

" ----

" Wir wollen automatisches Syntaxhighlighting.
syntax on

" Erkenne Dateitypen.
filetype on

" Wähle Einrückstil anhand des erkannten Dateityps.
filetype indent on

" Vim hat zwar mehrere eingebaute Indent-Styles und kann den Stil wenn
" nötig automagisch ermitteln, aber oft recht es nicht aus. Wenn es ein
" Plugin für den entsprechenden Dateityp gibt, wollen wir dies daher
" nutzen.
filetype plugin indent on

" =====================================================================

" ----------------
" 3. Auto-Commands
" ----------------

" Alle von uns definierten Auto-Commands kommen in die kanonische Gruppe
" vimrcEx, wodurch wir sie später einfach wieder entfernen können.
augroup vimrcEx

	" Eine veränderte .vimrc nach dem Speichern neu einlesen.
	autocmd BufWritePost .vimrc source %

	" Springe beim Öffnen einer Datei zur letzten bekannten Cursor-
	" Position. Nutzt Daten aus der ~/.viminfo.
	autocmd BufReadPost *
				\ if line("'\"") > 1 && line("'\"") <= line("$") |
				\   exe "normal! g`\"" |
				\ endif

	" Wenn wir allerdings eine git Commit Message editieren, springe
	" gleich wieder zurück an den Start. Es ist ein wenig unschön, aber
	" leider kann Vim keine Excludes auf Auto-Commands anwenden.
	autocmd BufReadPost COMMIT_EDITMSG exe "normal! gg"

	" Im Falle von C und C++ sollen //-Kommentare nicht fortgesetzt
	" werden, wenn die Zeile umgebrochen wird. Es sind halt einzeilige
	" Kommentare.
	autocmd FileType c,cpp setlocal comments-=://

augroup END

" =====================================================================

" ---------------
" 4. Key mappings
" ---------------

" Spellchecker umschalten.
nmap <F2> :setlocal spell! spelllang=en_us<cr>
nmap <F3> :setlocal spell! spelllang=de_de<cr>

" Auf F5 die Zeile highlighten, an welcher der Text umbricht.
function! g:ToggleColorColumn()
	if &colorcolumn != ''
		setlocal colorcolumn&
	else
		setlocal colorcolumn=+1
	endif
endfunction
nmap <F5> :call g:ToggleColorColumn()<CR>

" Tagfile neubauen.
nmap <F6> :!/usr/local/bin/exctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Paste-Mode.
nmap <F7> :set paste!<CR>

" Druck auf F8 hebt alle Vorkommen des Wortes unter dem Cursor hervor.
nmap <F8> :set hls<CR>:exec "let @/='\\<".expand("<cword>")."\\>'"<CR>

" F9 hebt die mit F8 oder durch suchen gesetzten Markierungen auf.
nmap <F9> :nohls<CR>

" F10 zeigt die Bufferliste.
nmap <F10> :buffers<CR>:buffer<Space>

" Buffer Navigation auf bn und bp.
nmap bn :bn<CR>
nmap bp :bp<CR>

" =====================================================================

" ---------
" 5. Cscope
" ---------

" Bei weitem nicht jede Vim-Installation besitzt die Cscope-Integration.
" Daher nutzen wir sie nur als optionales Features.
if has("cscope")

	" cscope fuer Tags nutzen. Aber nur als Fallback, wenn keine echten
	" Tags generiert wurden.
	set cscopetag
	set csto=1

	" Wenn im aktuellen Verzeichnis eine Cscope-Datenbank leigt, fuegen
	" wir sie automadisch ein.
	if filereadable("cscope.out")
		cs add cscope.out
	endif
	" Wenn neue Datenbank geladen wird, kommentiere es bitte in der
	" Statuszeile. Es hilft, wenn der Nutzer weiß, dass sie übernommen
	" wurde.
	set cscopeverbose

	" Einfügen einer Datenbank.
	nmap <C-\>a :cs add cscope.out<CR><CR>

	" Neubau der Datenbank.
	nmap <C-\>r :!cscope -Rb<CR>:cs reset<CR><CR>

	" Alle Vorkommen eines Symbols.
	nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>

	" Globale Definitionen eines Symbols.
	nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>

	" Alle Aufrufe eines Symbols.
	nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>

	" Funktionen, die durch das Symbol aufgerufen werden.
	nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

	" Öffnet die Datei unter dem Cursor.
	nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>

endif

" =====================================================================

" ----------
" 5. Plugins
" ----------

" SuperTab wählt anhand von Heuristiken automatisch die korrekte Methode
" zur Autovervollständigung und zur Vervollständigung aus.

" Kontextabhängige, heuristische Auswahl der genutzten
" Vervollständigungsmethode.
let g:SuperTabDefaultCompletionType="context"

" Stichwort-Ergänzung als Standard.
let g:SuperTabContextDefaultCompletionType='<c-N><c-P>'
let g:SuperTabRetainCompletionDuration ='completion'

" Vorauswahl des ersten Treffers.
let g:SuperTabLongestHighlight=1

if has("gui_running")

	" Suche auf strg-space, wenn wir im GUI sind. Terminals fressen
	" diese Tastenkombination leider.
	let g:SuperTabMappingForward = '<C-Space>'
	let g:SuperTabMappingBackward = '<S-C-Space>'
else

	" Daher strg-space, wenn wir im Terminal sind. Space wird von
	" den meisten Terminals auf @ übersetzt.
	let g:SuperTabMappingForward = '<C-@>'
	let g:SuperTabMappingBackward = '<S-C-@>'
endif

" ----

" clang_complete ist ein komplexes Plugin, was mittels Clang
" Autovervollständigung für C, C++ und ObjC implementiert.

" Pfad zu libclang.so.
let g:clang_library_path="/usr/opt/clang/lib"

" Completions immer explizit starten.
let g:clang_complete_auto=0

" Clang errors anzeigen.
let g:clang_complete_copen=1

" Das Fenster mit den Fehlern automatisch aktualisieren.
let g:clang_periodic_quickfix=1

" Das Fehlerfenster aktualisieren wenn der Insert-Mode verlassen
" wird oder für einige Zeit nichts eingegeben wird. Wir definieren
" diese Auto-Commands in der Gruppe clangcomplete.
augroup clangcomplete
	autocmd InsertLeave *.c,*.cpp,*.cxx,*.cc call g:ClangUpdateQuickFix()
	autocmd CursorHoldI *.c,*.cpp,*.cxx,*.cc call g:ClangUpdateQuickFix()
augroup END

" Preview-Fenster automatisch schließen.
let g:clang_close_preview=1

" Auch Präprozessor-Kram soll vervollständigt werden.
let g:clang_complete_macros=1

" Auch Pattern (wie z.B. Schleifen) sollen vervollständigt werden.
let g:clang_complete_patterns=1

" Ersten Treffer selektieren.
let g:clang_auto_select=1

" ----

" gundo ist ein Plugin, welches den Undo-Tree visualisiert.
map <F11> :GundoToggle<CR>

" ----

" NERDTree ist ein sehr praktischer Dateibrowser.

" Ein- und ausschalten auf F12
map <F12> :NERDTreeToggle<CR>

