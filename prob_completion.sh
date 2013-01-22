_probcli_pref_opts()
{
    opts=$(cat "${cache}" \
        | grep '^\s\{1,\}[A-Z]\w*\s\{1,\}:' \
        | awk '{print $1}')
}
_probcli_common_opts()
{
    opts=$(cat "${cache}" \
        | grep '^\s\{1,\}\-\{1,\}\w' \
        | awk '{ print $1 }')
}
_probcli()
{
    local cmd=${COMP_WORDS[0]}
    local cur=${COMP_WORDS[${COMP_CWORD}]}
    local prev=${COMP_WORDS[$((${COMP_CWORD}-1))]}

    eval cmd=$cmd
    cache="/tmp/$(basename "${cmd}")_cache.txt"
    # fill cache
    if [ ! -f "${cache}" ]; then
      ${cmd} -h -v >> "${cache}"
    fi
    # escape leading "-"
    if [ "-" = "${cur:0:1}" ]; then
      cur="\\"${cur}
    fi

    if [ "${prev}" = "-p" ]; then
      _probcli_pref_opts
    else
      _probcli_common_opts
    fi

    # filter options if we have a current prefix
    if [ $cur ]; then
      opts=$( for i in ${opts[@]} ; do echo $i ; done | grep "^${cur}" )
    fi

    COMPREPLY=( $opts )
}
complete -o bashdefault -o default -o nospace -F _probcli probcli.sh
complete -o bashdefault -o default -o nospace -F _probcli probcli
