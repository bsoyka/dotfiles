fish_add_path ~/.local/bin

source ~/.config/fish/secrets.fish

# ----- SET UP TOOLS -----
direnv hook fish | source
zoxide init fish | source
thefuck --alias | source
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
test -r '/Users/bsoyka/.opam/opam-init/init.fish' && source '/Users/bsoyka/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
