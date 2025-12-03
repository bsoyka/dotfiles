set PATH $PATH /Users/bsoyka/.local/bin

source ~/.config/fish/secrets.fish

direnv hook fish | source

zoxide init fish | source

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

abbr --add cdgh cd ~/Documents/GitHub

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/Users/bsoyka/.opam/opam-init/init.fish' && source '/Users/bsoyka/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
