#!/bin/bash

emacsdir=/usr/local/Cellar/emacs-mac/emacs-25.3-mac-6.8/bin
socket=$HOME/.emacs.d/server/server

file=$1
#printf "%q\n" "hello\world"
#printf -v file "%q\n" $1
#printf "%q\n" "hello\world$1 $2 $3"

line=$2
col=$3

# if [ ! -e $socket ]; then
#     # $emacsdir/Emacs &
#     /usr/local/Cellar/emacs-mac/emacs-25.3-mac-6.8/Emacs.app/Contents/MacOS/Emacs &
#     while [ ! -e $socket ]; do
#         sleep 1
#     done
# fi

#Printf $file
#$emacsdir/
emacsclient \
    -nc \
    -e \
    "(progn

       ;; Load the file
       (find-file \"$file\")

       ;; Jump to the same point as in IntelliJ
       ;; Unfortunately, IntelliJ doesn't always supply the values
       ;; depending on where the open is invoked from; e.g. keyboard 
       ;; works, tab context doesn't
         (when (not (string= \"\" \"$line\"))
         (goto-char (point-min))
         (forward-line (1- $2))
         (forward-char (1- $3)))

 
       ;; Automatically pick up changes made in IntelliJ
       (auto-revert-mode t))"

osascript -e 'tell application "System Events" to click UI element "Emacs" of list 1 of application process "Dock"'

# ;; Raise/focus our window; depends on the windowing system
#    (if (string-equal system-type \"darwin\")
#        (progn
#         (do-applescript \"tell application \\\"Emacs\\\" to activate\")

#        ))

# (do-applescript \"if application \\\"Emacs\\\" is running then \\\n    tell application \\\"System Events\\\" to click UI element \\\"Emacs\\\" of list 1 of application process \\\"Dock\\\" \\\n end if\")
