if status is-interactive
  set -g fish_prompt_pwd_dir_length 0

  abbr logout kill -9 -1
  abbr gs git status
  abbr gl git log
  abbr gd git diff
  abbr gds git diff --staged
  abbr ga git add
  abbr gaa git add -A
  abbr gr git restore
  abbr grs git restore --staged
  abbr gc git commit
  abbr gcm --set-cursor 'git commit -m "%"'
  abbr gca git commit --amend
  abbr gcan git commit --amend --no-edit
  abbr gcam --set-cursor 'git commit --amend -m "%"'
end
