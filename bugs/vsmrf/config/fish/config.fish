if status is-interactive
   fzf --fish | source
   set fish_greeting 
   set -g fish_key_bindings fish_vi_key_bindings
   fish_default_key_bindings -M insert
   fish_vi_key_bindings --no-erase insert

   bind -M insert \t 'fzf-complete'
   bind -M insert ctrl-space accept-autosuggestion
   bind -M visual l forward-char-passive
   bind l forward-char-passive
   bind -M visual h backward-char-passive
   bind h backward-char-passive
   bind -M insert ctrl-k history-search-backward
   bind -M insert ctrl-j history-search-forward
   bind -M visual y 'fish_clipboard_copy; commandline -f end-selection repaint-mode'
   bind yy fish_clipboard_copy
   bind p fish_clipboard_paste
   bind k history-search-backward
   bind j history-search-forward

   alias off="shutdown now"
   alias ls="eza --colour=always --icons=always -la"
   alias info="btm"
   alias fetch="fastfetch"
   alias slip="systemctl suspend"
   # alias switchpls="sudo nixos-rebuild switch --no-reexec -A"
   alias switchpls="nh os switch --file ./default.nix"
   alias clean="sudo nix-collect-garbage -d; nh clean all"
   alias nix-shell="nix-shell --command fish"
end
# fish_default_key_bindings
# function autocd
#    command -q $argv[1]; and return 1
#    test -d "$argv[1]"; and echo cd $argv[1]; and return 0
#    return 1
# end
#
# abbr autocd --regex '.*' --function autocd


if uwsm check may-start; and uwsm select
	exec uwsm start hyprland-uwsm.desktop
end

#direnv hook fish | source

function fzf-complete -d 'fzf completion and print selection back to commandline'
	set -l cmd (commandline -co) (commandline -ct)
	switch $cmd[1]
		case env sudo
			for i in (seq 2 (count $cmd))
				switch $cmd[$i]
					case '-*'
					case '*=*'
					case '*'
						set cmd $cmd[$i..-1]
						break
				end
			end
	end
	set cmd (string join -- ' ' $cmd)

	set -l complist (complete -C$cmd)
	set -l result
	string join -- \n $complist | sort | eval (__fzfcmd) -m --select-1 --exit-0 --header '(commandline)' | cut -f1 | while read -l r; set result $result $r; end

	set prefix (string sub -s 1 -l 1 -- (commandline -t))
	for i in (seq (count $result))
		set -l r $result[$i]
		switch $prefix
			case "'"
				commandline -t -- (string escape -- $r)
			case '"'
				if string match '*"*' -- $r >/dev/null
					commandline -t --  (string escape -- $r)
				else
					commandline -t -- '"'$r'"'
				end
			case '~'
				commandline -t -- (string sub -s 2 (string escape -n -- $r))
			case '*'
				commandline -t -- (string escape -n -- $r)
		end
		[ $i -lt (count $result) ]; and commandline -i ' '
	end

	commandline -f repaint
end
