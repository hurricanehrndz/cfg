# vim:set ft=zsh sw=2 sts=2 ts=2 et:

# grc
if [[ "$OS_NAME" == "Darwin" ]]; then
  [[ -s "/usr/local/etc/grc.zsh" ]] && source /usr/local/etc/grc.zsh
  [[ -s "/opt/homebrew/etc/grc.zsh" ]] && source /opt/homebrew/etc/grc.zsh
else
  [[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh
fi
