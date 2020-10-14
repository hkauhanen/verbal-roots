#!/bin/bash

for FILE in ../plots/boxplot*
do
  PLAINFILENAME=${FILE##*/}
  echo "\\\\section{$PLAINFILENAME}\n"
  echo "\\\\subsection{Main analysis}\n"
  echo "\\\\texttt{plots/$PLAINFILENAME}\n"
  echo "\\includegraphics[width=0.98\\\\textwidth]{$FILE}\n"
  echo "\\\\subsection{Ignoring low-data languages}\n"
  echo "\\\\texttt{nolow/plots/$PLAINFILENAME}\n"
  echo "\\includegraphics[width=1.0\\\\textwidth]{../nolow/plots/$PLAINFILENAME}\n"
  echo "\\\\subsection{Ignoring \`diacritic' languages}\n"
  echo "\\\\texttt{nodia/plots/$PLAINFILENAME}\n"
  echo "\\includegraphics[width=1.0\\\\textwidth]{../nodia/plots/$PLAINFILENAME}\n"
  echo "\\\\eject\n"
done
