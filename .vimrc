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

" Maus nicht automatisch ausblenden,
" denn das nervt gewaltig
set nomousehide

" Bereits 7 Zeilen über Fensterende mit 
" dem Scrollen beginnen
set so=7

" Die von gvim genutzte Schriftart.
set guifont=Terminus\ 12

" Kein Scratchwindow
set completeopt=menu,menuone,longest

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

" -------------------------------------------------------------------- "

" 2. Key mappings
" ---------------

" Spellchecker umschalten
nmap <F5> :setlocal spell! spelllang=de_de<cr>
nmap <F6> :setlocal spell! spelllang=en_us<cr>

" Tagsfile neubauen
nmap <F7> :!/usr/local/bin/exctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Druck auf F9 hebt alle Vorkommen
" des Wortes unter dem Cursor hervor
nmap <F9> :set hls<CR>:exec "let @/='\\<".expand("<cword>")."\\>'"<CR>

" F10 hebt Markierungen auf
nmap <F10> :nohls<CR>

" F11 zeigt die Bufferliste
:nmap <F11> :buffers<CR>:buffer<Space>

" Paste-Mode auf F8
:nmap <F8> :set paste!<CR>

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
au FileType c,cpp setlocal comments-=://

" ------------------------------------------------------------------- "

" 4. Plugins
" ----------

" SuperTab wählt nach dem Druck einer
" Tastenkombination anhand von auf den
" bereits getippten Text angewandten 
" Heuristiken automatisch die korrekte
" Vervollständigungsmethode aus.

" Kontextabhängige, heuristische Auswahl
" der genutzten Vervollständigungsmethode.
let g:SuperTabDefaultCompletionType="context"

" <ctrl-space> für Vorwärtsvervollständigung
" und <shift-strl-space> für Rückwärtsver-
" vollständigung. Wie in Eclipse und co.
" Versagt u.U. auf der Konsole!
let g:SuperTabMappingForward='<c-space>'
let g:SuperTabMappingBackward='<s-c-space>'

" Vorauswahl des ersten Treffers
let g:SuperTabLongestHighlight=1

" Stichwort-Ergänzung als Standard
let g:SuperTabContextDefaultCompletionType='<c-N><c-P>'
let g:SuperTabRetainCompletionDuration ='completion'

" ----------

" NERDTree ist ein sehr praktischer
" Dateibrowser. Hier in der bugfreien
" Version von Github.

" Ein- und ausschalten auf F12
map <F12> :NERDTreeToggle<CR>
