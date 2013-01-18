_probcli()
{
    cmd=${COMP_WORDS[0]}
    cur=${COMP_WORDS[COMP_CWORD]}
    cache="/tmp/$(basename "${cmd}")_cache.txt"
    if [ ! -f "${cache}" ]
    then
      ${cmd} -h >> "${cache}"
    fi
    opts=$(cat "${cache}" | grep '^\s\{1,\}\-\w' | awk '{ print $1 }')
    # filter options if we have a current prefix
    if [ $cur ]; then
      # escape leading "-" 
      if [ "-" = "${cur:0:1}" ]; then
        cur="\\"${cur}
      fi
      opts=$( for i in ${opts[@]} ; do echo $i ; done | grep "^${cur}" )
    fi
    COMPREPLY=( $opts )
}
#complete -F _probcli probcli.sh
complete -o bashdefault -o default -o nospace -F _probcli probcli.sh
complete -o bashdefault -o default -o nospace -F _probcli probcli

