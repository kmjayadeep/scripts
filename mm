#!/bin/bash

# map: A tool to manage notes in my mind map repo (private)

FOLDER=$PSUITE_MINDMAP_DIR

if [ -z "$PSUITE_MINDMAP_DIR" ]; then
  echo "PSUITE_MINDMAP_DIR not defined as environment variable"
  exit 1
fi

usage() {
  echo "mm: Manage mind map repo

  mm                     # Fuzzy finder to select an entry and edit in $EDITOR
  mm add <title>         # Create a new entry and open it in editor
  mm list                # List existing entries using fzf
  mm open                # open an entry in chrome"
}

x_isosec() { date -u "+%Y%m%b/%d%a-%H%M%S"; }

add() {
  d="$(x_isosec)"
  title="$@"
  title_stripped="${title//\ /-}"

  dir=$FOLDER/dump/$d-$title_stripped
  
  if [ -z $title_stripped ];then
    dir=$FOLDER/dump/$d
  fi

  mkdir -p $dir
  cd $FOLDER
  file=$dir/README.md
  echo "# $title" >  $file
  echo "## $(date)" >>  $file
  $EDITOR $file
}

list() {
  find $FOLDER -type f| fzf
}

getFile() {
  file=$(find $FOLDER -type f -name "*.md" -not -path '*/.git/*' | sed -e "s>^$FOLDER/dump/>>" | fzf --preview "bat --style numbers,changes --color always $FOLDER/dump/{}")
  echo $file
}

open() {
  file=$(getFile)
  if [[ -z $file ]]
  then
    echo "No file specified"
    exit 1
  fi
  $BROWSER "$FOLDER/dump/$file"
}

edit() {
  file=$(getFile)
  if [[ -z $file ]]
  then
    echo "No file specified"
    exit 1
  fi

  cd $FOLDER/dump; $EDITOR $file
  echo $file > /tmp/last_map
}

last() {
  if [ ! -f /tmp/last_map ]; then
    echo "last edited file not found"
    exit 1
  fi
  cd $FOLDER; $EDITOR `cat /tmp/last_map`
}


cmd=$1
shift

case $cmd in 
   "")
     edit
;;
   last)
     last
;;
   add)
     add "$@"
;;
   list)
     list
;;
   open)
     open
;;
   help)
     usage
;;
   *)
     usage
;;
esac
