root := justfile_dir()

# to use "pure" mode just override IMPURE=false
switch host=`hostname` *flags:
   nh os switch --file {{root}}/default.nix nC.{{host}} {{flags}}

test host=`hostname` *flags:
   nh os test --file {{root}}/default.nix nC.{{host}} {{flags}}

boot host=`hostname` *flags:
   nh os boot --file {{root}}/default.nix nC.{{host}} {{flags}}

build host=`hostname` *flags:
   nh os build --file {{root}}/default.nix nC.{{host}} {{flags}}

clean:
   sudo nix-collect-garbage -d; nh clean all
