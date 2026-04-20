root := justfile_dir()

switch Host=`hostname`:
   IMPURE=false nh os switch --file {{root}}/default.nix nC.{{Host}}

switchimpure Host=`hostname`:
   IMPURE=true nh os switch --file {{root}}/default.nix nC.{{Host}}

test Host=`hostname`:
   IMPURE=false nh os test --file {{root}}/default.nix nC.{{Host}}

testimpure Host=`hostname`:
   IMPURE=true nh os test --file {{root}}/default.nix nC.{{Host}}

clean:
   sudo nix-collect-garbage -d; nh clean all

boot Host=`hostname`:
   nh os boot --file {{root}}/default.nix nC.{{Host}}

