function fish_prompt
  set -l last_status $status
    set -l stat
    if test $last_status -ne 0
        set stat (set_color red)'✗'
     else
        set stat (set_color green)'->'
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
  set gitBranch (set_color magenta)" "(git branch --show-current 2>/dev/null)
  string join '' -- ' '$varMode (set_color normal) ' on '$gitBranch $readOnly ' ' (set_color yellow)(prompt_pwd -d 0) ' ' $stat (set_color normal) ' '
end


