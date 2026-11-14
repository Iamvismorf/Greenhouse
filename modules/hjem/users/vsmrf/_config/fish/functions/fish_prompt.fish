function fish_prompt
    set -l last_status $status
    set -l retcc red
    test $status = 0; and set retcc green

    set -l stat
    if test "$last_status" -ne 0
        set stat (set_color $retcc)'┗━✗'
    else
        set stat (set_color $retcc)'┗━➜'
    end
    echo''

    set -l varMode
    switch $fish_bind_mode
        case default
            set varMode (set_color --bold green)'[N]'
        case insert
            set varMode (set_color --bold yellow )'[I]'
        case replace_one
            set varMode (set_color --bold cyan)'[R]'
        case visual
            set varMode (set_color --bold brmagenta)'[V]'
        case '*'
            set varMode (set_color --bold red)'[?]'
    end

    set -l readOnly
    if not test -w .
        set readOnly (set_color --bold red) '  '
    end

    #todo: doesn't work
    set -l ssh
    if set -q SSH_CONNECTION
        set ssh (set_color blue) '$hostname'
    end

    set gitBranch (set_color magenta)" "(fish_vcs_prompt '%s')

    string join '' -- (set_color $retcc) '┳━'$varMode (set_color --reset) ' on '$gitBranch $readOnly ' ' (set_color yellow)(prompt_pwd -d 0)
    echo (set_color $retcc)'┃'
    echo -n $stat  (set_color --reset)
end
