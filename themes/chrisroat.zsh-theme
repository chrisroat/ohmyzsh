#!/usr/bin/env zsh

# Displays the exec time of the last command if set threshold was exceeded.
preexec() {
    cmd_timestamp=`date +%s`
}
cmd_exec_time() {
    local stop=`date +%s`
    local start=${cmd_timestamp:-$stop}
    let local elapsed=$stop-$start
    [ $elapsed -gt 5 ] && echo ' ${elapsed}s'
}
precmd() {
   unset cmd_timestamp
}

ZSH_THEME_VIRTUALENV_PREFIX="%F{94}["  # brown
ZSH_THEME_VIRTUALENV_SUFFIX="]%f "
ZSH_THEME_GIT_PROMPT_PREFIX=" %F{cyan}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{cyan}*"

PROMPT='
$(virtualenv_prompt_info)%F{green}%~%f$(git_prompt_info)%F{yellow}$(cmd_exec_time)%f
%(?.%F{white}.%F{red})$%f ' # Displays red prompt on failure.

# Displays username on right side if connected via SSH.
RPROMPT="%F{8}${SSH_TTY:+%n@%m}%f"
