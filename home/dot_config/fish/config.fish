# Remove intro greeting
set -U fish_greeting

fish_add_path ~/.local/bin
fish_add_path /opt/homebrew/opt/llvm/bin

source ~/.config/fish/secrets.fish

set -gx EDITOR 'zed --wait'

set -gx GPG_TTY (tty)
set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# ----- SET UP TOOLS -----
direnv hook fish | source
zoxide init fish | source
thefuck --alias | source
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
test -r '/Users/bsoyka/.opam/opam-init/init.fish' && source '/Users/bsoyka/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
