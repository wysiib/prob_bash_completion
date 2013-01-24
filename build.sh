#!/bin/sh
if [ -z "$PROBCLI" ]; then
	echo "PROBCLI needs to be set"
	exit
fi
${PROBCLI} -h -v > cache.txt

pref_opts=$(cat cache.txt \
			| grep '^\s\{1,\}[A-Z]\w*\s\{1,\}:' \
			| awk '{print $1}')

opts=$(cat cache.txt \
		| grep '^\s\{1,\}\-\{1,\}\w' \
		| awk '{ print $1 }')
rm cache.txt &> /dev/null

opts=${opts//$'\n'/' '}
pref_opts=${pref_opts//$'\n'/' '}

sed -e "s/%{opts}/\"${opts}\"/g" \
		-e "s/%{pref_opts}/\"${pref_opts}\"/g" \
		completion.template > prob_completion.sh
