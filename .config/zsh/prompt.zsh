# Color definitions.
BLACK="{black}"
GREEN="{34}"
LIMEGREEN="{107}"
CYAN="{38}"
RED="{160}"
YELLOW="{178}"
ORANGE="{202}"
GRAY="{237}"

FG_BLACK="%F${BLACK}"
FG_GREEN="%F${GREEN}"
FG_LIMEGREEN="%F${LIMEGREEN}"
FG_CYAN="%F${CYAN}"
FG_RED="%F${RED}"
FG_YELLOW="%F${YELLOW}"
FG_ORANGE="%F${ORANGE}"
FG_GRAY="%F${GRAY}"

BG_BLACK="%K${BLACK}"
BG_GREEN="%K${GREEN}"
BG_LIMEGREEN="%K${LIMEGREEN}"
BG_CYAN="%K${CYAN}"
BG_RED="%K${RED}"
BG_YELLOW="%K${YELLOW}"
BG_ORANGE="%K${ORANGE}"
BG_GRAY="%K${GRAY}"

# Some unicode characters.
RBLOCKARROW=""     # \ue0b0
RANGLE="❯"          # \u276f
ARROW_UP="↑"        # \u2191
ARROW_DOWN="↓"      # \u2193
PLUSMINUS="±"       # \u00b1
BRANCH=""          # \uf020
BRANCH2=""         # \ue0a0
DETACHED="➦"        # \u27a6
CROSS="✘"           # \u2718
LIGHTNING="⚡"      # \u26a1
GEAR="⚙"            # \u2699
BULLET_SMALL="•"    # \u2022
BULLET_LARGE="●"
PLUS="➕"           # \u2795
PLUS2="✚"           # \u271a
FLAME=""           # \uf490

count_patches () {
    local num_patches=0
    for line in $@; do
        case ${line} in
            ((p|pick|r|reword|e|edit|s|squash|f|fixup|d|drop)' '*)
                ((++num_patches))
                ;;
            ([#]*) ;& # Commented line, skip.
            ((x|exec) *) ;& # Rebase exec command, skip.
            ((b|break)*)  # Rebase break command, skip.
                continue
                ;;
            (*)
                echo "count_patches: unknown rebase verb"
                continue
                ;;
        esac
    done
    echo ${num_patches}
}

prompt_status_hook () {
    repo_root=$(git rev-parse --show-toplevel 2> /dev/null)
    if [[ -n $repo_root ]]; then
        local branch=$(git branch --show-current)
        if [[ -z ${branch} ]]; then
            branch=$(git rev-parse --short HEAD)
        fi

        local staged=""
        local NUM_STAGED=$(git diff --staged 2> /dev/null | wc -l)
        if [[ ${NUM_STAGED} -gt 0 ]]; then
            staged="${FG_GREEN}${BULLET_LARGE}%f"
        fi

        local unstaged=""
        local NUM_UNSTAGED=$(git ls-files $repo_root --modified --exclude-standard 2> /dev/null | wc -l)
        if [[ ${NUM_UNSTAGED} -gt 0 ]]; then
            if [[ ${NUM_STAGED} -eq 0 ]]; then
                unstaged=""
            fi
            unstaged="${unstaged}${FG_YELLOW}${BULLET_LARGE}%f"
        fi

        local untracked=""
        local NUM_UNTRACKED=$(git ls-files $repo_root --other --exclude-standard 2> /dev/null | wc -l)
        if [[ ${NUM_UNTRACKED} -gt 0 ]]; then
            if [[ ${NUM_STAGED} -eq 0 && ${NUM_UNSTAGED} -eq 0 ]]; then
                untracked=""
            fi
            untracked="${untracked}${FG_RED}${BULLET_LARGE}%f"
        fi

        local num_ahead
        local num_behind
        local -a commit_diff
        local commit_diff_str
        num_ahead=$(git rev-list ${branch}@{upstream}..HEAD --count 2> /dev/null)
        (( ${num_ahead} )) && commit_diff="${commit_diff}${FG_GREEN}+${num_ahead}%f"

        num_behind=$(git rev-list HEAD..${branch}@{upstream} --count 2> /dev/null)
        (( ${num_behind} )) && commit_diff="${commit_diff}${FG_RED}-${num_behind}%f"

        if [[ -n ${commit_diff} ]]; then
            commit_diff_str="${(j:/:)commit_diff} "
        fi

        local git_dir="${repo_root}/.git"
        local action=""
        local -a patches_applied
        local -a patches_unapplied
        local patch_dir="${git_dir}/patches/${branch}"
        if [[ -d ${patch_dir} ]] && [[ -f ${patch_dir}/applied ]] && [[ -f ${patch_dir}/unapplied ]]; then
            echo "in first if"
            patches_applied=(${(f)"$(< "${patch_dir}/applied")"})
            patches_unapplied=(${(f)"$(< "${patch_dir}/unapplied")"})
        elif [[ -d ${git_dir}/rebase-merge ]]; then
            # git rebase -i
            action=" ${FG_ORANGE}${LIGHTNING}"
            patch_dir="${git_dir}/rebase-merge"
            if [[ -f ${patch_dir}/done ]]; then
                patches_applied=(${(f)"$(< "${patch_dir}/done")"})
            fi
            if [[ -f ${patch_dir}/git-rebase-todo ]]; then
                patches_unapplied=(${(f)"$(< "${patch_dir}/git-rebase-todo")"})
            fi
        elif [[ -d ${git_dir}/rebase-apply ]]; then
            # git rebase
            # TODO: Update this with proper things.
            action=" ${FG_ORANGE}${LIGHTNING}"
            # patch_dir="${git_dir}/rebase-apply"
            # patches_applied=(${(f)"$(< "${patch_dir}/done")"})
            # patches_unapplied=(${(f)"$(< "${patch_dir}/git-rebase-todo")"})
        elif [[ -f ${git_dir}/MERGE_HEAD ]]; then
            # git merge --no-commit
            action=" ${FG_ORANGE}${CROSS}"
        fi
        local num_patches_applied=$(count_patches ${patches_applied})
        local num_patches_unapplied=$(count_patches ${patches_unapplied})
        if [[ ${num_patches_applied} -gt 0 || ${num_patches_unapplied} -gt 0 ]]; then
            action="${action}${num_patches_applied}/$((${num_patches_applied}+${num_patches_unapplied}))%f"
        fi

        git_info="❯%f ${FG_YELLOW}${branch} ${commit_diff_str}${staged}${unstaged}${untracked}${action}${FG_YELLOW}❯%f"

        # Print only CWD from the repository root directory.
        local -a repo_path_parts=(${(s,/,)repo_root})
        local repo_name=${repo_path_parts[-1]}
        local path_in_repo=${PWD/${repo_root}/}
        cwd="${repo_name}${path_in_repo}"
    else
        git_info=""
        cwd="%~"
    fi

    prompt_prefix=""
    if [ "${PIPENV_ACTIVE}" ]; then
        prompt_prefix="${FG_YELLOW} %f${prompt_prefix}"
    fi

    newline=$'\n'
    prompt_char="%B%(!.#.)${RANGLE}%b"
    color_prompt="${prompt_prefix}%(?.${FG_CYAN}.${FG_RED})${prompt_char}%f"
    PS1="${FG_CYAN}${cwd}${git_info}${newline}${color_prompt} "
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd prompt_status_hook
