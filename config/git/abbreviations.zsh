typeset -Ag abbrevs
abbrevs+=(
  # Git
  "gs"    "git status -sb"
  "gsl"   "git status"
  "g1"    "git log1"
  "g2"    "git log2"
  "g3"    "git log3"

  "gc"    "git commit"
  "gcf"   "git commit --fixup"
  "gca"   "git commit --amend"
  "gcane" "git commit --amend --no-edit"

  "gsm"   "git switch -"
  "gsc"   "git switch -c"
  "gsd"   "git switch develop"

  "gb"    "git branch"
  "gbm"   "git branch -M"

  "gd"    "git diff"
  "gdc"   "git diff --cached"
  "gdh"   "git diff HEAD~1"

  "gfo"   "git fetch origin"

  "gp"    "git push"
  "gpf"   "git push --force-with-lease"

  "gl"    "git pull"
  "glr"   "git pull --rebase"

  "grb"   "git rebase"
  "grbi"  "git rebase -i"
  "grbia" "git rebase -i --autosquash"
  "grba"  "git rebase --abort"
  "grbc"  "git rebase --continue"
  "grbm"  "git rebase master"
  "grbd"  "git rebase develop"

  "gr"    "git reset"
  "grs"   "git reset --soft"
  "grh"   "git reset --hard"

  "gcp"   "git cherry-pick"
  "gcpc"  "git cherry-pick --continue"
  "gcpa"  "git cherry-pick --abort"

  "gsh"   "git show"
  "gshs"  "git show --summary"
  "gshh"  "git show HEAD"

  "gsu"   "git submodule update --init --recursive"

  "gsta"  "git stash push"
  "gstd"  "git stash drop"
  "gstl"  "git stash list"
  "gstp"  "git stash pop"
  "gsts"  "git stash show"
)
