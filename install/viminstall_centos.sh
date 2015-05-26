#!/bin/sh
# vim:set ts=8 sts=2 sw=2 tw=0 expandtab foldmethod=marker:

# 環境ごとの設定 {{{
__VIM_ENABLE_GUI=no
# }}}

# パッケージインストール関数定義 {{{
install_pkg() {
  root_exec yum -y install $@
}
# }}}

# ライブラリインストール関数定義 {{{
install_libs() {
  # TODO luajit はコンパイルしなければならない
  #   - luajit (+lua)

  # Vimのビルドに必要
  #   - "Development Tools"(Ubuntu の build-essential に相当)
  #   - gettext
  #   - ncurses-devel
  # その他、スクリプト言語
  #   - lua-devel (+lua)
  #   - perl-devel (+perl)
  #   - python-devel (+python)
  #   - ruby-devel (+ruby)
  #   - tcl-devel (+tcl)

  root_exec yum -y groupinstall "Development Tools"
  _res=$?
  if [ $_res -ne 0 ]; then
    error 'Development Tools をインストールできませんでした'
    return $_res
  fi

  install_pkg \
    gettext \
    ncurses-devel \
    lua-devel \
    python-devel \
    ruby-devel \
  _res=$?
  if [ $_res -ne 0 ]; then
    return $_res
  fi

  # TODO ここでluajitをコンパイルする
  # if [ $_res -ne 0 ]; then
  #   error 'luajit をインストールできませんでした'
  #   return $_res
  # fi
}
# }}}