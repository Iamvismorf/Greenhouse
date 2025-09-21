#todo: history search prefix
#TODO: history with path
# fish is impure :(
#fzf tab
if status is-interactive
   set fish_greeting 
   set -g fish_key_bindings fish_vi_key_bindings
   fish_default_key_bindings -M insert
   fish_vi_key_bindings --no-erase insert

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
   # alias info="btop"
   alias fetch="fastfetch"
   alias slip="systemctl suspend"
   alias switchpls="sudo nixos-rebuild switch --no-reexec -A"
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



#direnv hook fish | source
