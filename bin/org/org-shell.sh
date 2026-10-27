# Add next line in .zshrc
# source ${ORG_AGENDA_PATH}/sh/org-shell.sh
# export PATH="$PATH:$ORG_AGENDA_PATH/bin"

# alias e="emacs -nw --init-directory=~/.emacs.d"
# alias e="emacsclient -t"
function e() {
    if [ "$1" ] ; then
        emacsclient -t "$@"
    else
        emacsclient -t .
    fi
}


# emacs org agenda
# moved to bin
# eta() {
#   local ORG_AGENDA=''
#   if [ "$1" ] && [ "$1" != "m" ] ; then
#     ORG_AGENDA="(org-agenda nil \"$1\") (switch-to-buffer \"*Org Agenda*\")"
#   else
#     ORG_AGENDA="(org-agenda)"
#   fi
#   emacsclient -t -F '((name . "Org-Agenda"))' \
#     --eval "(progn (switch-to-buffer \"*scratch*\") ${ORG_AGENDA} (delete-other-windows))"
# }

_eta_autocomplete() {
    local -a actions
    local ELISP_CMD=$(cat <<EOF
(mapconcat
 (lambda (el)
   (let ((key (car el))
         (desc
          (if
              (listp (cdr el))
              (cadr el)
            (cdr el))))
     (format "%s:%s" key desc)))
 (seq-filter
  (lambda (el)
    (let ((desc
           (if (listp (cdr el))
               (cadr el)
             (cdr el))))
      (and
       desc
       (stringp desc)
       (not (string-match-p
             "\\\\.\\\\.\\\\."
             desc)))))
  org-agenda-custom-commands)
 "\t")
EOF
)
    actions=(
      'a:Agenda for current week'
    )
    IFS=$'\t' actions+=($(emacsclient --eval $ELISP_CMD | tr -d '"'))

    _describe "actions" actions
}
compdef _eta_autocomplete eta

# org-agenda by tags
# etam() {
#   local ORG_AGENDA=''
#   if [ "$1" ]; then
#     ORG_AGENDA="(org-tags-view nil \"$1\") (switch-to-buffer \"*Org Agenda*\")"
#   else
#     ORG_AGENDA="(org-tags-view)"
#   fi
#   emacsclient -t -F '((name . "Org-Agenda"))' \
#     --eval "(progn (switch-to-buffer \"*scratch*\") ${ORG_AGENDA} (delete-other-windows))"
# }
_etam_autocomplete() {
    local -a actions
    local ELISP_CMD='(mapconcat (lambda (el) (car el)) (org-global-tags-completion-table) " ")'
    actions=(
      $(emacsclient --eval $ELISP_CMD | tr -d '"')
    )

    _describe "actions" actions
}
compdef _etam_autocomplete etam

# emacs-org capture
# etc() {
#   local ORG_CAPTURE=''
#   if [ "$1" ] ; then
#     ORG_CAPTURE="(org-capture nil \"$1\")"
#   else
#     ORG_CAPTURE="(org-capture)"
#   fi
#   emacsclient -t -F '((name . "Org-Capture"))' \
#     --eval "(progn (switch-to-buffer \"*scratch*\") ${ORG_CAPTURE})"
# }
_etc_autocomplete() {
    local -a actions
    actions=(
      $(emacsclient --eval '(mapconcat (lambda (el) (format "%s:%s" (car el) (cadr el))) (seq-filter (lambda (el) (> (length el) 3)) org-capture-templates) " ")' | tr -d '"')
    )
    # compadd "$@" -a options
    _describe "actions" actions
}
compdef _etc_autocomplete etc
