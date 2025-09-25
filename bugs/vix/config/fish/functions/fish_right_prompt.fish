function fish_right_prompt
   # shell level check to avoid direnv
   if set -q IN_NIX_SHELL; and test $SHLVL -gt 1
      echo "[nix-shell] "
   end
end
