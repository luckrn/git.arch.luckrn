#!/bin/bash
# Default search engine.
DEFAULT_SEARCH=ixquick
# The location of the history
HISTORY="$HOME/.local/share/uzbl/history"
# Colors for dmenu
COLORS=" -nb #303030 -nf khaki -sb #CCFFAA -sf #303030"
# Prompt for dmenu
PROMPT="Go to: "
# Use surfraw to search for the words
function search()
{
    # Does surfraw know what to do with it?
    url=$(surfraw -print $@)
    # If not, then use the default search engine
    if [ $? -ne 0 ]
    then
        url=$(surfraw -print $DEFAULT_SEARCH $@)
    fi
    echo $url
}
# We assume that this is a URL
function goto()
{
    case "$1" in
        *:*) echo $1 ;;
        *) echo "http://$1" ;;
    esac
}
# Use dmenu to navigate through possible choices
function present_menu()
{
  elvi=$(surfraw -elvi | cut -f 1 | tail --lines=+2)
  uris=$(cut -d\  -f 3 "$HISTORY" 2>/dev/null | tac | sort | uniq -c | sort -n -r | tr -d ' [:digit:]')
  bookmarks=$(cut -d\  -f 1 ~/.surfraw.bookmarks)
  echo "${uris} ${elvi} ${bookmarks}" | tr ' ' '\n' | dmenu -p "$PROMPT" -l 10 -i $COLORS
}
present_menu | \
  ( read car cdr
    test -z "$car" && exit 1
    ( test -z "$cdr" && echo $car | fgrep -c '.
:' > /dev/null && goto $car ) || search "$car $cdr" )
