" latex.vim
" vim macros for latex

set nosi " `smart' indenting creates problems

" document class header
map! <buffer> ;dcart \documentclass[letterpaper,12pt]{article}<cr><cr>
nmap <buffer> ;dcart i\documentclass[letterpaper,12pt]{article}<cr><cr><esc>

" document body
map! <buffer> ;doc \begin{document}<cr><cr><cr><cr>\end{document}<esc>kk
nmap <buffer> ;doc i\begin{document}<cr><cr><cr><cr>\end{document}<esc>kk

"" environments
" tabular
map! <buffer> ;tab \begin{tabular}{}<cr><cr>\end{tabular}<esc>kk$i
nmap <buffer> ;tab i\begin{tabular}{}<cr><cr>\end{tabular}<esc>kk$

" tabular*
map! <buffer> ;stab \begin{tabular*}{}{}<cr><cr>\end{tabular*}<esc>kk$hhi
nmap <buffer> ;stab i\begin{tabular*}{}{}<cr><cr>\end{tabular*}<esc>kk$hh

" enumerate
map! <buffer> ;enum \begin{enumerate}<cr><cr>\end{enumerate}<esc>k$i
nmap <buffer> ;enum i\begin{enumerate}<cr><cr>\end{enumerate}<esc>k$

" itemize
map! <buffer> ;item \begin{itemize}<cr><cr>\end{itemize}<esc>ki
nmap <buffer> ;item i\begin{itemize}<cr><cr>\end{itemize}<esc>k

" center
map! <buffer> ;cent \begin{center}<cr><cr>\end{center}<esc>ki
nmap <buffer> ;cent i\begin{center}<cr><cr>\end{center}<esc>k

" item
map! <buffer> ;it \item


"" text manipulation
" bold
map! <buffer> ;bf \textbf{}<esc>i
nmap <buffer> ;bf i\textbf{}<esc>
vmap <buffer> ;bf "xdi\textbf{<esc>"xpa}<esc>

" emphasized
map! <buffer> ;em \emph{}<esc>i
nmap <buffer> ;em i\emph{}<esc>
vmap <buffer> ;em "xdi\emph{<esc>"xpa}<esc>

" teletype/monospaced
map! <buffer> ;tt \texttt{}<esc>i
nmap <buffer> ;tt \texttt{}<esc>
vmap <buffer> ;tt "xdi\texttt{<esc>"xpa}<esc>

" mbox
map! <buffer> ;mb \mbox{}<esc>i
nmap <buffer> ;mb \mbox{}<esc>
vmap <buffer> ;mb "xdi\mbox{<esc>"xpa}<esc>

" section
map! <buffer> ;sa \section*{}<esc>i
nmap <buffer> ;sa i\section*{}<esc>
vmap <buffer> ;sa "xdi\section*{<esc>"xpa}<esc>
map! <buffer> ;sna \section{}<esc>i
nmap <buffer> ;sna i\section{}<esc>
vmap <buffer> ;sna "xdi\section{<esc>"xpa}<esc>

" subsection
map! <buffer> ;sb \subsection*{}<esc>i
nmap <buffer> ;sb i\subsection*{}<esc>
vmap <buffer> ;sb "xdi\subsection*{<esc>"xpa}<esc>
map! <buffer> ;snb \subsection{}<esc>i
nmap <buffer> ;snb i\subsection{}<esc>
vmap <buffer> ;snb "xdi\subsection{<esc>"xpa}<esc>

" subsubsection
map! <buffer> ;sc \subsubsection*{}<esc>i
nmap <buffer> ;sc i\subsubsection*{}<esc>
vmap <buffer> ;sc "xdi\subsubsection*{<esc>"xpa}<esc>
map! <buffer> ;snc \subsubsection{}<esc>i
nmap <buffer> ;snc i\subsubsection{}<esc>
vmap <buffer> ;snc "xdi\subsubsection{<esc>"xpa}<esc>


" text size
map! <buffer> ;lar {\large }<esc>i
map! <buffer> ;Lar {\Large }<esc>i

" comments
vmap <buffer> ;com :s/^/%/g<cr>
vmap <buffer> ;uncom :s/^%//g<cr>
