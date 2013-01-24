ProB Bash Completion
====================

This tool generates bash completion information for the probcli tool.

To generate the completion information run `make` and pass the path to the probcli binary in the PROBCLI variable.

```
make PROBCLI=<path to probcli>
```

This generates a prob\_completion.sh file. Sourcing this file will enable
autocompletion support for probcli and probcli.sh.
