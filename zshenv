# TERMの指定
export TERM=xterm-256color

export GOROOT=/usr/local/go

# go getのためにGOPATHを設定
export GOPATH=$HOME/.go

# PATH設定
# パスの場所が存在しない可能性があるなら、末尾に(N-/)をつける
path=(
  $GOROOT/bin(N-/)
  ~/bin(N-/)
  ~/.local/bin(N-/)
  $GOPATH/bin(N-/)
  ~/.composer/vendor/bin(N-/)
  $path
)

# vim:set ts=8 sts=2 sw=2 tw=0 expandtab foldmethod=marker:
