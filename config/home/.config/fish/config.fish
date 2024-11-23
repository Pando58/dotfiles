if status is-interactive
  set -g fish_prompt_pwd_dir_length 0

  abbr logout kill -9 -1
  abbr gs git status
  abbr gl git log
  abbr gla git log --all
  abbr glg git log --graph
  abbr glag git log --all --graph
  abbr gln git log -n
  abbr glan git log --all -n
  abbr glgn git log --graph -n
  abbr glagn git log --all --graph -n
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
  abbr gsl git stash list
  abbr gspo git stash pop
  abbr gsa git stash apply
  abbr gsd git stash drop
  abbr gsp git stash push
  abbr gspm --set-cursor 'git stash push -m "%"'
  abbr gspu git stash push --include-untracked
  abbr gspum --set-cursor 'git stash push --include-untracked -m "%"'
  abbr gsps git stash push --staged
  abbr gspsm --set-cursor 'git stash push --staged -m "%"'
  abbr gspk git stash push --keep-index
  abbr gspkm --set-cursor 'git stash push --keep-index -m "%"'
  abbr gspku git stash push --keep-index --include-untracked
  abbr gspkum --set-cursor 'git stash push --keep-index --include-untracked -m "%"'
  abbr gco git checkout
  abbr gcob git checkout -b
  abbr gcot git checkout --track
  abbr gcod git checkout --detach
  abbr gb git branch
  abbr gbv git branch -vv
  abbr gba git branch --all
  abbr gbav git branch --all -vv
  abbr gbm git branch --move
  abbr gbf git branch --force
  abbr gbd git branch --delete
  abbr gre git reset
  abbr gres git reset --soft
  abbr greh git reset --hard
  abbr gcl git clean
  abbr gcldf git clean -df
  abbr gf git fetch
  abbr gfa git fetch --all
  abbr gfap git fetch --all --prune
  abbr gps git push
  abbr gpsu git push -u
  abbr gpl git pull
  abbr gm git merge
  abbr gmm --set-cursor 'git merge -m "%"'
  abbr grb git rebase
  abbr grbc git rebase --continue
  abbr grbcn git -c core.editor=true rebase --continue
  abbr grba git rebase --abort
  abbr grbs git rebase --skip
  abbr grbi git rebase -i
  abbr gcp git cherry-pick
  abbr gcpc git cherry-pick --continue
  abbr gcpcn git -c core.editor=true cherry-pick --continue
  abbr gcpa git cherry-pick --abort
  abbr gcps git cherry-pick --skip
  abbr gwl git worktree list
  abbr gwa git worktree add
  abbr gwr git worktree remove
  abbr gwm git worktree move
  abbr gwlo git worktree lock
  abbr gwu git worktree unlock

  abbr lg lazygit
end
