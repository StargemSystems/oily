#! @bash@/bin/bash

next_argv=()
bad_flags=(
  --debug
	--debugger
	--dump-po-strings
	--dump-strings
	--init-file
	--noediting
	--noprofile
	--norc
	--posix
	--pretty-print
	--restricted
)

for x in "$@"; do
    skip=
    [[ "$x" == "--" ]] && { shift; next_argv+=("$@"); break; }
    for y in "${bad_flags[@]}"; do
        [[ "$x" == "$y" ]] && { skip=1; break; }
    done
    [[ -n $skip ]] || next_argv+=("$x")
    shift
done
declare -p next_argv

exec @oil@/bin/osh "${next_argv[@]}"
