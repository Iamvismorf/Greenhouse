function fish_prompt
    set -l last_status $status
    set -l retcc red
    test $status = 0; and set retcc green

    set -l stat
    if test "$last_status" -ne 0
        set stat '┗━✗'
    else
        set stat '┗━➜'
    end

    set -l mode
    switch $fish_bind_mode
        case default
            set mode (set_color --bold green)'[N]'
        case insert
            set mode (set_color --bold yellow )'[I]'
        case replace_one
            set mode (set_color --bold cyan)'[R]'
        case visual
            set mode (set_color --bold brmagenta)'[V]'
        case '*'
            set mode (set_color --bold red)'[?]'
    end

    set -l readOnly
    if not test -w .
        set readOnly '  '
    end

    set -l ssh
    if set -q SSH_CONNECTION
        set ssh $USER@(prompt_hostname)
    end

    set gitBranch (fish_vcs_prompt ' %s')

    echo
    string join '' -- \
        (set_color $retcc) '┳━' \
        $mode \
        (set_color --reset)' on '(set_color magenta)$gitBranch \
        (set_color --bold red) $readOnly \
        ' ' \
        (set_color blue) '['$ssh']:' \
        (set_color yellow) (prompt_pwd -d 0) \
        \n \
        (set_color $retcc) '┃' \
        \n \
        (set_color $retcc) $stat (set_color --reset) ' '
end
