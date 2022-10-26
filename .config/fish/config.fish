# set fish_greeting
set -g theme_display_git_default_branch yes
set -g theme_display_user yes
set -g theme_display_hostname yes
set -g theme_date_format "+%H:%M:%S"
set -g fish_prompt_pwd_dir_length 0
set -g theme_newline_cursor yes
set -g theme_newline_prompt '> '

alias logout="kill -9 -1"
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias dfs="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

nvm use lts --silent

if status is-interactive
    # Commands to run in interactive sessions can go here
end

function ranger-cd
  set tempfile '/tmp/chosendir'
  ranger --choosedir=$tempfile (pwd)

  if test -f $tempfile
      if [ (cat $tempfile) != (pwd) ]
        cd (cat $tempfile)
      end
  end

  rm -f $tempfile
end

function fish_user_key_bindings
    bind \co 'ranger-cd ; commandline -f repaint'
end
