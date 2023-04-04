set -g fish_prompt_pwd_dir_length 0

abbr logout loginctl terminate-session ""
abbr gs git status
abbr gl git log
abbr gd git diff
abbr ga git add

if status is-interactive
  # Commands to run in interactive sessions can go here
end
