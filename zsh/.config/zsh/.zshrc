# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/ifavila/.dotfiles/zsh/completions:"* ]]; then export FPATH="/home/ifavila/.dotfiles/zsh/completions:$FPATH"; fi
# Set up the prompt

#autoload -Uz promptinit
#promptinit
#prompt walters

RPROMPT='%*'
PROMPT='[%F{blue}%B%(4~|%-1~/…/%2~|%3~)%f%b]%% '

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=$ZDOTDIR/.zsh_history

# replace vim.tiny with vim for fc
FCEDIT=vim

# shows hidden folders too, except .git
export FZF_DEFAULT_COMMAND="ag --hidden --ignore .git -f -g \"\""

alias ls=ls\ -a\ --color=auto

function eh() {
    val=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
    echo $val
    eval $val
}

function fh() {
    echo $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

function fzf_with_preview() {
    fzf --preview "batcat --color=always --style=numbers --line-range=:500 {}"
}

function zsh_source() {
    source $ZDOTDIR/.zshrc
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# plugins
source $ZDOTDIR/plugins.zsh

# completion
source $ZDOTDIR/completion.zsh
. "/home/ifavila/.deno/env"

# pnpm
export PNPM_HOME="/home/ifavila/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
