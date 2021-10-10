# vim:set ft=zsh :

if [[ -e "/usr/share/zsh/vendor-completions" ]]; then
  fpath=($HOME/.local/share/zsh/completions $fpath)
fi

if [[ -e "/usr/local/share/zsh/vendor-completions" ]]; then
  fpath=(/usr/local/share/zsh/vendor-completions $fpath)
fi

if [[ -e "/usr/share/zsh/vendor-completions" ]]; then
  fpath=(/usr/share/zsh/vendor-completions $fpath)
fi

if [[ -e "/usr/share/zsh/site-functions" ]]; then
  fpath=(/usr/share/zsh/site-functions $fpath)
fi
