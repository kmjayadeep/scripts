#!/bin/bash

# map: A tool to manage notes in my mind map repo (private)

FOLDER=~/workspace/mindmap

usage() {
  echo "mm: Manage mind map repo

  mm                     # Fuzzy finder to select an entry and edit in $EDITOR
  mm add <title>         # Create a new entry and open it in editor
  mm list                # List existing entries using fzf
  mm open                # open an entry in chrome
  mm push                # Commit and push to git"
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
  cd ~/workspace/mindmap/dump
  file=$dir/README.md
  echo "# $title" >  $file
  echo "## $(date)" >>  $file
  $EDITOR $file
}

list() {
  find /home/jayadeep/workspace/mindmap/dump -type f| fzf
}

getFile() {
  file=$(find ~/workspace/mindmap/dump -type f -name "*.md" -not -path '*/.git/*' | cut -sd / -f 7- | fzf --preview 'bat --style numbers,changes --color always ~/workspace/mindmap/dump/{}')
  echo $file
}

open() {
  file=$(getFile)
  if [[ -z $file ]]
  then
    echo "No file specified"
    exit 1
  fi
  google-chrome-stable "~/workspace/mindmap/dump/$file"
}

push() {
  msg=$1
  if [[ -z $msg ]]
  then
    msg="mind map saved on : $(date)"
  fi
  cd $FOLDER ; git add .; git commit -m "$msg" --no-gpg-sign; git push origin main;
}

edit() {
  file=$(getFile)
  if [[ -z $file ]]
  then
    echo "No file specified"
    exit 1
  fi

  cd ~/workspace/mindmap/dump/; $EDITOR $file
  echo $file > /tmp/last_map
}

last() {
  if [ ! -f /tmp/last_map ]; then
    echo "last edited file not found"
    exit 1
  fi
  cd ~/workspace/mindmap/dump/; $EDITOR `cat /tmp/last_map`
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
     add $@
;;
   list)
     list
;;
   open)
     open
;;
   push)
     push $1
;;
   help)
     usage
;;
   *)
     usage
;;
esac
