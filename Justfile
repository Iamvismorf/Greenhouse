root := justfile_dir()

switch Host=`hostname`:
   nh os switch --file {{root}}/default.nix nC.{{Host}}

clean:
   sudo nix-collect-garbage -d; nh clean all

boot Host=`hostname`:
   nh os boot --file {{root}}/default.nix nC.{{Host}}

